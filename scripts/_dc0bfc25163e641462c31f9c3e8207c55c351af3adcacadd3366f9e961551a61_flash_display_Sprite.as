package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _dc0bfc25163e641462c31f9c3e8207c55c351af3adcacadd3366f9e961551a61_flash_display_Sprite extends Sprite
   {
      
      public function _dc0bfc25163e641462c31f9c3e8207c55c351af3adcacadd3366f9e961551a61_flash_display_Sprite()
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
