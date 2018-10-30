with Interfaces;
with OTP.H;
use all type Interfaces.Unsigned_64;

package body OTP.T
is

   ----------
   -- TOTP --
   ----------

   function TOTP
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Time : LSC.Types.Word64)
      return OTP_Token
   is
   begin
      return OTP.H.HOTP (Key, (Time - T0) / X);
   end TOTP;

end OTP.T;
