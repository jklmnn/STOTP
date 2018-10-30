package OTP.Test
with SPARK_Mode
is

   Name : constant String := "OTP";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end OTP.Test;
