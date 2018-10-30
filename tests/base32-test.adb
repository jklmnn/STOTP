package body Base32.Test
with SPARK_Mode
is

   ---------
   -- Run --
   ---------

   function Run return String is
      Test_Plain         : constant String := "test1";
      Test_Encoded       : constant Base32.Base32_String := "ORSXG5BR";
      Test_Encoded_Lower : constant Base32.Base32_String := "orsxg5br";
   begin
      if Base32.Encode_String (Test_Plain) /= Test_Encoded then
         return "Encode failed";
      end if;
      if Base32.Decode_String (Test_Encoded) /= Test_Plain then
         return "Decode upper case failed";
      end if;
      if Base32.Decode_String (Test_Encoded_Lower) /= Test_Plain then
         return "Decode lower case failed";
      end if;
      return "PASSED";
   end Run;

end Base32.Test;
