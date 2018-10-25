with LSC.Types;
with LSC.Byte_Arrays;
with HMAC;
use all type LSC.Types.Index;

package OTP.H
with SPARK_Mode
is

   function HOTP
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Counter : LSC.Types.Word64)
      return OTP_Token
     with
       Pre => Key'Length <= 64;

   function Extract
     (Mac : HMAC.HMAC_Type)
      return OTP_Token;

end OTP.H;
