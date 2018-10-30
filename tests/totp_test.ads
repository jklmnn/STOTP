package TOTP_Test
with SPARK_Mode
is

   Name : constant String := "OTP.T";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end TOTP_Test;
