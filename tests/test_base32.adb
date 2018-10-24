with ADa.Text_IO;
with Base32;

procedure Test_Base32
  with SPARK_Mode
is
   Test_Plain         : constant String := "test1";
   Test_Encoded       : constant Base32.Base32_String := "ORSXG5BR";
   Test_Encoded_Lower : constant Base32.Base32_String := "orsxg5br";
begin
   pragma Warnings (Off, "no Global contract");
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Encode_String (Test_Plain) = Test_Encoded));
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Decode_String (Test_Encoded) = Test_Plain));
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Decode_String (Test_Encoded_Lower) = Test_Plain));
end Test_Base32;
