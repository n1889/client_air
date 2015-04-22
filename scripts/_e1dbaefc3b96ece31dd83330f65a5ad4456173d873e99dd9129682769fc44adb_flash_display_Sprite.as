package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _e1dbaefc3b96ece31dd83330f65a5ad4456173d873e99dd9129682769fc44adb_flash_display_Sprite extends Sprite
   {
      
      public function _e1dbaefc3b96ece31dd83330f65a5ad4456173d873e99dd9129682769fc44adb_flash_display_Sprite()
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
