package body OTP.H.Test
with SPARK_Mode
is

   ---------
   -- Run --
   ---------

   function Run return String is
      Key         : constant LSC.Byte_Arrays.Byte_Array_Type :=
                      (16#48#, 16#48#, 16#48#, 16#48#);
      Counter     : constant LSC.Types.Word64 := 16#1bc#;
      Value       : constant OTP.OTP_Value := "194660";
      Rfc_Hmac    : constant HMAC.HMAC_Type :=
                      (16#1f#, 16#86#, 16#89#, 16#69#,
                       16#0e#, 16#02#, 16#ca#, 16#16#,
                       16#61#, 16#85#, 16#50#, 16#ef#,
                       16#7f#, 16#19#, 16#da#, 16#8e#,
                       16#94#, 16#5b#, 16#55#, 16#5a#);
      Rfc_Token   : constant OTP.OTP_Token := 16#50ef7f19#;
   begin
      if OTP.H.Extract (Rfc_Hmac) /= Rfc_Token then
         return "HOTP extraction test failed";
      end if;
      if OTP.H.Extract (Rfc_Hmac) /= Rfc_Token then
         return "HOTP value calculation failed";
      end if;
      return "PASSED";
   end Run;

end OTP.H.Test;
