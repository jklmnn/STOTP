with Interfaces;
with LSC.SHA1;
with LSC.HMAC_SHA1;
use all type Interfaces.Unsigned_64;

package body HOTP
with SPARK_Mode
is

   ----------
   -- HOTP --
   ----------

   function HOTP
     (Key : LSC.Byte_Arrays.Byte_Array_Type;
      Counter : LSC.Types.Word64)
      return HOTP_Token
   is
      K : LSC.Types.Word32_Array_Type :=
            LSC.Byte_Arrays.To_Word32_Array (Key);
      C : LSC.Types.Word32_Array_Type :=
            LSC.Byte_Arrays.To_Word32_Array (LSC.Byte_Arrays.Convert_Byte_Array (
                                             LSC.Types.Word64_To_Byte_Array64 (Counter)));
      K_Block : LSC.SHA1.Block_Type := (others => 0);
      C_Block : LSC.SHA1.Block_Type := (others => 0);
      C_Message : LSC.SHA1.Message_Type (1 .. 1) := (1 => (others => 0));
      Mac     : LSC.Byte_Arrays.HMAC;
   begin
      K_Block (K_Block'First .. K_Block'First + K'Length - 1) := K;
      C_Block (C_Block'First .. C_Block'First + C'Length - 1) := C;
      C_Message (1) := C_Block;
      Mac := LSC.Byte_Arrays.To_Byte_Array (LSC.HMAC_SHA1.Authenticate (K_Block, C_Message, 64));
      return Extract(Mac);
   end HOTP;

   -----------
   -- Image --
   -----------

   function Image
     (H : HOTP_Token;
      D : Positive := 6)
      return HOTP_Value
   is
      Token : HOTP_Token := H;
      Value : HOTP_Value (1 .. D) := (others => '0');
   begin
      for I in reverse Value'Range loop
         pragma Loop_Invariant (for all C of Value =>
                                  Character'Pos (C) > 47 and
                                  Character'Pos (C) < 58);
         Value (I) := Character'Val ((Token mod 10) + 48);
         Token := Token / 10;
      end loop;
      return Value (Value'Last - (D - 1) .. Value'Last);
   end Image;

   -------------
   -- Extract --
   -------------

   function Extract
     (Mac : LSC.Byte_Arrays.HMAC)
      return HOTP_Token
   is
      use Interfaces;
      Token       : Unsigned_32 := 0;
      type Bit is range 0 .. 1;
      type Bit_Index is range 0 .. 159;
      type Bit_Array is array (Bit_Index) of Bit;
      Mac_Bits    : Bit_Array := (others => 0);
      Loop_Offset : Bit_Index;
      Offset      : Bit_Index;
   begin
      Offset := Bit_Index (Unsigned_64 (Mac'Last) and 16#ff#);
      for I in Mac'Range loop
         Loop_Offset := Mac_Bits'First + Bit_Index (I - Mac'First) * 8;
         for J in 0 .. 7 loop
            Mac_Bits (Loop_Offset + Bit_Index (J)) :=
              Bit (Shift_Right (Mac (I), 7 - J) and 1);
         end loop;
      end loop;
      for I in Offset + 1 .. Offset + 31 loop
         Token := Token + Unsigned_32 (Mac_Bits (I));
         Token := Shift_Left (Token, 1);
      end loop;
      return HOTP_Token (Token);
   end Extract;

end HOTP;
