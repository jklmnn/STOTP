with ADa.Text_IO;
with Base32;

procedure Test_Base32 is
   Test_Plain         : String := "test1";
   Test_Encoded       : String := "ORSXG5BR";
   Test_Encoded_Lower : String := "orsxg5br";
begin
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Encode_String (Test_Plain) = Test_Encoded));
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Decode_String (Test_Encoded) = Test_Plain));
   Ada.Text_IO.Put_Line (Boolean'Image (
                         Base32.Decode_String (Test_Encoded_Lower) = Test_Plain));
end Test_Base32;
