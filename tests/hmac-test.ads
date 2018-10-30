package HMAC.Test
with SPARK_Mode
is

   Name : constant String := "HMAC";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end HMAC.Test;
