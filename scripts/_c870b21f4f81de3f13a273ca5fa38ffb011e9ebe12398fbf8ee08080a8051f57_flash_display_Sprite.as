package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _c870b21f4f81de3f13a273ca5fa38ffb011e9ebe12398fbf8ee08080a8051f57_flash_display_Sprite extends Sprite
   {
      
      public function _c870b21f4f81de3f13a273ca5fa38ffb011e9ebe12398fbf8ee08080a8051f57_flash_display_Sprite()
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
