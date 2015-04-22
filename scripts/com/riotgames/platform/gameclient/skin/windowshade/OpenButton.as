package com.riotgames.platform.gameclient.skin.windowshade
{
   import mx.skins.ProgrammaticSkin;
   import flash.display.Graphics;
   
   public class OpenButton extends ProgrammaticSkin
   {
      
      public function OpenButton()
      {
         super();
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:Graphics = this.graphics;
         _loc3_.clear();
         _loc3_.moveTo(0,-4);
         _loc3_.beginFill(9408658);
         _loc3_.lineTo(8,-4);
         _loc3_.lineTo(4,1);
         _loc3_.lineTo(0,-4);
         _loc3_.endFill();
      }
   }
}
