package com.riotgames.platform.gameclient.controllers.game.views.banner
{
   import blix.components.timeline.StatefulView;
   import blix.assets.proxy.SpriteProxy;
   import blix.components.text.Text;
   import blix.context.IContext;
   
   public class MessageBanner extends StatefulView
   {
      
      private var textHolder:SpriteProxy;
      
      private var border:SpriteProxy;
      
      private var textField:Text;
      
      public function MessageBanner(param1:IContext)
      {
         super(param1);
         setLinkage("MessageBanner");
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.textHolder = new SpriteProxy(this);
         setTimelineChildByName("textHolder",this.textHolder);
         this.textField = new Text(this.textHolder);
         this.textHolder.setTimelineChildByName("textField",this.textField);
         this.border = new SpriteProxy(this);
         setTimelineChildByName("bannerBorder",this.border);
      }
      
      public function setText(param1:String) : void
      {
         this.textField.setText(param1);
      }
   }
}
