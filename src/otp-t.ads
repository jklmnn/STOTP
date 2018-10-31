with LSC.Types;
with LSC.Byte_Arrays;
use all type LSC.Types.Word64;

--  @summary
--  Time based One-Time-Pad
--
--  @description
--  Calculates the Time based One-Time-Pad based on RFC 6238

package OTP.T
with SPARK_Mode
is

   --  Calculates the TOTP Token from a given key and time offset
   --  @param HMAC key
   --  @param Current time
   --  @param X Time step size
   --  @param T0 Reference time
   --  @return TOTP Token as 31bit word
   function TOTP
     (Key  : LSC.Byte_Arrays.Byte_Array_Type;
      Time : LSC.Types.Word64;
      X    : LSC.Types.Word64 := 30;
      T0   : LSC.Types.Word64 := 0)
      return OTP_Token
     with
       Depends => (TOTP'Result => (Key, Time, X, T0)),
       Pre => Key'Length <= 64 and X > 0;

end OTP.T;
