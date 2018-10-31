with System;
with Ada.Text_IO;
with Ada.Command_Line;
with LSC.Types;
with LSC.Byte_Arrays;
with OTP;
with OTP.T;
with Base32;

procedure Generate_2fa_Token
  with SPARK_Mode
is
   function Time (Tloc : System.Address) return LSC.Types.Word64
     with
       Import,
       Convention => C,
       External_Name => "time";
begin
   pragma Assert (LSC.Byte_Arrays.Natural_Index'Last / 5 > 32);
   pragma Warnings (Off, "no Global contract");
   if Ada.Command_Line.Argument_Count = 1 and then
     Ada.Command_Line.Argument (1)'Length >= 8 and then
     Ada.Command_Line.Argument (1)'Length <= 40 and then
     (Ada.Command_Line.Argument (1)'length mod 8 = 0 and
     (for all C of Ada.Command_Line.Argument (1) =>
          Base32.Valid_Base32_Character (C)))
   then
      Ada.Text_IO.Put_Line (OTP.Image (OTP.T.TOTP (
                            Base32.Decode (Ada.Command_Line.Argument (1)),
                            Time (System.Null_Address)), 6));
   else
      Ada.Text_IO.Put_Line ("Usage: generate_2fa_token <base32 key (8, 16, 24, 32, 40 char)>");
   end if;
end Generate_2fa_Token;
