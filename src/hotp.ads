with LSC.Types;
with LSC.Byte_Arrays;
with HMAC;
use all type LSC.Types.Index;

package HOTP
with SPARK_Mode
is

   subtype HOTP_Value is String
     with
       Dynamic_Predicate =>
         (for all C of HOTP_Value =>
            Character'Pos (C) > 47 and Character'Pos (C) < 58);

   subtype HOTP_Token is Integer range 0 .. 2 ** 31 - 1;

   function HOTP
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Counter : LSC.Types.Word64)
      return HOTP_Token
     with
       Pre => Key'Length mod 4 = 0 and Key'Length <= 64;

   function Image
     (H : HOTP_Token;
      D : Positive := 6)
      return HOTP_Value
     with
       Pre => D >= 6,
       Post => Image'Result'Length = D;

   function Extract
     (Mac : HMAC.HMAC_Type)
      return HOTP_Token;

end HOTP;
