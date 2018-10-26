with LSC.Byte_Arrays;
use all type LSC.Byte_Arrays.Byte_Array_Type;

-- @summary
-- HMAC wrapper
--
-- @description
-- Wrapper around libsparkcryptos HMAC_SHA1.Authenticate that uses byte arrays
-- instead of 32bit word arrays
package HMAC
with SPARK_Mode
is

   -- Byte array of length 20
   subtype HMAC_Type is LSC.Byte_Arrays.Byte_Array_Type (1 .. 20);

   function SHA1
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Msg : LSC.Byte_Arrays.Byte_Array_Type)
      return HMAC_Type
     with
       Depends => (SHA1'Result => (Key, Msg)),
       Pre =>  Key'Length <= 64
       and Msg'Length <= 64;

end HMAC;
