package com.riotgames.platform.gameclient.controllers.game.controllers.reconnect
{
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import com.riotgames.platform.gameclient.controllers.game.controllers.ChampionSelectionController;
   import com.riotgames.platform.common.error.ServerError;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import mx.messaging.messages.RemotingMessage;
   import mx.messaging.events.MessageEvent;
   import com.riotgames.platform.common.AppConfig;
   import com.riotgames.platform.common.IAppControllerConstants;
   import com.riotgames.pvpnet.system.game.GameProviderProxy;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.domain.game.GameReconnectionInfo;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.domain.GameTimerDTO;
   import com.riotgames.platform.gameclient.domain.game.QueueType;
   import com.riotgames.platform.gameclient.controllers.game.controllers.GameUpdateController;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ReenterGameCommand extends Object
   {
      
      private static const ERROR_CODE_TIMER_NULL:String = "timerNull";
      
      private static const ERROR_CODE_TIMER_NOGAME:String = "timerNoGame";
      
      private static const ERROR_CODE_TIMER_REQUEST:String = "timerRequest";
      
      private static const ERROR_CODE_TIMER_MISMATCH:String = "timerMismatch";
      
      private static const ERROR_CODE_NOGAME:String = "nogame";
      
      private var _championSelectionViewModel:ChampionSelectionModel;
      
      private var _championSelectionController:ChampionSelectionController;
      
      private var _isQueuedGame:Boolean;
      
      private var logger:ILogger;
      
      private var _reconnector:ChampionSelectionReconnector;
      
      private var _gameUpdateController:GameUpdateController;
      
      public function ReenterGameCommand(param1:ChampionSelectionReconnector, param2:ChampionSelectionController, param3:GameUpdateController, param4:ChampionSelectionModel)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this._reconnector = param1;
         this._championSelectionController = param2;
         this._gameUpdateController = param3;
         this._championSelectionViewModel = param4;
      }
      
      private function abortWithFailure(param1:String, param2:String) : void
      {
         this.logger.error(param1);
         this._reconnector.notifyReconnectFailure(param2);
         this._reconnector.abortAutoReconnect();
      }
      
      private function abortWithWarning(param1:String, param2:String) : void
      {
         this.logger.warn(param1);
         this._reconnector.notifyReconnectWarning(param2);
         this._reconnector.abortAutoReconnect();
      }
      
      private function onTimerSyncError(param1:ServerError) : void
      {
         this.abortWithFailure("ReenterGameCommand: Failed to sync timer from server due to " + (!(param1 == null)?param1:"unknown"),ERROR_CODE_TIMER_REQUEST);
      }
      
      private function updateGame(param1:GameDTO) : void
      {
         if(param1 == null)
         {
            this.cancelGameFlow();
            this.abortWithFailure("ReenterGameCommand: Retrieved null game state after reconnect.",ERROR_CODE_NOGAME);
            return;
         }
         var _loc2_:* = new RemotingMessage();
         _loc2_.body = param1;
         var _loc3_:MessageEvent = new MessageEvent(MessageEvent.RESULT,false,false,_loc2_);
         switch(param1.gameState)
         {
            case GameState.IN_PROGRESS:
               AppConfig.instance.currentAppState = IAppControllerConstants.RECONNECT;
               GameProviderProxy.instance.setPlayingDisconnected();
               this._reconnector.notifyReconnected(param1.gameState);
               break;
            case GameState.PRE_CHAMPION_SELECTION:
            case GameState.CHAMPION_SELECTION:
            case GameState.POST_CHAMPION_SELECTION:
            case GameState.START_REQUESTED:
               ServiceProxy.instance.messageRouterService.fireGameMessage(_loc3_);
               ServiceProxy.instance.gameService.getCurrentTimerForGame(this.onGameTimerRetrieved,this.onServiceRequestComplete,this.onTimerSyncError);
               this._reconnector.notifyReconnected(param1.gameState);
               break;
         }
      }
      
      private function onQueueGetGameSuccess(param1:ResultEvent) : void
      {
         var _loc2_:GameReconnectionInfo = param1.result as GameReconnectionInfo;
         if(_loc2_ != null)
         {
            this.updateGame(_loc2_.game);
         }
         else
         {
            this.cancelGameFlow();
            this.abortWithWarning("ReenterGameCommand: No queue game to reconnect into.",ERROR_CODE_NOGAME);
         }
      }
      
      private function onServiceRequestComplete(param1:Boolean) : void
      {
         this._gameUpdateController.setIsBusy(false);
      }
      
      private function onGameTimerRetrieved(param1:Object) : void
      {
         if((this._championSelectionViewModel == null) || (this._championSelectionViewModel.currentGame == null))
         {
            this.abortWithFailure("ReenterGameCommand: Failed to sync timer after retrieving from server because currentGame doesn\'t exist!",ERROR_CODE_TIMER_NOGAME);
            return;
         }
         var _loc2_:GameTimerDTO = param1.result as GameTimerDTO;
         if(_loc2_ == null)
         {
            this.abortWithFailure("ReenterGameCommand: Failed to reset timer after retriving from server: invalid timer data",ERROR_CODE_TIMER_NULL);
            return;
         }
         if(this._championSelectionViewModel.currentGame.gameStateString != _loc2_.currentGameState)
         {
            this.abortWithFailure("ReenterGameCommand: Failed to reset timer after retrieving from server because game state mismatch! " + "currentGameState=" + this._championSelectionViewModel.currentGame.gameStateString + ", " + "serverGameState=" + _loc2_.currentGameState,ERROR_CODE_TIMER_MISMATCH);
            return;
         }
         this._gameUpdateController.resetTimer(Math.ceil(_loc2_.remainingTimeInMillis / 1000));
      }
      
      public function execute() : void
      {
         if((!(this._championSelectionViewModel == null)) && (!(this._championSelectionViewModel.currentGame == null)))
         {
            this._gameUpdateController.clearTickleTimer();
            if(this._championSelectionViewModel.currentGame.queueTypeName == QueueType.NONE)
            {
               this._isQueuedGame = false;
               ServiceProxy.instance.gameService.getGame(this._championSelectionViewModel.currentGame.id,this.onCustomOrBotGetGameSuccess,null,this.onGetGameError);
            }
            else if(QueueType.isCoopVsAI(this._championSelectionViewModel.currentGame.queueTypeName))
            {
               this._isQueuedGame = true;
               ServiceProxy.instance.gameService.getGame(this._championSelectionViewModel.currentGame.id,this.onCustomOrBotGetGameSuccess,null,this.onGetGameError);
            }
            else
            {
               this._isQueuedGame = true;
               ServiceProxy.instance.gameService.getGameReconnectionInfo(this.onQueueGetGameSuccess,null,this.onGetGameError);
            }
            
         }
      }
      
      private function cancelGameFlow() : void
      {
         if(this._isQueuedGame)
         {
            ServiceProxy.instance.matchMakerService.purgeFromQueues(null,null,null);
         }
         GameProviderProxy.instance.cancelGameFlow();
      }
      
      private function onCustomOrBotGetGameSuccess(param1:ResultEvent) : void
      {
         this.updateGame(param1.result as GameDTO);
      }
      
      private function onGetGameError(param1:Object) : void
      {
         this.cancelGameFlow();
         this.abortWithWarning("ReenterGameCommand: Game state after reconnect is invalid. Cause " + (!(param1 == null)?param1:"unknown"),ERROR_CODE_NOGAME);
      }
   }
}
