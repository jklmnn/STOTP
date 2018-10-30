package OTP.H.Test
with SPARK_Mode
is

   Name : constant String := "OTP.H";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end OTP.H.Test;
