package com.riotgames.platform.gameclient.controllers.game.views.skinrental
{
   import blix.components.button.ButtonX;
   import blix.signals.Signal;
   import flash.events.MouseEvent;
   import blix.assets.proxy.SpriteProxy;
   import blix.signals.ISignal;
   import blix.components.text.Text;
   import blix.components.enum.ButtonStatesEnum;
   import blix.context.IContext;
   
   public class SkinRentalButton extends ButtonX
   {
      
      private var clickable:Boolean = true;
      
      private var unlocked:Boolean = false;
      
      private var clicked:Signal;
      
      private var pricing:SpriteProxy;
      
      private var textField:Text;
      
      private var textHolder:SpriteProxy;
      
      public function SkinRentalButton(param1:IContext)
      {
         this.clicked = new Signal();
         super(param1);
         setLinkage("SkinRentalButton");
      }
      
      public function setClickable(param1:Boolean) : void
      {
         this.clickable = param1;
         this.refreshState();
      }
      
      public function setUnlocked(param1:Boolean) : void
      {
         setEnabled(false);
         this.unlocked = param1;
         setCurrentState("disabled");
         setCurrentState("unlocked");
      }
      
      private function onClicked(param1:MouseEvent) : void
      {
         if(this.clickable)
         {
            this.clicked.dispatch(this.clicked);
         }
      }
      
      public function setText(param1:String) : void
      {
         this.textField.setText(param1);
      }
      
      public function getClicked() : ISignal
      {
         return this.clicked;
      }
      
      override protected function refreshState() : void
      {
         if(this.unlocked)
         {
            return;
         }
         if(!this.clickable)
         {
            setCurrentState(ButtonStatesEnum.DISABLED);
         }
         else
         {
            super.refreshState();
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.pricing = new SpriteProxy(this);
         setTimelineChildByName("pricing",this.pricing);
         this.textHolder = new SpriteProxy(this);
         setTimelineChildByName("textHolder",this.textHolder);
         this.textField = new Text(this.textHolder);
         this.textHolder.setTimelineChildByName("textField",this.textField);
         this.addEventListener(MouseEvent.CLICK,this.onClicked,false,0,true);
      }
   }
}
