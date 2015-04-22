package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _e486f8c747547b6343c6aea4de5d7dd813e0c1b82f5bb8403a16610ca0e740c8_flash_display_Sprite extends Sprite
   {
      
      public function _e486f8c747547b6343c6aea4de5d7dd813e0c1b82f5bb8403a16610ca0e740c8_flash_display_Sprite()
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
