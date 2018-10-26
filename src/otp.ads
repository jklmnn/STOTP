
-- @summary
-- One-Time-Pad types
package OTP
with SPARK_Mode
is

   -- OTP token string, can only contain 0-9
   subtype OTP_Value is String
     with
       Dynamic_Predicate =>
         (for all C of OTP_Value =>
            Character'Pos (C) > 47 and Character'Pos (C) < 58);

   -- 31 bit OTP token
   subtype OTP_Token is Integer range 0 .. 2 ** 31 - 1;

   -- Generates a OTP Token string of a given Length
   -- @param H 31bit OTP_Token
   -- @param D Number of digits for the token string
   -- @return Token string of length D
   function Image
     (H : OTP_Token;
      D : Positive := 6)
      return OTP_Value
     with
       Depends => (Image'Result => (H, D)),
       Pre => D >= 6,
       Post => Image'Result'Length = D;

end OTP;
