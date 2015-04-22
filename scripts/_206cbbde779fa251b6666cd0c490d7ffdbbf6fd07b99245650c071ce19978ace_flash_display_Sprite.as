package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _206cbbde779fa251b6666cd0c490d7ffdbbf6fd07b99245650c071ce19978ace_flash_display_Sprite extends Sprite
   {
      
      public function _206cbbde779fa251b6666cd0c490d7ffdbbf6fd07b99245650c071ce19978ace_flash_display_Sprite()
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
