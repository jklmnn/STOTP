with Interfaces;
with LSC.Types;
with LSC.Byte_Arrays;
use all type LSC.Types.Index;

-- @summary
-- Base32 encoder and decoder
package Base32
  with SPARK_Mode
is

   -- Check if a character is in the Base32 alphabet
   -- @param C Character to Check
   -- @return True if C is in [a-zA-Z2-7]
   function Valid_Base32_Character
     (C : Character) return Boolean
   is
     ((Character'Pos (C) > 96 and Character'Pos (C) < 123) or
        (Character'Pos (C) > 64 and Character'Pos (C) < 91) or
          (Character'Pos (C) > 49 and Character'Pos (C) < 56));

   -- 8bit unsigned byte
   subtype Byte is LSC.Types.Byte;
   -- Array of bytes
   subtype Buffer is LSC.Byte_Arrays.Byte_Array_Type
     with
       Dynamic_Predicate => Buffer'Length mod 5 = 0;

   -- Base32 string that can only contain [a-zA-Z2-7]
   subtype Base32_String is String
     with
       Dynamic_Predicate =>
         Base32_String'Length mod 8 = 0 and
         (for all C in Base32_String'Range =>
            Valid_Base32_Character (Base32_String (C)));

   -- Decode Base32 string into a byte array
   -- @param S Valid Base32 string
   -- @return Decoded byte array
   function Decode (S : Base32_String) return Buffer
     with
       Pre =>
         S'Length < Integer (Natural'Last / 5) and
         S'Length >= 8,
       Post =>
         Decode'Result'Length = S'Length * 5 / 8;


   -- Encodes a byte array into a Base32 string
   -- @param B byte array
   -- @return Base32 string
   function Encode (B : Buffer) return Base32_String
     with
       Pre => B'Length < Natural'Last / 8;

   -- Decodes Base32 into ASCII
   -- @param S Base32 string
   -- @return String
   function Decode_String (S : Base32_String) return String
     with
       Pre =>
         S'Length < Natural'Last / 5 and S'Length >= 8;

   -- Encodes an ASCII string into Base32
   -- @param ASCII String
   -- @return Base32 string
   function Encode_String (S : String) return Base32_String
     with
       Pre => S'Length mod 5 = 0 and S'Length < Natural'Last / 8;

private

   use Interfaces;

   function Decode_Map (C : Character) return Byte
     with
       Pre => Valid_Base32_Character (C),
       Post => Decode_Map'Result < 32;

   function Encode_Map (N : Byte) return Character
     with
       Pre => N < 32,
       Post => Valid_Base32_Character (Encode_Map'Result);

   subtype String_Chunk is Base32_String (1 .. 8);
   subtype Buffer_Chunk is Buffer (1 .. 5);

   function Decode_1 (C1 : Character;
                      C2 : Character) return Byte is
     (Shift_Left (Decode_Map (C1), 3) or
        Shift_Right (Decode_Map (C2), 2))
       with
         Pre =>
           Valid_Base32_Character (C1) and Valid_Base32_Character (C2);

   function Decode_2 (C2 : Character;
                      C3 : Character;
                      C4 : Character) return Byte is
     (Shift_Left (Byte (Decode_Map (C2)), 6) or
          Shift_Left (Byte (Decode_Map (C3)), 1) or
          Shift_Right (Decode_Map (C4), 4))
     with
       Pre =>
         Valid_Base32_Character (C2) and
         Valid_Base32_Character (C3) and
         Valid_Base32_Character (C4);

   function Decode_3 (C4 : Character;
                      C5 : Character) return Byte is
     (Shift_Left (Byte (Decode_Map (C4)), 4) or
          Shift_Right (Decode_Map (C5), 1))
     with
       Pre =>
         Valid_Base32_Character (C4) and Valid_Base32_Character (C5);

   function Decode_4 (C5 : Character;
                      C6 : Character;
                      C7 : Character) return Byte is
     (Shift_Left (Decode_Map (C5), 7) or
        Shift_Left (Decode_Map (C6), 2) or
          Shift_Right (Decode_Map (C7), 3))
     with
       Pre =>
         Valid_Base32_Character (C5) and
         Valid_Base32_Character (C6) and
         Valid_Base32_Character (C7);

   function Decode_5 (C7 : Character;
                      C8 : Character) return Byte is
     (Shift_Left (Decode_Map (C7), 5) or
        Decode_Map (C8))
       with
         Pre =>
           Valid_Base32_Character (C7) and Valid_Base32_Character (C8);

   function Encode_1 (B1 : Byte) return Character is
     (Encode_Map (Shift_Right (B1, 3)))
     with
       Post =>
         Valid_Base32_Character (Encode_1'Result);

   function Encode_2 (B1 : Byte;
                      B2 : Byte) return Character is
     (Encode_Map (Shift_Left (B1 and 7, 2) or
                    Shift_Right (B2, 6)))
     with
       Post =>
         Valid_Base32_Character (Encode_2'Result);

   function Encode_3 (B2 : Byte) return Character is
     (Encode_Map (Shift_Right (B2 and 63, 1)))
     with
       Post =>
         Valid_Base32_Character (Encode_3'Result);

   function Encode_4 (B2 : Byte;
                      B3 : Byte) return Character is
     (Encode_Map (Shift_Left (B2 and 1, 4) or
                    Shift_Right (B3, 4)))
     with
       Post =>
         Valid_Base32_Character (Encode_4'Result);

   function Encode_5 (B3 : Byte;
                      B4 : Byte) return Character is
     (Encode_Map (Shift_Left (B3 and 15, 1) or
                    Shift_Right (B4, 7)))
     with
       Post =>
         Valid_Base32_Character (Encode_5'Result);

   function Encode_6 (B4 : Byte) return Character is
     (Encode_Map (Shift_Right (B4 and 127, 2)))
     with
       Post =>
         Valid_Base32_Character (Encode_6'Result);

   function Encode_7 (B4 : Byte;
                      B5 : Byte) return Character is
     (Encode_Map (Shift_Left (B4 and 3, 3) or
                    Shift_Right (B5, 5)))
     with
       Post =>
         Valid_Base32_Character (Encode_7'Result);

   function Encode_8 (B5 : Byte) return Character is
     (Encode_Map (B5 and 31))
       with
         Post =>
           Valid_Base32_Character (Encode_8'Result);

end Base32;
