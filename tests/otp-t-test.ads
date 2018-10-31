package OTP.T.Test
with SPARK_Mode
is

   Name : constant String := "OTP.T";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end OTP.T.Test;
