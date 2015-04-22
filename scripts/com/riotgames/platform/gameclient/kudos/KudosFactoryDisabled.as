package com.riotgames.platform.gameclient.kudos
{
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.platform.common.commands.ICommand;
   import com.riotgames.platform.common.commands.CommandBase;
   import mx.core.UIComponent;
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   import flash.display.DisplayObject;
   import blix.context.IContext;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.views.summoner.ISummonerInfoQuickView;
   import com.riotgames.platform.gameclient.domain.kudos.PendingKudos;
   
   public class KudosFactoryDisabled extends Object implements IKudosFactory
   {
      
      private var serviceProxy:ServiceProxy;
      
      protected var context:IContext;
      
      public function KudosFactoryDisabled()
      {
         super();
      }
      
      public function updateKudosState(param1:Boolean, param2:ServiceProxy) : void
      {
         this.serviceProxy = param2;
      }
      
      public function createShowReceivedKudosCommand() : ICommand
      {
         return new CommandBase();
      }
      
      public function getKudosButton(param1:UIComponent, param2:int, param3:Boolean, param4:Number, param5:PlayerParticipantStatsSummary, param6:Number, param7:DisplayObject, param8:Function = null, param9:Function = null) : IKudosButton
      {
         var _loc10_:KudosButtonDisabled = new KudosButtonDisabled();
         return _loc10_;
      }
      
      public function createProfilePanelVertical(param1:IContext) : KudosProfilePanelVerticalView
      {
         return null;
      }
      
      public function getKudosDialog(param1:Boolean, param2:Number, param3:Number, param4:String, param5:Number, param6:Point) : IKudosDialog
      {
         return new KudosDialogDisabled();
      }
      
      public function getProfilePanel(param1:ISummonerInfoQuickView) : IKudosProfilePanel
      {
         return new KudosProfilePanelDisabled();
      }
      
      public function createKudosContextAlertCommand(param1:PendingKudos, param2:Boolean = true) : ICommand
      {
         return new CommandBase();
      }
      
      public function getChampSelectBadgeRenderer() : IKudosChampSelectBadgeRenderer
      {
         return new KudosChampSelectBadgeRendererDisabled();
      }
      
      public function createKudosBadgeDialogCommand(param1:int, param2:int) : ICommand
      {
         return new CommandBase();
      }
      
      public function getServiceProxy() : ServiceProxy
      {
         return this.serviceProxy;
      }
      
      public function getKudosProfileTotalsCache() : IKudosProfileTotalsCache
      {
         return new KudosProfileTotalsCacheDisabled();
      }
   }
}
