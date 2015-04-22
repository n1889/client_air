package com.riotgames.platform.gameclient.kudos
{
   import blix.layout.data.CanvasLayoutData;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.kudos.actions.ShowKudosDialogAction;
   import blix.assets.proxy.SpriteProxy;
   import flash.events.Event;
   import blix.context.IContext;
   
   public class KudosDialogFriendlyTeam extends KudosDialogBase
   {
      
      private var blixKudosDialog:KudosDialogFriendlyTeamView;
      
      private var alertAction:ShowKudosDialogAction;
      
      public function KudosDialogFriendlyTeam(param1:IContext, param2:IKudosService)
      {
         super(param1,param2);
      }
      
      override public function display() : void
      {
         var _loc1_:CanvasLayoutData = null;
         var _loc2_:Point = null;
         if(this.blixKudosDialog)
         {
            this.blixKudosDialog.resetState();
            this.blixKudosDialog.setSummonerName(this.recipientName);
         }
         this.alertAction = new ShowKudosDialogAction(this.context);
         if(fromPosition)
         {
            _loc1_ = new CanvasLayoutData();
            _loc2_ = getAnchorOffsetFromTopLeftCorner(this.blixKudosDialog);
            _loc1_.setLeft(fromPosition.x + _loc2_.x);
            _loc1_.setTop(fromPosition.y + _loc2_.y);
            this.alertAction.add(this,this.blixKudosDialog,_loc1_,new Point(fromPosition.x,fromPosition.y));
         }
         else
         {
            this.alertAction.add(this,this.blixKudosDialog);
         }
      }
      
      override protected function initializeBlixResourcesHelper() : void
      {
         this.blixKudosDialog = new KudosDialogFriendlyTeamView(context);
         flexContainer = new SpriteProxy(context,container);
         flexContainer.addChild(this.blixKudosDialog);
         dialogViewDispatcher = this.blixKudosDialog;
      }
      
      public function onFriendlyButtonClick(param1:Event) : void
      {
         giveKudo(KudosType.Friendly);
      }
      
      override protected function addClickHandlers() : void
      {
         super.addClickHandlers();
         dialogViewDispatcher.addEventListener(KudosDialogFriendlyTeamViewEvent.FRIENDLY_BUTTON_CLICKED,this.onFriendlyButtonClick);
         dialogViewDispatcher.addEventListener(KudosDialogFriendlyTeamViewEvent.HELPFUL_BUTTON_CLICKED,this.onHelpfulButtonClick);
         dialogViewDispatcher.addEventListener(KudosDialogFriendlyTeamViewEvent.TEAMWORK_BUTTON_CLICKED,this.onTeamworkButtonClick);
      }
      
      public function onTeamworkButtonClick(param1:Event) : void
      {
         giveKudo(KudosType.Teamwork);
      }
      
      public function onHelpfulButtonClick(param1:Event) : void
      {
         giveKudo(KudosType.Helpful);
      }
      
      override public function cancel() : void
      {
         super.cancel();
         if(this.alertAction)
         {
            this.alertAction.complete();
         }
      }
   }
}
