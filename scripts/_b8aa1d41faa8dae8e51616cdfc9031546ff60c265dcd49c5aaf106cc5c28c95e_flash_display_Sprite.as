package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _b8aa1d41faa8dae8e51616cdfc9031546ff60c265dcd49c5aaf106cc5c28c95e_flash_display_Sprite extends Sprite
   {
      
      public function _b8aa1d41faa8dae8e51616cdfc9031546ff60c265dcd49c5aaf106cc5c28c95e_flash_display_Sprite()
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
