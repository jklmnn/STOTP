with Ada.Command_Line;
with ADa.Text_IO;
with Base32;

procedure Base32_Encode is
begin
   for A in Integer range 1 .. Ada.Command_Line.Argument_Count loop
      Ada.Text_IO.Put_Line (Base32.Encode_String (Ada.Command_Line.Argument (A)));
   end loop;
end Base32_Encode;
