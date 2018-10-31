with LSC.Types;
with LSC.Byte_Arrays;
with HMAC;
use all type LSC.Types.Index;

--  @summary
--  HMAC based One-Time-Pad
--
--  @description
--  Calculates the SHA1 OTP based on RFC 4426
package OTP.H
with SPARK_Mode
is

   --  Calculates the HOTP Token from a given Key and Counter
   --  @param Key HMAC key
   --  @param Counter
   --  @return HOTP token as 31bit word
   function HOTP
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Counter : LSC.Types.Word64)
      return OTP_Token
     with
       Depends => (HOTP'Result => (Key, Counter)),
       Pre => Key'Length <= 64;

private

   --  @private Only used to generate the token
   function Extract
     (Mac : HMAC.HMAC_Type)
      return OTP_Token
     with
       Depends => (Extract'Result => Mac);

end OTP.H;
