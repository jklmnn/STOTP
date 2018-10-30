with Interfaces;
with LSC.Types;
with LSC.SHA1;
with LSC.HMAC_SHA1;
with LSC.Byte_Arrays.Pad;
use all type Interfaces.Unsigned_64;
use all type LSC.Types.Index;

package body HMAC
with SPARK_Mode
is

   ----------
   -- SHA1 --
   ----------

   function SHA1
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Msg : LSC.Byte_Arrays.Byte_Array_Type)
      return HMAC_Type
   is
      package Pad4 is new LSC.Byte_Arrays.Pad (4);
      K    : LSC.SHA1.Block_Type := (others => 0);
      MB   : LSC.SHA1.Block_Type := (others => 0);
      M    : LSC.SHA1.Message_Type (1 .. 1) := (others => MB);
      Hash : LSC.SHA1.Hash_Type;

      Padded_Key : constant LSC.Byte_Arrays.Byte_Array_Type := Pad4.Pad (Key);
      Padded_Msg : constant LSC.Byte_Arrays.Byte_Array_Type := Pad4.Pad (Msg);
   begin
      K (K'First .. K'First + (Padded_Key'Length / 4) - 1) :=
        LSC.Byte_Arrays.To_Word32_Array (Padded_Key);
      MB (MB'First .. MB'First + (Padded_Msg'Length / 4) - 1) :=
        LSC.Byte_Arrays.To_Word32_Array (Padded_Msg);
      M (1) := MB;
      Hash := LSC.HMAC_SHA1.Authenticate (K, M, Msg'Length * 8);
      return LSC.Byte_Arrays.To_Byte_Array (Hash);
   end SHA1;

end HMAC;
