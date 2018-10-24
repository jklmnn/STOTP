with Ada.Text_Io;
with LSC.Byte_Arrays;
with HOTP;
use all type HOTP.HOTP_Token;
use all type HOTP.HOTP_Value;

procedure Test_HOTP
is
   Hmac : LSC.Byte_Arrays.HMAC := (16#1f#, 16#86#, 16#89#, 16#69#,
                                   16#0e#, 16#02#, 16#ca#, 16#16#,
                                   16#61#, 16#85#, 16#50#, 16#ef#,
                                   16#7f#, 16#19#, 16#da#, 16#8e#,
                                   16#94#, 16#5b#, 16#55#, 16#5a#);
   Token : HOTP.HOTP_Token := 16#50ef7f19#;
   Value : HOTP.HOTP_Value := "872921";
begin
   Ada.Text_Io.Put_Line (Boolean'Image (HOTP.Extract (Hmac) = Token));
   Ada.Text_Io.Put_Line (Boolean'Image (HOTP.Image (Token, 6) = Value));
end Test_HOTP;
