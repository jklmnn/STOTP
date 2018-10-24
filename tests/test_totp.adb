with Ada.Text_Io;
with LSC.Types;
with LSC.Byte_Arrays;
with OTP;
with OTP.T;

procedure Test_TOTP
  with SPARK_Mode
is
   package TOTP is new OTP.T;
   Key : LSC.Byte_Arrays.Byte_Array_Type := (16#31#, 16#32#, 16#33#, 16#34#,
                                             16#35#, 16#36#, 16#37#, 16#38#,
                                             16#39#, 16#30#, 16#31#, 16#32#,
                                             16#33#, 16#34#, 16#35#, 16#36#,
                                             16#37#, 16#38#, 16#39#, 16#30#);
   Time : LSC.Types.Word64 := 59;
   Totp_Value : OTP.OTP_Value := "94287082";
begin
   pragma Warnings (Off, "no Global contract");
   Ada.Text_Io.Put_Line (Boolean'Image (
                         OTP.Image (TOTP.TOTP (Key, Time), 8) = Totp_Value));
end Test_TOTP;
