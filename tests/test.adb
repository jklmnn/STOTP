with Ada.Text_IO;
with Ada.Command_Line;

with Base32.Test;
with HMAC.Test;
with OTP.Test;
with OTP.H.Test;
with TOTP_Test;

procedure Test
with SPARK_Mode
is
   procedure Eval
     (Name   : String;
      Result : String;
      Passed : in out Boolean)
     with
       Pre =>
         Name'Length <= 128
         and Result'Length <= 128;
   procedure Eval
     (Name   : String;
      Result : String;
      Passed : in out Boolean)
   is
      PName : String (1 .. Name'Length) := Name (Name'First .. Name'Last);
      PResult : String (1 .. Result'Length) := Result (Result'First .. Result'Last);
   begin
      pragma Warnings (Off, "no Global contract");
      Passed := Passed and Result = "PASSED";
      Ada.Text_IO.Put_Line (PName & " : " & PResult);
   end Eval;
   Passed : Boolean := True;
begin
   pragma Warnings (Off, "no Global contract");
   Eval (Base32.Test.Name, Base32.Test.Run, Passed);
   Eval (HMAC.Test.Name, HMAC.Test.Run, Passed);
   Eval (OTP.Test.Name, OTP.Test.Run, Passed);
   Eval (OTP.H.Test.Name, OTP.H.Test.Run, Passed);
   Eval (TOTP_Test.Name, TOTP_Test.Run, Passed);
   if not Passed then
      Ada.Command_Line.Set_Exit_Status (1);
   end if;
end Test;
