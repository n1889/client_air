package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _5752e9a700078246b138a4a7023785259fa0c64a2400317b4fc28534510c0cdc_flash_display_Sprite extends Sprite
   {
      
      public function _5752e9a700078246b138a4a7023785259fa0c64a2400317b4fc28534510c0cdc_flash_display_Sprite()
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
