package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _72b8fcfea01827157a6babca1e3867faa07817316a0be65322b670e93c2e0e8d_flash_display_Sprite extends Sprite
   {
      
      public function _72b8fcfea01827157a6babca1e3867faa07817316a0be65322b670e93c2e0e8d_flash_display_Sprite()
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
