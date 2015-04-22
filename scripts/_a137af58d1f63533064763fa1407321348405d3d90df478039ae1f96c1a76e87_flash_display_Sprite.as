package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _a137af58d1f63533064763fa1407321348405d3d90df478039ae1f96c1a76e87_flash_display_Sprite extends Sprite
   {
      
      public function _a137af58d1f63533064763fa1407321348405d3d90df478039ae1f96c1a76e87_flash_display_Sprite()
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
