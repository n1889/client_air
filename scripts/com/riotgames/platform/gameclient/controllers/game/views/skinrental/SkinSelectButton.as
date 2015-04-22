package com.riotgames.platform.gameclient.controllers.game.views.skinrental
{
   import blix.components.button.ButtonX;
   import blix.signals.ISignal;
   import blix.signals.Signal;
   import flash.events.MouseEvent;
   import blix.assets.proxy.SpriteProxy;
   import blix.components.text.Text;
   import blix.context.IContext;
   
   public class SkinSelectButton extends ButtonX
   {
      
      private var clicked:Signal;
      
      private var textHolder:SpriteProxy;
      
      private var textField:Text;
      
      public function SkinSelectButton(param1:IContext)
      {
         this.clicked = new Signal();
         super(param1);
         setLinkage("SkinSelectButton");
      }
      
      public function getClicked() : ISignal
      {
         return this.clicked;
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         this.clicked.dispatch(this.clicked);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.textHolder = new SpriteProxy(this);
         setTimelineChildByName("textHolder",this.textHolder);
         this.textField = new Text(this.textHolder);
         this.textHolder.setTimelineChildByName("textField",this.textField);
         this.addEventListener(MouseEvent.CLICK,this.onClicked,false,0,true);
      }
      
      public function setText(param1:String) : void
      {
         this.textField.setText(param1);
      }
   }
}
