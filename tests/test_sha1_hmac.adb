with Ada.Text_IO;

with LSC.Byteorder32;
with LSC.Types;
with LSC.Byte_Arrays;
with LSC.SHA1;
with LSC.HMAC_SHA1;
use all type LSC.Types.Index;
use all type LSC.Byte_Arrays.Byte_Array_Type;

procedure Test_Sha1_Hmac
  with SPARK_Mode
is
   subtype Message1_Index is LSC.Types.Word64 range 1 .. 1;
   subtype Message1_Type is LSC.SHA1.Message_Type (Message1_Index);
   Key             : LSC.SHA1.Block_Type := (others => 0);
   Message1        : LSC.SHA1.Message_Type (1 .. 1);
   Message_Block   : LSC.SHA1.Block_Type := (others => 0);
   Hash            : LSC.Byte_Arrays.Byte_Array_Type (1 .. 20) :=
                       LSC.Byte_Arrays.Byte_Array_Type'(16#b6#, 16#17#, 16#31#, 16#86#,
                                                        16#55#, 16#05#, 16#72#, 16#64#,
                                                        16#e2#, 16#8b#, 16#c0#, 16#b6#,
                                                        16#fb#, 16#37#, 16#8c#, 16#8e#,
                                                        16#f1#, 16#46#, 16#be#, 16#00#);
begin
   Key (Key'First .. Key'First + 4) :=
     LSC.Byte_Arrays.To_Word32_Array (LSC.Byte_Arrays.Byte_Array_Type'
                                        (16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                         16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                         16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                         16#0b#, 16#0b#, 16#0b#, 16#0b#,
                                         16#0b#, 16#0b#, 16#0b#, 16#0b#));

   -- "Hi There"
   Message_Block (Message_Block'First .. Message_Block'First + 1) :=
     LSC.Byte_Arrays.To_Word32_Array (LSC.Byte_Arrays.Byte_Array_Type'(
                                      16#48#, 16#69#, 16#20#, 16#54#,
                                      16#68#, 16#65#, 16#72#, 16#65#));
   Message1 := Message1_Type'
     (1 => Message_Block);

   Message_Block (Message_Block'First .. Message_Block'First + 4) :=
     LSC.Byte_Arrays.To_Word32_Array (LSC.Byte_Arrays.Byte_Array_Type'
                                        (16#b6#, 16#17#, 16#31#, 16#86#,
                                         16#55#, 16#05#, 16#72#, 16#64#,
                                         16#e2#, 16#8b#, 16#c0#, 16#b6#,
                                         16#fb#, 16#37#, 16#8c#, 16#8e#,
                                         16#f1#, 16#46#, 16#be#, 16#00#));


   pragma Warnings (Off, "no Global contract");
   Ada.Text_IO.Put_Line (Boolean'Image (
                         LSC.Byte_Arrays.To_Byte_Array (
                           LSC.HMAC_SHA1.Authenticate (Key, Message1, 64)) =
                           Hash));
end Test_Sha1_Hmac;
