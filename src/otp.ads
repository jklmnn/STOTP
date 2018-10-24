package OTP
with SPARK_Mode
is

   subtype OTP_Value is String
     with
       Dynamic_Predicate =>
         (for all C of OTP_Value =>
            Character'Pos (C) > 47 and Character'Pos (C) < 58);

   subtype OTP_Token is Integer range 0 .. 2 ** 31 - 1;

   function Image
     (H : OTP_Token;
      D : Positive := 6)
      return OTP_Value
     with
       Pre => D >= 6,
       Post => Image'Result'Length = D;

end OTP;
