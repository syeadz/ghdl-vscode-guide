-- Testbench for 1-bit adder
-- Contains 8 test cases covering all possible inputs

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder1bit_tb is
end;

architecture rtl of adder1bit_tb is
  signal a_tb, b_tb, cin_tb : std_logic;
  signal sum_tb, cout_tb    : std_logic;

  signal sim_end  : boolean := false;
  constant period : time    := 50 ns;
begin

  -- Component declaration style also works, but we can also use work.[entity_name] as long
  -- as the entity is built
  uut : entity work.adder1bit
    port map
    (
      a    => a_tb,
      b    => b_tb,
      cin  => cin_tb,
      sum  => sum_tb,
      cout => cout_tb
    );

    -- This is a clock process that generates a clock signal
    -- required for certain designs. It is not needed for this
    -- clock_process : process
    -- begin
    --   while (not sim_end) loop
    --     clk_tb <= '1';
    --     wait for period/2;
    --     clk_tb <= '0';
    --     wait for period/2;
    --   end loop;
    --   wait;
    -- end process;


  stim_proc : process
  begin
    -- Test 1: a = 0, b = 0, cin = 0
    a_tb <= '0';
    b_tb <= '0';
    cin_tb <= '0';
    wait for period;
    assert (sum_tb = '0' and cout_tb = '0') report "Test 1 failed" severity error;

    -- Test 2: a = 1, b = 0, cin = 0
    a_tb <= '1';
    b_tb <= '0';
    cin_tb <= '0';
    wait for period;
    assert (sum_tb = '1' and cout_tb = '0') report "Test 2 failed" severity error;

    -- Test 3: a = 0, b = 1, cin = 0
    a_tb <= '0';
    b_tb <= '1';
    cin_tb <= '0';
    wait for period;
    assert (sum_tb = '1' and cout_tb = '0') report "Test 3 failed" severity error;

    -- Test 4: a = 1, b = 1, cin = 0
    a_tb <= '1';
    b_tb <= '1';
    cin_tb <= '0';
    wait for period;
    assert (sum_tb = '0' and cout_tb = '1') report "Test 4 failed" severity error;

    -- Test 5: a = 0, b = 0, cin = 1
    a_tb <= '0';
    b_tb <= '0';
    cin_tb <= '1';
    wait for period;
    assert (sum_tb = '1' and cout_tb = '0') report "Test 5 failed" severity error;

    -- Test 6: a = 1, b = 0, cin = 1
    a_tb <= '1';
    b_tb <= '0';
    cin_tb <= '1';
    wait for period;
    assert (sum_tb = '0' and cout_tb = '1') report "Test 6 failed" severity error;

    -- Test 7: a = 0, b = 1, cin = 1
    a_tb <= '0';
    b_tb <= '1';
    cin_tb <= '1';
    wait for period;
    assert (sum_tb = '0' and cout_tb = '1') report "Test 7 failed" severity error;

    -- Test 8: a = 1, b = 1, cin = 1
    a_tb <= '1';
    b_tb <= '1';
    cin_tb <= '1';
    wait for period;
    assert (sum_tb = '1' and cout_tb = '1') report "Test 8 failed" severity error;

    sim_end <= true;
    wait;
  end process;

end architecture;
