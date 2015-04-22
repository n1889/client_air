package com.riotgames.platform.gameclient.kudos
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.common.commands.ICommand;
   import com.riotgames.platform.gameclient.domain.kudos.PendingKudos;
   import blix.context.IContext;
   import com.riotgames.platform.common.services.ServiceProxy;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.views.summoner.ISummonerInfoQuickView;
   import mx.core.UIComponent;
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   import flash.display.DisplayObject;
   
   public interface IKudosFactory extends IProvider
   {
      
      function getChampSelectBadgeRenderer() : IKudosChampSelectBadgeRenderer;
      
      function createKudosBadgeDialogCommand(param1:int, param2:int) : ICommand;
      
      function createKudosContextAlertCommand(param1:PendingKudos, param2:Boolean = true) : ICommand;
      
      function createShowReceivedKudosCommand() : ICommand;
      
      function createProfilePanelVertical(param1:IContext) : KudosProfilePanelVerticalView;
      
      function getServiceProxy() : ServiceProxy;
      
      function getKudosDialog(param1:Boolean, param2:Number, param3:Number, param4:String, param5:Number, param6:Point) : IKudosDialog;
      
      function getProfilePanel(param1:ISummonerInfoQuickView) : IKudosProfilePanel;
      
      function getKudosProfileTotalsCache() : IKudosProfileTotalsCache;
      
      function getKudosButton(param1:UIComponent, param2:int, param3:Boolean, param4:Number, param5:PlayerParticipantStatsSummary, param6:Number, param7:DisplayObject, param8:Function = null, param9:Function = null) : IKudosButton;
      
      function updateKudosState(param1:Boolean, param2:ServiceProxy) : void;
   }
}
