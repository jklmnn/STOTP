with Interfaces;
with LSC.Types;
use all type LSC.Types.Index;

package body Base32.LSC_Types is

   -------------------------------
   -- Buffer_To_Sha1_Block_Type --
   -------------------------------

   function Buffer_To_Sha1_Block_Type
     (B : Buffer)
      return LSC.SHA1.Block_Type
   is
      use Interfaces;
      Block : Buffer (1 .. 64) := (others => 0);
      Lsc_Block : LSC.SHA1.Block_Type := (others => 0);
   begin
      Block (Block'First .. Block'First + B'Length - 1) := B (B'First .. B'Last);
      for I in Lsc_Block'Range loop
         Lsc_Block (I) :=
           Shift_Left (LSC.Types.Word32 (Block (Block'First + Integer (I - Lsc_Block'First) * 4)), 24) or
           Shift_Left (LSC.Types.Word32 (Block (Block'First + Integer (I - Lsc_Block'First) * 4 + 1)), 16) or
           Shift_Left (LSC.Types.Word32 (Block (Block'First + Integer (I - Lsc_Block'First) * 4 + 2)), 8) or
           LSC.Types.Word32 (Block (Block'First + Integer (I - Lsc_Block'First) * 4 + 3));
      end loop;
      return Lsc_Block;
   end Buffer_To_Sha1_Block_Type;

   -------------------------------
   -- Sha1_Block_Type_To_Buffer --
   -------------------------------

   function Sha1_Block_Type_To_Buffer
     (Block : LSC.SHA1.Block_Type)
      return Buffer
   is
      use Interfaces;
      B : Buffer (1 .. 64) := (others => 0);
   begin
      for I in Block'Range loop
         B (B'First + Integer ((I - Block'First)) * 4) :=
           Unsigned_8 (Shift_Right (Block (I), 24));
         B (B'First + Integer ((I - Block'First)) * 4 + 1) :=
           Unsigned_8 (Shift_Right (Block (I), 16) and 255);
         B (B'First + Integer ((I - Block'First)) * 4 + 2) :=
           Unsigned_8 (Shift_Right (Block (I), 8) and 255);
         B (B'First + Integer ((I - Block'First)) * 4 + 3) :=
           Unsigned_8 (Block (I) and 255);
      end loop;
      return B;
   end Sha1_Block_Type_To_Buffer;

end Base32.LSC_Types;
