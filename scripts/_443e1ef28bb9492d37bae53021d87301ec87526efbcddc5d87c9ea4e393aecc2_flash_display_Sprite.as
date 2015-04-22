package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _443e1ef28bb9492d37bae53021d87301ec87526efbcddc5d87c9ea4e393aecc2_flash_display_Sprite extends Sprite
   {
      
      public function _443e1ef28bb9492d37bae53021d87301ec87526efbcddc5d87c9ea4e393aecc2_flash_display_Sprite()
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
