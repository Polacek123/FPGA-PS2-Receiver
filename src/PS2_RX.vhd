library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PS2_RX is
    Port (
        Clk_100MHz : in  STD_LOGIC;
        PS2_Clk    : in  STD_LOGIC;
        PS2_Data   : in  STD_LOGIC;
        PS2_DO     : out STD_LOGIC_VECTOR (7 downto 0);
        PS2_DOrdy  : out STD_LOGIC
    );
end PS2_RX;

architecture Behavioral of PS2_RX is
    type state_type is (IDLE, READ_DATA, CHECK_PARITY, CHECK_STOP);

    constant FILTER_MAX : unsigned(7 downto 0) := X"FF";

    signal state       : state_type := IDLE;
    signal bit_count   : unsigned(2 downto 0) := (others => '0');
    signal data_shift  : std_logic_vector(7 downto 0) := (others => '0');
    signal parity_bit  : std_logic := '0';

    signal ps2_clk_meta  : std_logic := '1';
    signal ps2_clk_sync  : std_logic := '1';
    signal ps2_data_meta : std_logic := '1';
    signal ps2_data_sync : std_logic := '1';

    signal clk_filtered      : std_logic := '1';
    signal clk_filtered_prev : std_logic := '1';
    signal filter_count      : unsigned(7 downto 0) := (others => '0');
    signal fall_edge         : std_logic := '0';

    signal do_reg    : std_logic_vector(7 downto 0) := (others => '0');
    signal dordy_reg : std_logic := '0';

    function odd_parity_ok(
        data_value   : std_logic_vector(7 downto 0);
        parity_value : std_logic
    ) return boolean is
        variable parity_sum : std_logic := '0';
    begin
        for i in data_value'range loop
            parity_sum := parity_sum xor data_value(i);
        end loop;

        return (parity_sum xor parity_value) = '1';
    end function;
begin

    PS2_DO    <= do_reg;
    PS2_DOrdy <= dordy_reg;

    process (Clk_100MHz)
    begin
        if rising_edge(Clk_100MHz) then
            -- Synchronizacja sygnalow zewnetrznych do domeny zegara FPGA.
            ps2_clk_meta  <= PS2_Clk;
            ps2_clk_sync  <= ps2_clk_meta;
            ps2_data_meta <= PS2_Data;
            ps2_data_sync <= ps2_data_meta;

            -- Filtr zegara PS/2: zmiana jest akceptowana dopiero po czasie stabilnosci.
            clk_filtered_prev <= clk_filtered;
            if ps2_clk_sync = clk_filtered then
                filter_count <= (others => '0');
            elsif filter_count = FILTER_MAX then
                clk_filtered <= ps2_clk_sync;
                filter_count <= (others => '0');
            else
                filter_count <= filter_count + 1;
            end if;

            if clk_filtered_prev = '1' and clk_filtered = '0' then
                fall_edge <= '1';
            else
                fall_edge <= '0';
            end if;
            dordy_reg <= '0';

            case state is
                when IDLE =>
                    bit_count <= (others => '0');
                    if fall_edge = '1' and ps2_data_sync = '0' then
                        state <= READ_DATA;
                    end if;

                when READ_DATA =>
                    if fall_edge = '1' then
                        data_shift(to_integer(bit_count)) <= ps2_data_sync;

                        if bit_count = "111" then
                            bit_count <= (others => '0');
                            state <= CHECK_PARITY;
                        else
                            bit_count <= bit_count + 1;
                        end if;
                    end if;

                when CHECK_PARITY =>
                    if fall_edge = '1' then
                        parity_bit <= ps2_data_sync;
                        state <= CHECK_STOP;
                    end if;

                when CHECK_STOP =>
                    if fall_edge = '1' then
                        if ps2_data_sync = '1' and odd_parity_ok(data_shift, parity_bit) then
                            do_reg <= data_shift;
                            dordy_reg <= '1';
                        end if;

                        state <= IDLE;
                    end if;
            end case;
        end if;
    end process;

end Behavioral;
