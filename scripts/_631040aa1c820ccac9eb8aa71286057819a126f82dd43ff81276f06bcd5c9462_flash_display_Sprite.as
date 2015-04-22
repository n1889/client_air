package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _631040aa1c820ccac9eb8aa71286057819a126f82dd43ff81276f06bcd5c9462_flash_display_Sprite extends Sprite
   {
      
      public function _631040aa1c820ccac9eb8aa71286057819a126f82dd43ff81276f06bcd5c9462_flash_display_Sprite()
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
