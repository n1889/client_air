package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _dccb15b5b1298cc80a614213e157e83fd99a625f95fec2c2a5eec93500b060e5_flash_display_Sprite extends Sprite
   {
      
      public function _dccb15b5b1298cc80a614213e157e83fd99a625f95fec2c2a5eec93500b060e5_flash_display_Sprite()
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
