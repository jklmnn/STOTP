with OTP;
with OTP.T;
with LSC.Types;
with LSC.Byte_Arrays;

package body OTP.T.Test
with SPARK_Mode
is

   ---------
   -- Run --
   ---------

   function Run return String is
      Key : constant LSC.Byte_Arrays.Byte_Array_Type :=
        (16#31#, 16#32#, 16#33#, 16#34#,
         16#35#, 16#36#, 16#37#, 16#38#,
         16#39#, 16#30#, 16#31#, 16#32#,
         16#33#, 16#34#, 16#35#, 16#36#,
         16#37#, 16#38#, 16#39#, 16#30#);
      Time : constant LSC.Types.Word64 := 59;
      Totp_Value : constant  OTP.OTP_Value := "94287082";
   begin
      if OTP.Image (OTP.T.TOTP (Key, Time), 8) /= Totp_Value then
         return "Calculating TOTP value failed";
      end if;
      return "PASSED";
   end Run;

end OTP.T.Test;
