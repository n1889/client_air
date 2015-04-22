package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _4a784a52c65f001ca1c79e2c93991befb6a122b78ff2e70a0550b3bd60951527_flash_display_Sprite extends Sprite
   {
      
      public function _4a784a52c65f001ca1c79e2c93991befb6a122b78ff2e70a0550b3bd60951527_flash_display_Sprite()
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
