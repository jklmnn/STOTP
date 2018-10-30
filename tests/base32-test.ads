package Base32.Test
with SPARK_Mode
is

   Name : constant String := "Base32";

   function Run return String
     with
       Post => Run'Result'Length <= 128;

end Base32.Test;
