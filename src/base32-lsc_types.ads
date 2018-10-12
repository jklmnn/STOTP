with LSC.SHA1;

package Base32.LSC_Types is

   function Buffer_To_Sha1_Block_Type
     (B : Buffer)
      return LSC.SHA1.Block_Type
     with
       Pre => B'Length <= 65;

   function Sha1_Block_Type_To_Buffer
     (Block : LSC.SHA1.Block_Type)
      return Buffer
     with
       Post => Sha1_Block_Type_To_Buffer'Result'Length = 64;

end Base32.LSC_Types;
