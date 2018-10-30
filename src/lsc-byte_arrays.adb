package body LSC.Byte_Arrays
with SPARK_Mode
is

   -------------------
   -- To_Byte_Array --
   -------------------

   function To_Byte_Array
     (W32 : LSC.Types.Word32_Array_Type)
      return Byte_Array_Type
   is
      B : Byte_Array_Type (1 .. W32'Length * 4) := (others => 0);
      Offset : Natural_Index;
   begin
      for I in W32'Range loop
         Offset := B'First + Natural_Index (I - W32'First) * 4;
         B (Offset .. Offset + 3) :=
           Convert_Byte_Array (LSC.Types.Word32_To_Byte_Array32 (W32 (I)));
      end loop;
      return B;
   end To_Byte_Array;

   ---------------------
   -- To_Word32_Array --
   ---------------------

   function To_Word32_Array
     (B : Byte_Array_Type)
      return LSC.Types.Word32_Array_Type
   is
      W : LSC.Types.Word32_Array_Type (1 .. LSC.Types.Index (B'Length / 4)) :=
        (others => 0);
      Offset : Natural_Index;
   begin
      for I in W'Range loop
         Offset := B'First + Natural_Index (I - W'First) * 4;
         W (I) :=
           LSC.Types.Byte_Array32_To_Word32 (Convert_Byte_Array (
                                             Byte_Array32_Type (
                                               B (Offset .. Offset + 3))));
      end loop;
      return W;
   end To_Word32_Array;

end LSC.Byte_Arrays;
