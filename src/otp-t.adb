with OTP.H;

package body OTP.T
with SPARK_Mode
is

   ----------
   -- TOTP --
   ----------

   function TOTP
     (Key  : LSC.Byte_Arrays.Byte_Array_Type;
      Time : LSC.Types.Word64;
      X    : LSC.Types.Word64 := 30;
      T0   : LSC.Types.Word64 := 0)
      return OTP_Token
   is
   begin
      return OTP.H.HOTP (Key, (Time - T0) / X);
   end TOTP;

end OTP.T;
