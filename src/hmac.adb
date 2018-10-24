with Interfaces;
with LSC.Types;
with LSC.SHA1;
with LSC.HMAC_SHA1;
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
      K : LSC.SHA1.Block_Type := (others => 0);
      MB : LSC.SHA1.Block_Type := (others => 0);
      M  : LSC.SHA1.Message_Type (1 .. 1) := (others => MB);
   begin
      K (K'First .. K'First + (Key'Length / 4) - 1) :=
        LSC.Byte_Arrays.To_Word32_Array (Key);
      MB (MB'First .. MB'First + (Msg'Length / 4) - 1) :=
        LSC.Byte_Arrays.To_Word32_Array (Msg);
      M (1) := MB;
      return LSC.Byte_Arrays.
        To_Byte_Array (LSC.HMAC_SHA1.Authenticate (K, M, Msg'Length * 8));
   end SHA1;

end HMAC;
