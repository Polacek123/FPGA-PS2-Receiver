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
    -- Sygnały wewnętrzne i stany maszyny FSM
begin

    -- Logika działania odbiornika i filtrów
    
end Behavioral;