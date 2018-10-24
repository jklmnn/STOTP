with Interfaces;
with LSC.SHA1;
with LSC.HMAC_SHA1;
with LSC.Byteorder32;
with LSC.Byteorder64;
use all type Interfaces.Unsigned_8;
use all type Interfaces.Unsigned_32;

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
      C : LSC.Byte_Arrays.Byte_Array_Type :=
            LSC.Byte_Arrays.Convert_Byte_Array (LSC.Types.Word64_To_Byte_Array64 (
                                                LSC.Byteorder64.Native_To_BE(Counter)));
      Mac     : HMAC.HMAC_Type;
   begin
      Mac := HMAC.SHA1 (Key, C);
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
     (Mac : HMAC.HMAC_Type)
      return HOTP_Token
   is
      Offset : LSC.Types.Index := LSC.Types.Index (Mac (Mac'Last) and 16#f#) + 1;
      W32    : LSC.Types.Word32;

   begin
      W32 := LSC.Types.Byte_Array32_To_Word32 (LSC.Types.Byte_Array32_Type '(
                                               0 => Mac (Offset),
                                               1 => Mac (Offset + 1),
                                               2 => Mac (Offset + 2),
                                               3 => Mac (Offset + 3)));
      return HOTP_Token (LSC.Byteorder32.BE_To_Native(W32) and 16#7fffffff#);
   end Extract;

end HOTP;
