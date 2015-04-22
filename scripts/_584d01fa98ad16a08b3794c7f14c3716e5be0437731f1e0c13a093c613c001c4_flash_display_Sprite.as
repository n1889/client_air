package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _584d01fa98ad16a08b3794c7f14c3716e5be0437731f1e0c13a093c613c001c4_flash_display_Sprite extends Sprite
   {
      
      public function _584d01fa98ad16a08b3794c7f14c3716e5be0437731f1e0c13a093c613c001c4_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
