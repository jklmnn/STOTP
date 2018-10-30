package body OTP.Test
with SPARK_Mode
is

   ---------
   -- Run --
   ---------

   function Run return String is
      Rfc_Token   : constant OTP.OTP_Token := 16#50ef7f19#;
      Rfc_Value   : constant OTP.OTP_Value := "872921";
      Rfc_Value10 : constant OTP.OTP_Value := "1357872921";
   begin
      if OTP.Image (Rfc_Token, 6) /= Rfc_Value then
         return "Calculating 6 digit value failed";
      end if;
      if OTP.Image (Rfc_Token, 10) /= Rfc_Value10 then
         return "Calculating 10 digit value failed";
      end if;
      return "PASSED";
   end Run;

end OTP.Test;
