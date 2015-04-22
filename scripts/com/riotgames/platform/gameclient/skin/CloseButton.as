package com.riotgames.platform.gameclient.skin
{
   import mx.skins.ProgrammaticSkin;
   import flash.display.Graphics;
   
   public class CloseButton extends ProgrammaticSkin
   {
      
      public function CloseButton()
      {
         super();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = this.graphics;
         _loc3_.clear();
         _loc3_.moveTo(2,2);
         _loc3_.lineStyle(1,11776947);
         _loc3_.lineTo(7,7);
         _loc3_.moveTo(7,2);
         _loc3_.lineTo(2,7);
      }
   }
}
