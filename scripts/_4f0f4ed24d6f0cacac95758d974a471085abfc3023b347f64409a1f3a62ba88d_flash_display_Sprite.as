package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _4f0f4ed24d6f0cacac95758d974a471085abfc3023b347f64409a1f3a62ba88d_flash_display_Sprite extends Sprite
   {
      
      public function _4f0f4ed24d6f0cacac95758d974a471085abfc3023b347f64409a1f3a62ba88d_flash_display_Sprite()
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
