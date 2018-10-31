package body Base32
  with SPARK_Mode
is

   ------------
   -- Decode --
   ------------

   function Decode (S : Base32_String) return Buffer is
      C5 : Natural;
      C8 : Natural;
      Chunks : constant Positive := S'Length / 8;
      Decoded : Buffer (1 .. Chunks * 5) := (others => 0);
   begin
      for C in Natural range 0 .. Chunks - 1 loop
         C5 := C * 5;
         C8 := C * 8;
         Decoded (Decoded'First + C5) :=
           Decode_1 (S (S'First + Integer (C8)),
                     S (S'First + Integer (C8 + 1)));

         Decoded (Decoded'First + C5 + 1) :=
           Decode_2 (S (S'First + Integer (C8 + 1)),
                     S (S'First + Integer (C8 + 2)),
                     S (S'First + Integer (C8 + 3)));

         Decoded (Decoded'First + C5 + 2) :=
           Decode_3 (S (S'First + Integer (C8 + 3)),
                     S (S'First + Integer (C8 + 4)));

         Decoded (Decoded'First + C5 + 3) :=
           Decode_4 (S (S'First + Integer (C8 + 4)),
                     S (S'First + Integer (C8 + 5)),
                     S (S'First + Integer (C8 + 6)));

         Decoded (Decoded'First + C5 + 4) :=
           Decode_5 (S (S'First + Integer (C8 + 6)),
                     S (S'First + Integer (C8 + 7)));
      end loop;
      return Decoded;
   end Decode;

   ------------
   -- Encode --
   ------------

   function Encode (B : Buffer) return Base32_String is
      C5 : Natural;
      C8 : Natural;
      Chunks : constant  Natural := B'Length / 5;
      Encoded : Base32_String (1 .. Chunks * 8) := (others => 'A');
   begin
      for C in Natural range 0 .. Chunks - 1 loop
         pragma Loop_Invariant (for all C of Encoded =>
                                  Valid_Base32_Character (C));
         C5 := C * 5;
         C8 := C * 8;
         Encoded (Encoded'First + C8) :=
           Encode_1 (B (B'First + C5));

         Encoded (Encoded'First + C8 + 1) :=
           Encode_2 (B (B'First + C5),
                     B (B'First + C5 + 1));

         Encoded (Encoded'First + C8 + 2) :=
           Encode_3 (B (B'First + C5 + 1));

         Encoded (Encoded'First + C8 + 3) :=
           Encode_4 (B (B'First + C5 + 1),
                     B (B'First + C5 + 2));

         Encoded (Encoded'First + C8 + 4) :=
           Encode_5 (B (B'First + C5 + 2),
                     B (B'First + C5 + 3));

         Encoded (Encoded'First + C8 + 5) :=
           Encode_6 (B (B'First + C5 + 3));

         Encoded (Encoded'First + C8 + 6) :=
           Encode_7 (B (B'First + C5 + 3),
                     B (B'First + C5 + 4));

         Encoded (Encoded'First + C8 + 7) :=
           Encode_8 (B (B'First + C5 + 4));
      end loop;
      return Encoded;
   end Encode;

   -------------------
   -- Decode_String --
   -------------------

   function Decode_String (S : Base32_String) return String
   is
      B : constant Buffer := Decode (S);
      Decoded_String : String (1 .. B'Length) := (others => Character'Val (0));
   begin
      for I in Decoded_String'Range loop
         Decoded_String (I) := Character'Val (B (B'First + I - 1));
      end loop;
      return Decoded_String;
   end Decode_String;

   -------------------
   -- Encode_String --
   -------------------

   function Encode_String (S : String) return Base32_String
   is
      B : Buffer (1 .. S'Length) := (others => 0);
   begin
      for I in B'Range loop
         B (I) := Character'Pos (S (S'First + Integer (I - 1)));
      end loop;
      return Encode (B);
   end Encode_String;

   ----------------
   -- Decode_Map --
   ----------------

   function Decode_Map (C : Character) return Byte
   is
      N : Byte;
   begin
      case C is
         when 'a' .. 'z' =>
            N := Byte (Character'Pos (C) - 97);
         when 'A' .. 'Z' =>
            N := Byte (Character'Pos (C) - 65);
         when '2' .. '7' =>
            N := Byte (Character'Pos (C) - 24);
         when others =>
            raise Constraint_Error;
      end case;
      return N;
   end Decode_Map;

   ----------------
   -- Encode_Map --
   ----------------

   function Encode_Map (N : Byte) return Character
   is
      C : Character;
   begin
      case N is
         when 0 .. 25 =>
            C := Character'Val (N + 65);
         when 26 .. 31 =>
            C := Character'Val (N + 24);
         when others =>
            raise Constraint_Error;
      end case;
      return C;
   end Encode_Map;

end Base32;
