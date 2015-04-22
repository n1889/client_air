package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _02369bc7a5f8c60f03fde64bfe26e85a4c4bd523313e7698f13c8bf4bd84ddb2_flash_display_Sprite extends Sprite
   {
      
      public function _02369bc7a5f8c60f03fde64bfe26e85a4c4bd523313e7698f13c8bf4bd84ddb2_flash_display_Sprite()
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
