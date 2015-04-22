package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855_flash_display_Sprite extends Sprite
   {
      
      public function _e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain(rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain(rest);
      }
   }
}
