package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _0f7ab7fee3da783a5b4030f198aaef765a01ca720467e3241cfc52bcfda127fa_flash_display_Sprite extends Sprite
   {
      
      public function _0f7ab7fee3da783a5b4030f198aaef765a01ca720467e3241cfc52bcfda127fa_flash_display_Sprite()
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
