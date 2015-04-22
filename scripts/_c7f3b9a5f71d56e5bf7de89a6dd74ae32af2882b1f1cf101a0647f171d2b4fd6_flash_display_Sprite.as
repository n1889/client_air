package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _c7f3b9a5f71d56e5bf7de89a6dd74ae32af2882b1f1cf101a0647f171d2b4fd6_flash_display_Sprite extends Sprite
   {
      
      public function _c7f3b9a5f71d56e5bf7de89a6dd74ae32af2882b1f1cf101a0647f171d2b4fd6_flash_display_Sprite()
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
