package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _0b5a7ee8e7b675530dff8e157a340c7e3824f13100f332b6edd2af6bb79c487e_flash_display_Sprite extends Sprite
   {
      
      public function _0b5a7ee8e7b675530dff8e157a340c7e3824f13100f332b6edd2af6bb79c487e_flash_display_Sprite()
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
