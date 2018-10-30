with LSC.Byte_Arrays;
use all type LSC.Byte_Arrays.Byte_Array_Type;

package body HMAC.Test
with SPARK_Mode
is

   ---------
   -- Run --
   ---------

   function Run return String is
      Key     : constant LSC.Byte_Arrays.Byte_Array_Type :=
        (16#0b#, 16#0b#, 16#0b#, 16#0b#,
         16#0b#, 16#0b#, 16#0b#, 16#0b#,
         16#0b#, 16#0b#, 16#0b#, 16#0b#,
         16#0b#, 16#0b#, 16#0b#, 16#0b#,
         16#0b#, 16#0b#, 16#0b#, 16#0b#);
      Message : constant LSC.Byte_Arrays.Byte_Array_Type :=
        (16#48#, 16#69#, 16#20#, 16#54#,
         16#68#, 16#65#, 16#72#, 16#65#);
      Hash    : constant HMAC.HMAC_Type :=
        (16#b6#, 16#17#, 16#31#, 16#86#,
         16#55#, 16#05#, 16#72#, 16#64#,
         16#e2#, 16#8b#, 16#c0#, 16#b6#,
         16#fb#, 16#37#, 16#8c#, 16#8e#,
         16#f1#, 16#46#, 16#be#, 16#00#);
   begin
      if HMAC.SHA1 (Key, Message) /= Hash then
         return "Calculating HMAC failed";
      end if;
      return "PASSED";
   end Run;

end HMAC.Test;
