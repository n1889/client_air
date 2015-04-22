package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _23c4658e11608eacb5ff4c617bdb0a1a6c92ce1ee7e8bc0fa7ff601e62e19671_flash_display_Sprite extends Sprite
   {
      
      public function _23c4658e11608eacb5ff4c617bdb0a1a6c92ce1ee7e8bc0fa7ff601e62e19671_flash_display_Sprite()
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
