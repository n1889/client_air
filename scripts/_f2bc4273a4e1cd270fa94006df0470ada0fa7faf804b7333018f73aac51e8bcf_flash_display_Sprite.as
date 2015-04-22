package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _f2bc4273a4e1cd270fa94006df0470ada0fa7faf804b7333018f73aac51e8bcf_flash_display_Sprite extends Sprite
   {
      
      public function _f2bc4273a4e1cd270fa94006df0470ada0fa7faf804b7333018f73aac51e8bcf_flash_display_Sprite()
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
