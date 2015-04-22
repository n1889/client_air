package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _c54703b90b59976580c8367552043231c8befd32ded78385d58638de5fd132c4_flash_display_Sprite extends Sprite
   {
      
      public function _c54703b90b59976580c8367552043231c8befd32ded78385d58638de5fd132c4_flash_display_Sprite()
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
