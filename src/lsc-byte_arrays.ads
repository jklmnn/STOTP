with LSC.Types;
use all type LSC.Types.Index;

--  @summary
--  Extension of libsparkcryptos types by a byte array of unconstrained size
package LSC.Byte_Arrays
with SPARK_Mode
is

   --  Natural index type
   subtype Natural_Index is Natural range Natural'First .. Natural'Last - 1;

   --  Unconstrained byte array
   type Byte_Array_Type is array (Natural_Index range <>) of LSC.Types.Byte;

   --  Converts a LSC 32bit word array into a byte array
   --  @param W32 LSC 32bit word array
   --  @return byte array
   function To_Byte_Array
     (W32 : LSC.Types.Word32_Array_Type)
      return Byte_Array_Type
     with
       Depends => (To_Byte_Array'Result => W32),
       Pre => W32'Length <= LSC.Types.Index'Last,
       Post => To_Byte_Array'Result'Length = 4 * W32'Length;

   --  Converts a byte array into a LSC 32bit word array
   --  @param B byte array
   --  @return LSC 32bit word array
   function To_Word32_Array
     (B : Byte_Array_Type)
      return LSC.Types.Word32_Array_Type
     with
       Depends => (To_Word32_Array'Result => B),
       Pre =>
         B'Length mod 4 = 0
         and then B'Length < Natural'Last / 4
         and then B'Length / 4 < Natural (LSC.Types.Index'Last),
       Post =>
         To_Word32_Array'Result'Length = B'Length / 4;

   subtype Byte_Array32_Type is Byte_Array_Type (1 .. 4);
   subtype Byte_Array64_Type is Byte_Array_Type (1 .. 8);

   --  Converts LSC 32bit byte array into a 4 byte long byte array
   --  @param B LSC Byte_Array32
   --  @return Byte array of length 4
   function Convert_Byte_Array
     (B : LSC.Types.Byte_Array32_Type)
      return Byte_Array32_Type is
     (Byte_Array32_Type'(1 => B (0),
                         2 => B (1),
                         3 => B (2),
                         4 => B (3)))
     with
       Depends => (Convert_Byte_Array'Result => B),
       Inline;

   --  Converts a 4 byte long byte array into an LSC 32bit byte array
   --  @param B Byte array of length 4
   --  @return LSC Byte_Array32
   function Convert_Byte_Array
     (B : Byte_Array32_Type)
      return LSC.Types.Byte_Array32_Type is
     (LSC.Types.Byte_Array32_Type '(0 => B (1),
                                    1 => B (2),
                                    2 => B (3),
                                    3 => B (4)))
     with
       Depends => (Convert_Byte_Array'Result => B),
       Inline;

   --  Converts LSC 64bit byte array into a 8 byte long byte array
   --  @param B LSC Byte_Array64
   --  @return Byte array of length 8
   function Convert_Byte_Array
     (B : LSC.Types.Byte_Array64_Type)
      return Byte_Array64_Type is
     (Byte_Array64_Type'(1 => B (0), 2 => B (1),
                         3 => B (2), 4 => B (3),
                         5 => B (4), 6 => B (5),
                         7 => B (6), 8 => B (7)))
     with
       Depends => (Convert_Byte_Array'Result => B),
       Inline;

   --  Converts a 8 byte long byte array into an LSC 64bit byte array
   --  @param B Byte array of length 8
   --  @return LSC Byte_Array64
   function Convert_Byte_Array
     (B : Byte_Array64_Type)
      return LSC.Types.Byte_Array64_Type is
     (LSC.Types.Byte_Array64_Type'(0 => B (1), 1 => B (2),
                                   2 => B (3), 3 => B (4),
                                   4 => B (5), 5 => B (6),
                                   6 => B (7), 7 => B (8)))
     with
       Depends => (Convert_Byte_Array'Result => B),
       Inline;

end LSC.Byte_Arrays;
