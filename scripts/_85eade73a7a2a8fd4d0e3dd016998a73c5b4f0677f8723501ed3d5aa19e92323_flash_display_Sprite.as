package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _85eade73a7a2a8fd4d0e3dd016998a73c5b4f0677f8723501ed3d5aa19e92323_flash_display_Sprite extends Sprite
   {
      
      public function _85eade73a7a2a8fd4d0e3dd016998a73c5b4f0677f8723501ed3d5aa19e92323_flash_display_Sprite()
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
