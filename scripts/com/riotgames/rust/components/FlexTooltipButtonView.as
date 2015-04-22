package com.riotgames.rust.components
{
   import blix.components.button.ButtonX;
   import mx.core.UIComponent;
   import mx.core.IToolTip;
   import flash.events.MouseEvent;
   import mx.managers.ToolTipManager;
   import blix.context.Context;
   
   public class FlexTooltipButtonView extends ButtonX
   {
      
      public var flexContext:UIComponent;
      
      public var tooltip:String;
      
      public var tipDX:int = 0;
      
      public var tipDY:int = 0;
      
      private var tip:IToolTip;
      
      public function FlexTooltipButtonView(param1:Context)
      {
         super(param1);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOut);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(this.tooltip)
         {
            _loc2_ = _asset.stage.mouseX + this.tipDX;
            _loc3_ = _asset.stage.mouseY + this.tipDY;
            this.tip = ToolTipManager.createToolTip(this.tooltip,_loc2_,_loc3_,null,this.flexContext);
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void
      {
         if((this.tip) && (this.tip.stage))
         {
            ToolTipManager.destroyToolTip(this.tip);
         }
      }
   }
}
