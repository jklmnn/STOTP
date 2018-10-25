with LSC.Byte_Arrays;
use all type LSC.Byte_Arrays.Byte_Array_Type;

package HMAC
with SPARK_Mode
is

   subtype HMAC_Type is LSC.Byte_Arrays.Byte_Array_Type (1 .. 20);

   function SHA1
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Msg : LSC.Byte_Arrays.Byte_Array_Type)
      return HMAC_Type
     with
       Pre =>  Key'Length <= 64
       and Msg'Length <= 64;

end HMAC;
