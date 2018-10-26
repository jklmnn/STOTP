
-- @summary
-- Zero right padding of byte arrays
--
-- @param Padding Block size to which padding should be applied
generic
   Padding : LSC.Byte_Arrays.Natural_Index;
package LSC.Byte_Arrays.Pad is

   function Pad
     (B : LSC.Byte_Arrays.Byte_Array_Type)
      return LSC.Byte_Arrays.Byte_Array_Type
     with
       Depends => (Pad'Result => (B, Padding)),
       Pre =>
         B'Length < LSC.Byte_Arrays.Natural_Index'Last - Padding,
       Post =>
         Pad'Result'Length mod Padding = 0,
         Contract_Cases =>
           (B'Length mod Padding = 0 =>
              B'Length = Pad'Result'Length,
            others             =>
              Pad'Result'Length = B'Length + Padding - (B'Length mod Padding));

end LSC.Byte_Arrays.Pad;
