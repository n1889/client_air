package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _d00d1b72bea7eaec0eaa90d80310713f6489b3e713ba02276fe539541baaeffa_flash_display_Sprite extends Sprite
   {
      
      public function _d00d1b72bea7eaec0eaa90d80310713f6489b3e713ba02276fe539541baaeffa_flash_display_Sprite()
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
