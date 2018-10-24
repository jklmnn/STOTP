with LSC.Types;
with LSC.Byte_Arrays;

generic
   X : LSC.Types.Word64 := 30;
   T0 : LSC.Types.Word64 := 0;
package OTP.T
is

   function TOTP
     (Key  : LSC.Byte_Arrays.Byte_Array_Type;
      Time : LSC.Types.Word64)
      return OTP_Token
     with
       Pre => Key'Length mod 4 = 0 and Key'Length <= 64;

end OTP.T;
