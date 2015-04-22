package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _d697f1da4585e024b25f3b2514c3e85102a39ecb5ada8a625a21ae1a788d46c4_flash_display_Sprite extends Sprite
   {
      
      public function _d697f1da4585e024b25f3b2514c3e85102a39ecb5ada8a625a21ae1a788d46c4_flash_display_Sprite()
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
