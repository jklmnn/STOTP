with Interfaces;

package Base32
  with SPARK_Mode
is

   subtype Byte is Interfaces.Unsigned_8;
   type Buffer is array (Positive range <>) of Byte
     with
       Dynamic_Predicate => Buffer'Length mod 5 = 0;

   subtype Base32_String is String
     with
       Dynamic_Predicate => Base32_String'Length mod 8 = 0;

   function Decode (S : Base32_String) return Buffer;

   function Encode (B : Buffer) return Base32_String;

   function Decode_String (S : Base32_String) return String;
   function Encode_String (S : String) return Base32_String;

private

   use Interfaces;

   function Decode_Map (C : Character) return Byte
     with
       Post => Decode_Map'Result < 32;

   function Encode_Map (N : Byte) return Character
     with
       Pre => N < 32;

   subtype String_Chunk is Base32_String (1 .. 8);
   subtype Buffer_Chunk is Buffer (1 .. 5);

   function Decode_1 (C1 : Character;
                      C2 : Character) return Byte is
     (Shift_Left (Decode_Map (C1), 3) or
        Shift_Right (Decode_Map (C2), 2));
   function Decode_2 (C2 : Character;
                      C3 : Character;
                      C4 : Character) return Byte is
     (Shift_Left (Byte (Decode_Map (C2)), 6) or
          Shift_Left (Byte (Decode_Map (C3)), 1) or
          Shift_Right (Decode_Map (C4), 4));
   function Decode_3 (C4 : Character;
                      C5 : Character) return Byte is
     (Shift_Left (Byte (Decode_Map (C4)), 4) or
          Shift_Right (Decode_Map (C5), 1));
   function Decode_4 (C5 : Character;
                      C6 : Character;
                      C7 : Character) return Byte is
     (Shift_Left (Decode_Map (C5), 7) or
        Shift_Left (Decode_Map (C6), 2) or
          Shift_Right (Decode_Map (C7), 3));
   function Decode_5 (C7 : Character;
                      C8 : Character) return Byte is
     (Shift_Left (Decode_Map (C7), 5) or
        Decode_Map (C8));

   function Encode_1 (B1 : Byte) return Character is
     (Encode_Map (Shift_Right (B1, 3)));
   function Encode_2 (B1 : Byte;
                      B2 : Byte) return Character is
     (Encode_Map (Shift_Left (B1 and 7, 2) or
                    Shift_Right (B2, 6)));
   function Encode_3 (B2 : Byte) return Character is
     (Encode_Map (Shift_Right (B2 and 63, 1)));
   function Encode_4 (B2 : Byte;
                      B3 : Byte) return Character is
     (Encode_Map (Shift_Left (B2 and 1, 4) or
                    Shift_Right (B3, 4)));
   function Encode_5 (B3 : Byte;
                      B4 : Byte) return Character is
     (Encode_Map (Shift_Left (B3 and 15, 1) or
                    Shift_Right (B4, 7)));
   function Encode_6 (B4 : Byte) return Character is
     (Encode_Map (Shift_Right (B4 and 127, 2)));
   function Encode_7 (B4 : Byte;
                      B5 : Byte) return Character is
     (Encode_Map (Shift_Left (B4 and 3, 3) or
                    Shift_Right (B5, 5)));
   function Encode_8 (B5 : Byte) return Character is
     (Encode_Map (B5 and 31));

end Base32;
