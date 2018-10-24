with LSC.Types;
use all type LSC.Types.Index;

package LSC.Byte_Arrays
with SPARK_Mode
is

   type Byte_Array_Type is array (LSC.Types.Index range <>) of LSC.Types.Byte;

   function To_Byte_Array
     (W32 : LSC.Types.Word32_Array_Type)
      return Byte_Array_Type
     with
       Pre => W32'Length < LSC.Types.Index'Last / 4,
       Post => To_Byte_Array'Result'Length = 4 * W32'Length;

   function To_Word32_Array
     (B : Byte_Array_Type)
      return LSC.Types.Word32_Array_Type
     with
       Pre => B'Length mod 4 = 0,
       Post => To_Word32_Array'Result'Length = B'Length / 4;

   subtype Byte_Array32_Type is Byte_Array_Type (1 .. 4);
   subtype Byte_Array64_Type is Byte_Array_Type (1 .. 8);

   function Convert_Byte_Array
     (B : LSC.Types.Byte_Array32_Type)
      return Byte_Array32_Type is
     (Byte_Array32_Type' (1 => B (0),
                          2 => B (1),
                          3 => B (2),
                          4 => B (3)))
     with
       Inline;

   function Convert_Byte_Array
     (B : Byte_Array32_Type)
      return LSC.Types.Byte_Array32_Type is
     (LSC.Types.Byte_Array32_Type '(0 => B (1),
                                    1 => B (2),
                                    2 => B (3),
                                    3 => B (4)))
     with
       Inline;

   function Convert_Byte_Array
     (B : LSC.Types.Byte_Array64_Type)
      return Byte_Array64_Type is
     (Byte_Array64_Type' (1 => B (0), 2 => B (1),
                          3 => B (2), 4 => B (3),
                          5 => B (4), 6 => B (5),
                          7 => B (6), 8 => B (7)))
     with
       Inline;

   function Convert_Byte_Array
     (B : Byte_Array64_Type)
      return LSC.Types.Byte_Array64_Type is
     (LSC.Types.Byte_Array64_Type' (0 => B (1), 1 => B (2),
                                    2 => B (3), 3 => B (4),
                                    4 => B (5), 5 => B (6),
                                    6 => B (7), 7 => B (8)))
     with
       Inline;

end LSC.Byte_Arrays;
