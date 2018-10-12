with Ada.Command_Line;
with Ada.Text_IO;
with Interfaces;

with Base32;
with Base32.LSC_Types;
with LSC.SHA1;
with LSC.HMAC_SHA1;

procedure sha1_hmac is
   function HMAC (Key : String;
                  Msg : String) return String
   is
      use Interfaces;
--        BKey : LSC.SHA1.Block_Type := (others => 0);
--        BMsg : LSC.SHA1.Message_Type (1 .. 1) := (others => BKey);
      BKey : LSC.SHA1.Block_Type := Base32.LSC_Types.
        Buffer_To_Sha1_Block_Type (Base32.Decode(Key));
      BMsg : LSC.SHA1.Message_Type (1 .. 1) := (others => Base32.LSC_Types.
        Buffer_To_Sha1_Block_Type (Base32.Decode (Msg)));
      Hash : LSC.SHA1.Hash_Type := LSC.HMAC_SHA1.Authenticate (BKey, BMsg, Msg'Length * 5);
      Hex : String (1 .. 40) := (others => '_');
      Byte : Unsigned_8;
      function Nth (Nibble : Unsigned_8) return Character is
        (if Nibble < 10 then Character'Val (Nibble + 48) else Character'Val (Nibble + 87));
      HI : Integer := 1;
   begin
--        Ada.Text_Io.Put_Line (Msg & " " & Integer'Image (Msg'Length));
--        Ada.Text_Io.Put_Line ("Key:");
--        for Word of BKey loop
--           Ada.Text_IO.Put_Line (Unsigned_32'Image (Word));
--        end loop;
--        Ada.Text_Io.Put_Line ("Msg:");
--        for Word of BMsg (1) loop
--           Ada.Text_Io.Put_Line (Unsigned_32'Image (Word));
--        end loop;
      for Index in Hash'Range loop
--         Ada.Text_IO.Put_Line (Unsigned_32'Image (Hash (Index)));
         for I in Integer range 0 .. 3 loop
            Byte := Unsigned_8 (Shift_Right (Hash (Index), (3 - I) * 8) and 255);
            --  Ada.Text_IO.Put_Line (Integer'Image (HI));
            --  Ada.Text_IO.Put_Line (Unsigned_8'Image (Byte and 15));
            Hex (HI + 1) := Nth (Byte and 15);
            Hex (Hi) := Nth (Shift_Right (Byte, 4) and 15);
            HI := HI + 2;
         end loop;
      end loop;
      return Hex;
   end HMAC;
begin
   if Ada.Command_Line.Argument_Count = 2 then
      Ada.Text_IO.Put_Line (HMAC (
                            Base32.Encode_String (Ada.Command_Line.Argument (1)),
                            Base32.Encode_String (Ada.Command_Line.Argument (2))));

   else
      Ada.Text_IO.Put_Line ("Usage: sha1_hmac <key> <message>");
   end if;
end;
