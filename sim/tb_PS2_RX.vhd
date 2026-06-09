library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_PS2_RX is
end tb_PS2_RX;

architecture sim of tb_PS2_RX is
    constant CLK_PERIOD : time := 10 ns;
    constant PS2_HALF   : time := 35 us;

    signal Clk_100MHz : std_logic := '0';
    signal PS2_Clk    : std_logic := '1';
    signal PS2_Data   : std_logic := '1';
    signal PS2_DO     : std_logic_vector(7 downto 0);
    signal PS2_DOrdy  : std_logic;

    procedure send_ps2_bit(
        signal ps2_clk_s  : out std_logic;
        signal ps2_data_s : out std_logic;
        constant bit_val  : in  std_logic
    ) is
    begin
        ps2_data_s <= bit_val;
        wait for PS2_HALF;
        ps2_clk_s <= '0';
        wait for PS2_HALF;
        ps2_clk_s <= '1';
        wait for PS2_HALF;
    end procedure;

    procedure send_ps2_byte(
        signal ps2_clk_s  : out std_logic;
        signal ps2_data_s : out std_logic;
        constant data_val : in  std_logic_vector(7 downto 0)
    ) is
        variable parity_bit : std_logic := '1';
    begin
        for i in data_val'range loop
            parity_bit := parity_bit xor data_val(i);
        end loop;

        send_ps2_bit(ps2_clk_s, ps2_data_s, '0');

        for i in 0 to 7 loop
            send_ps2_bit(ps2_clk_s, ps2_data_s, data_val(i));
        end loop;

        send_ps2_bit(ps2_clk_s, ps2_data_s, parity_bit);
        send_ps2_bit(ps2_clk_s, ps2_data_s, '1');
        ps2_data_s <= '1';
    end procedure;
begin

    Clk_100MHz <= not Clk_100MHz after CLK_PERIOD / 2;

    uut: entity work.PS2_RX
        port map (
            Clk_100MHz => Clk_100MHz,
            PS2_Clk    => PS2_Clk,
            PS2_Data   => PS2_Data,
            PS2_DO     => PS2_DO,
            PS2_DOrdy  => PS2_DOrdy
        );

    stimulus: process
    begin
        wait for 100 us;

        send_ps2_byte(PS2_Clk, PS2_Data, X"1C");
        wait until rising_edge(Clk_100MHz) and PS2_DOrdy = '1';
        assert PS2_DO = X"1C"
            report "Blad: odebrano inny bajt niz 0x1C"
            severity failure;

        wait for 500 us;

        send_ps2_byte(PS2_Clk, PS2_Data, X"F0");
        wait until rising_edge(Clk_100MHz) and PS2_DOrdy = '1';
        assert PS2_DO = X"F0"
            report "Blad: odebrano inny bajt niz 0xF0"
            severity failure;

        wait for 500 us;

        send_ps2_byte(PS2_Clk, PS2_Data, X"1C");
        wait until rising_edge(Clk_100MHz) and PS2_DOrdy = '1';
        assert PS2_DO = X"1C"
            report "Blad: odebrano inny bajt niz 0x1C po break code"
            severity failure;

        wait for 200 us;
        assert false report "Koniec symulacji - test zakonczony poprawnie" severity note;
        wait;
    end process;

end sim;
