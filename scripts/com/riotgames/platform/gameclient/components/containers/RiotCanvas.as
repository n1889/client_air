package com.riotgames.platform.gameclient.components.containers
{
   import mx.containers.Canvas;
   import flash.display.Graphics;
   import mx.core.FlexShape;
   
   public class RiotCanvas extends Canvas
   {
      
      private static const WHITEBOX_NAME:String = "RIOT_WHITEBOX";
      
      public function RiotCanvas()
      {
         super();
      }
      
      override public function validateDisplayList() : void
      {
         var _loc1_:* = false;
         var _loc2_:Graphics = null;
         super.validateDisplayList();
         if((whiteBox) && (rawChildren.contains(whiteBox)))
         {
            _loc1_ = this.getStyle("whiteBoxEnabled");
            if((!_loc1_) && (whiteBox))
            {
               rawChildren.removeChild(whiteBox);
               return;
            }
            if(whiteBox.name != WHITEBOX_NAME)
            {
               rawChildren.removeChild(whiteBox);
               whiteBox = new FlexShape();
               whiteBox.name = WHITEBOX_NAME;
               _loc2_ = whiteBox.graphics;
               _loc2_.beginFill(this.getStyle("whiteBoxColor"),this.getStyle("whiteBoxAlpha"));
               _loc2_.drawRect(0,0,verticalScrollBar.minWidth,horizontalScrollBar.minHeight);
               _loc2_.endFill();
               rawChildren.addChild(whiteBox);
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
      }
   }
}
