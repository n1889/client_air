package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _97eae44f565e72c5134b02666640bdafde81147c6feb5842323381c79393ac2d_flash_display_Sprite extends Sprite
   {
      
      public function _97eae44f565e72c5134b02666640bdafde81147c6feb5842323381c79393ac2d_flash_display_Sprite()
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
