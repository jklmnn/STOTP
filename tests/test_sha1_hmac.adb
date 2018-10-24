with Ada.Text_IO;

with LSC.Byteorder32;
with LSC.Types;
with LSC.Byte_Arrays;
with LSC.SHA1;
with LSC.HMAC_SHA1;
with HMAC;
use all type LSC.Types.Index;
use all type LSC.Byte_Arrays.Byte_Array_Type;

procedure Test_Sha1_Hmac
  with SPARK_Mode
is
   Key     : LSC.Byte_Arrays.Byte_Array_Type := (16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                                 16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                                 16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                                 16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                                 16#0b#, 16#0b#, 16#0b#, 16#0b#);
   Message : LSC.Byte_Arrays.Byte_Array_Type := (16#48#, 16#69#, 16#20#, 16#54#,
                                                 16#68#, 16#65#, 16#72#, 16#65#);
   Hash    : HMAC.HMAC_Type := (16#b6#, 16#17#, 16#31#, 16#86#,
                                16#55#, 16#05#, 16#72#, 16#64#,
                                16#e2#, 16#8b#, 16#c0#, 16#b6#,
                                16#fb#, 16#37#, 16#8c#, 16#8e#,
                                16#f1#, 16#46#, 16#be#, 16#00#);
begin

   pragma Warnings (Off, "no Global contract");
   Ada.Text_Io.Put_Line (Boolean'Image (
                         HMAC.SHA1 (Key, Message) = Hash));
end Test_Sha1_Hmac;
