with LSC.Types;
with LSC.Byte_Arrays;

-- @summary
-- Time based One-Time-Pad
--
-- @description
-- Calculates the Time based One-Time-Pad based on RFC 6238
--
-- @param X Time step size
-- @param T0 Reference time
generic
   X : LSC.Types.Word64 := 30;
   T0 : LSC.Types.Word64 := 0;
package OTP.T
is

   -- Calculates the TOTP Token from a given key and time offset
   -- @param HMAC key
   -- @param Current time
   -- @return TOTP Token as 31bit word
   function TOTP
     (Key  : LSC.Byte_Arrays.Byte_Array_Type;
      Time : LSC.Types.Word64)
      return OTP_Token
     with
       Depends => (TOTP'Result => (Key, Time)),
       Pre => Key'Length <= 64;

end OTP.T;
