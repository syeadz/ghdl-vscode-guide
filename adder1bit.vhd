-- 1-bit full adder

library ieee;
use ieee.std_logic_1164.all;

entity adder1bit is
  port
  (
    a, b, cin : in std_logic;
    cout, sum : out std_logic
  );
end;

architecture rtl of adder1bit is

begin

sum <= a xor b xor cin;
cout <= (not a and b and cin) or (a and not b and cin) or (a and b and not cin) or (a and b and cin);

end architecture;