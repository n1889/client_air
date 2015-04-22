package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _7ba87617dc02748b48bc384f70cc33cea6aa9341c3d8c7e381a26739f02be8ae_flash_display_Sprite extends Sprite
   {
      
      public function _7ba87617dc02748b48bc384f70cc33cea6aa9341c3d8c7e381a26739f02be8ae_flash_display_Sprite()
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
