pragma Ada_2012;
package body LSC.Byte_Arrays.Pad is

   ---------
   -- Pad --
   ---------

   function Pad
     (B : LSC.Byte_Arrays.Byte_Array_Type)
      return LSC.Byte_Arrays.Byte_Array_Type
   is
      P : LSC.Byte_Arrays.Byte_Array_Type
        (0 .. B'Length + Padding - (B'Length mod Padding) - 1) :=
        (others => 0);
   begin
      if B'Length mod Padding = 0 then
         return B;
      else
         P (P'First .. P'First + B'Length - 1) := B;
         return P;
      end if;
   end Pad;

end LSC.Byte_Arrays.Pad;
