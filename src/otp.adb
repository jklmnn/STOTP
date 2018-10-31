package body OTP
with SPARK_Mode
is

   -----------
   -- Image --
   -----------

   function Image
     (H : OTP_Token;
      D : Positive := 6)
      return OTP_Value
   is
      Token : OTP_Token := H;
      Value : OTP_Value (1 .. D) := (others => '0');
   begin
      for I in reverse Value'Range loop
         pragma Loop_Invariant (for all C of Value => C in '0' .. '9');
         Value (I) := Character'Val ((Token mod 10) + 48);
         Token := Token / 10;
      end loop;
      return Value (Value'Last - (D - 1) .. Value'Last);
   end Image;

end OTP;
