package com.riotgames.pvpnet.game.controllers
{
   import com.riotgames.platform.common.provider.ISpectatorProvider;
   import flash.events.IEventDispatcher;
   import com.riotgames.pvpnet.game.controllers.lobby.ILobbyViewController;
   import com.riotgames.pvpnet.system.maestro.IMaestroProvider;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import com.riotgames.pvpnet.system.alerter.IAlerterProvider;
   import flash.utils.Timer;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.domain.PlayerCredentialsDTO;
   import com.riotgames.platform.gameclient.domain.game.GameReconnectionInfo;
   import com.riotgames.pvpnet.tracking.trackers.friend.IFriendListBehaviorTracker;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import com.riotgames.pvpnet.tracking.ICrossModuleTrackerProvider;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import flash.net.URLRequest;
   import flash.net.URLLoader;
   import flash.events.Event;
   import mx.utils.Base64Decoder;
   import flash.utils.ByteArray;
   import com.riotgames.platform.gameclient.domain.SpectatorEndOfGameStats;
   import com.riotgames.platform.gameclient.domain.EndOfGameStats;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.domain.lobby.LobbyViewState;
   import com.riotgames.platform.common.error.ServerError;
   import com.riotgames.platform.common.utils.MessageDictionary;
   import mx.resources.ResourceManager;
   import mx.resources.IResourceManager;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import flash.utils.getTimer;
   import com.riotgames.platform.gameclient.domain.game.GameViewState;
   import com.riotgames.pvpnet.game.controllers.lobby.LobbyConfig;
   import com.riotgames.pvpnet.game.controllers.lobby.MatchMakingState;
   import flash.events.TimerEvent;
   import com.riotgames.platform.gameclient.chat.domain.PresenceStatusData;
   import com.riotgames.platform.common.xmpp.data.invite.PresenceStatusXML;
   import com.riotgames.platform.gameclient.domain.game.QueueType;
   import com.riotgames.platform.gameclient.domain.game.AllowSpectators;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   import com.riotgames.pvpnet.system.maestro.MaestroProviderProxy;
   import com.riotgames.pvpnet.system.alerter.AlerterProviderProxy;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class SpectatorController extends Object implements ISpectatorProvider, IEventDispatcher
   {
      
      public var masterGameController:MasterGameController;
      
      public var lobbyController:ILobbyViewController;
      
      public var masterGameViewController:MasterGameViewController;
      
      public var maestroController:IMaestroProvider;
      
      public var serviceProxy:ServiceProxy;
      
      public var clientConfig:ClientConfig;
      
      public var alerter:IAlerterProvider;
      
      private var _305225771spectatorDelaySecondsRemaining:int = 0;
      
      private var _521309151spectatorDelayProgress:Number = 0;
      
      private var spectatorDelayTimer:Timer;
      
      private var logger:ILogger;
      
      private var totalSpectatorWaitTimeSeconds:int = 0;
      
      private var spectatorWaitStarted:int = 0;
      
      private var pendingCredentials:PlayerCredentialsDTO;
      
      private var _dropInSpectateGameID:String;
      
      private var _reconnectInfo:GameReconnectionInfo;
      
      public var featuredGameObject:Object;
      
      private var _friendTracker:IFriendListBehaviorTracker;
      
      private var _spectatingChangeSignal:Signal;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function SpectatorController()
      {
         this.maestroController = MaestroProviderProxy.instance;
         this.serviceProxy = ServiceProxy.instance;
         this.clientConfig = ClientConfig.instance;
         this.alerter = AlerterProviderProxy.instance;
         this.spectatorDelayTimer = new Timer(100,0);
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this._spectatingChangeSignal = new Signal();
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this.spectatorDelayTimer.addEventListener(TimerEvent.TIMER,this.onSpectatorDelayTimer);
         ProviderLookup.publishProvider(ISpectatorProvider,this);
         ProviderLookup.getProvider(ICrossModuleTrackerProvider,this.onGetCrossModuleTrackerProvider);
      }
      
      public function getSpectatingStateChangeSignal() : ISignal
      {
         return this._spectatingChangeSignal;
      }
      
      private function onGetCrossModuleTrackerProvider(param1:ICrossModuleTrackerProvider) : void
      {
         this._friendTracker = param1.getFriendListBehaviorTracker();
      }
      
      private function get currentGame() : GameDTO
      {
         return this.masterGameController.currentGame;
      }
      
      public function spectateSummoner(param1:String) : void
      {
         this._dropInSpectateGameID = param1;
         this.serviceProxy.gameService.spectateGameInProgress(param1,this.onSpectateGameInProgressSuccess,null,this.onSpectateGameInProgressError);
         this._friendTracker.incrementFriendGameSpectate_InASession();
      }
      
      public function retrieveEndOfGameStats() : void
      {
         var loader:URLLoader = null;
         var gridURL:String = "http://" + this.pendingCredentials.observerServerIp + ":" + this.pendingCredentials.observerServerPort;
         var restPath:String = "/observer-mode/rest/consumer/endOfGameStats/" + this.pendingCredentials.platformId + "/" + this.pendingCredentials.gameId + "/" + this.pendingCredentials.handshakeToken;
         gridURL = gridURL + restPath;
         var request:URLRequest = new URLRequest(gridURL);
         request.method = "GET";
         loader = new URLLoader(request);
         loader.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            var _loc2_:String = loader.data as String;
            var _loc3_:Base64Decoder = new Base64Decoder();
            _loc3_.decode(_loc2_);
            var _loc4_:ByteArray = _loc3_.toByteArray();
            var _loc5_:EndOfGameStats = _loc4_.readObject() as SpectatorEndOfGameStats;
            masterGameController.handleSpectatorEndOfGameStats(_loc5_);
            pendingCredentials = null;
            _dropInSpectateGameID = null;
         });
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
            logger.error("could not communicate with the spectator grid due to an IO Error:");
            logger.error(param1.toString());
            masterGameController.endOfGameStatsController.returnToLobby();
            _dropInSpectateGameID = null;
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:Event):void
         {
            logger.error("could not communicate with the spectator grid due to a security Error:");
            logger.error(param1.toString());
            masterGameController.endOfGameStatsController.returnToLobby();
            _dropInSpectateGameID = null;
         });
      }
      
      private function onSpectateGameInProgressSuccess(param1:ResultEvent) : void
      {
         var _loc2_:GameReconnectionInfo = param1.result as GameReconnectionInfo;
         if(_loc2_ == null)
         {
            return;
         }
         this.pendingCredentials = _loc2_.playerCredentials;
         this.pendingCredentials.platformId = this.clientConfig.platformId;
         _loc2_.playerCredentials.observer = true;
         this._reconnectInfo = _loc2_;
         this.masterGameController.reconnectToGame(_loc2_.game,_loc2_.playerCredentials,_loc2_.reconnectDelay);
         if(_loc2_.reconnectDelay > 0)
         {
            this.lobbyController.requestLobbyState(LobbyViewState.PLAY_GAME_STATE);
         }
      }
      
      private function onSpectateGameInProgressError(param1:ServerError) : void
      {
         var _loc2_:ServerError = null;
         if(param1)
         {
            _loc2_ = param1;
         }
         else
         {
            _loc2_ = new ServerError(null);
         }
         _loc2_.errorCode = MessageDictionary.SPECTATING_DISABLED;
         _loc2_.messageArguments = [];
         var _loc3_:IResourceManager = ResourceManager.getInstance();
         var _loc4_:AlertAction = new AlertAction(ResourceManager.getInstance().getString("resources","alert_title"),_loc3_.getString("resources",_loc2_.errorCode,_loc2_.messageArguments));
         _loc4_.add();
      }
      
      public function spectateGame(param1:PlayerCredentialsDTO, param2:int) : void
      {
         this.totalSpectatorWaitTimeSeconds = param2;
         this.spectatorWaitStarted = getTimer();
         this.spectatorDelaySecondsRemaining = param2;
         param1.platformId = this.clientConfig.platformId;
         if(param2 > 0)
         {
            this.pendingCredentials = param1;
            this.spectatorDelayProgress = 1;
            this.spectatorDelayTimer.start();
         }
         else
         {
            this.spectatorDelayProgress = 0;
            this.startSpectating(param1);
         }
         this._spectatingChangeSignal.dispatch();
      }
      
      public function spectateFeaturedGame(param1:Number, param2:String, param3:String, param4:int, param5:String) : void
      {
         var _loc10_:IResourceManager = null;
         var _loc11_:AlertAction = null;
         if((this.masterGameController.currentState == GameViewState.TEAM_SELECTION) || (this.masterGameController.currentState == GameViewState.JOIN_QUEUE) || (LobbyConfig.instance.matchmakingState == MatchMakingState.MATCHMAKING_CREATE_TEAM) || (LobbyConfig.instance.matchmakingState == MatchMakingState.MATCHMAKING_SPECTATING_CHAMP_SELECT) || (LobbyConfig.instance.matchmakingState == MatchMakingState.MATCHMAKING_QUEUED))
         {
            _loc10_ = ResourceManager.getInstance();
            _loc11_ = new AlertAction(ResourceManager.getInstance().getString("resources","alert_title"),_loc10_.getString("resources","SPEC-0001"));
            _loc11_.add();
            return;
         }
         var _loc6_:String = "nohost";
         var _loc7_:Number = 80;
         var _loc8_:RegExp = new RegExp("^(\\w+):\\/{2}([^\\/:]+)(?:\\:(\\d+))?(\\/(?:[^?]+\\/)?)?([^\\?#]+)?(?:\\?([^#]*))?(\\#.*)?$","gi");
         var _loc9_:Array = _loc8_.exec(this.clientConfig.featuredGamesURL);
         if((_loc9_.length > 0) && (_loc9_[2]) && (_loc9_[3]))
         {
            _loc6_ = _loc9_[2];
            _loc7_ = _loc9_[3];
         }
         this._dropInSpectateGameID = "featured_game_" + param1;
         this.pendingCredentials = new PlayerCredentialsDTO();
         this.pendingCredentials.observerEncryptionKey = param3;
         this.pendingCredentials.gameId = param1;
         this.pendingCredentials.observerServerIp = _loc6_;
         this.pendingCredentials.observerServerPort = _loc7_;
         this.pendingCredentials.platformId = param2;
         this.pendingCredentials.observer = true;
         this.pendingCredentials.mapId = param4;
         this.pendingCredentials.gameType = param5;
         this.masterGameController.isSpectating = true;
         this.masterGameController.currentState = GameViewState.IN_PROGRESS;
         this.masterGameController.gameType = param5;
         this.masterGameController.setGameMapByID(param4);
         this._reconnectInfo = new GameReconnectionInfo();
         this._reconnectInfo.playerCredentials = this.pendingCredentials;
         if(this.maestroController != null)
         {
            this.maestroController.createObserverGame(this.pendingCredentials.observerServerIp,this.pendingCredentials.observerServerPort.toString(),this.pendingCredentials.observerEncryptionKey,this.pendingCredentials.gameId.toString(),this.pendingCredentials.platformId);
            this.maestroController.getGameStarted().add(this.onSpectateStarted);
         }
         this.masterGameController.currentState = GameViewState.PLAYING_GAME;
         this._spectatingChangeSignal.dispatch();
      }
      
      private function onSpectatorDelayTimer(param1:TimerEvent) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this.spectatorWaitStarted;
         var _loc4_:Number = _loc3_ / (this.totalSpectatorWaitTimeSeconds * 1000);
         this.spectatorDelayProgress = Math.min(Math.max(1 - _loc4_,0),1);
         var _loc5_:int = this.totalSpectatorWaitTimeSeconds - Math.floor(_loc3_ * 0.001);
         this.spectatorDelaySecondsRemaining = Math.min(Math.max(_loc5_,0),this.totalSpectatorWaitTimeSeconds);
         if(this.spectatorDelaySecondsRemaining == 0)
         {
            if(this.pendingCredentials)
            {
               this.startSpectating(this.pendingCredentials);
            }
            this.cleanupTimers();
         }
         this.dispatchEvent(param1);
      }
      
      private function startSpectating(param1:PlayerCredentialsDTO) : void
      {
         if(param1.gameId == this.currentGame.id)
         {
            if(!param1.observer)
            {
               throw new Error("can\'t spectate as a player");
            }
            else
            {
               this.masterGameController.currentState = GameViewState.IN_PROGRESS;
               if(this.maestroController != null)
               {
                  if(param1.serverIp != null)
                  {
                     this.maestroController.createDirectConnectObserverGame(param1.serverIp,param1.serverPort.toString(),param1.observerEncryptionKey,param1.gameId.toString(),this.masterGameController.session.summoner.sumId.toString());
                  }
                  else
                  {
                     this.maestroController.createObserverGame(param1.observerServerIp,param1.observerServerPort.toString(),param1.observerEncryptionKey,param1.gameId.toString(),this.clientConfig.platformId);
                  }
                  this.maestroController.getGameStarted().add(this.onSpectateStarted);
               }
               this.masterGameController.currentState = GameViewState.PLAYING_GAME;
            }
         }
      }
      
      public function quitSpectating() : void
      {
         if(this.masterGameController)
         {
            this.masterGameController.cancelChampSelect();
         }
      }
      
      private function onSpectateStarted() : void
      {
         this.maestroController.getGameStarted().remove(this.onSpectateStarted);
         this.maestroController.getGameCompleted().add(this.onSpectateEnd);
         this.maestroController.getGameCrashed().add(this.onSpectateEnd);
         this.maestroController.getGameAbandoned().add(this.onSpectateEnd);
      }
      
      private function onSpectateEnd() : void
      {
         var _loc1_:String = null;
         if(ClientConfig.instance.sendFeedbackEventsEnabled)
         {
            _loc1_ = "spectator_endSpectate";
            ServiceProxy.instance.microFeedbackService.checkForAndSendSurveyQuestionToClient(_loc1_);
         }
         this.maestroController.getGameCompleted().remove(this.onSpectateEnd);
         this.maestroController.getGameCrashed().remove(this.onSpectateEnd);
         this.maestroController.getGameAbandoned().remove(this.onSpectateEnd);
         this._spectatingChangeSignal.dispatch();
      }
      
      public function cleanupTimers() : void
      {
         this.spectatorDelayTimer.stop();
         this.spectatorDelayProgress = 0;
         this.spectatorDelaySecondsRemaining = 0;
         this.totalSpectatorWaitTimeSeconds = 0;
      }
      
      public function cleanup() : void
      {
         this._dropInSpectateGameID = "";
         this.cleanupTimers();
      }
      
      public function cleanupReconnectionInfo() : void
      {
         this._reconnectInfo = null;
      }
      
      public function canDropInSpectate(param1:PresenceStatusData) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc2_:Boolean = (param1.gameType == PresenceStatusXML.GAME_STATUS_IN_GAME) || (param1.gameType == PresenceStatusXML.GAME_STATUS_IN_SPECTATING);
         if(this.spectatorDelaySecondsRemaining > 0)
         {
            _loc2_ = false;
         }
         if(!_loc2_)
         {
            return false;
         }
         if(!this.clientConfig.observerModeEnabled)
         {
            return false;
         }
         if((!(param1.queueType == QueueType.NONE)) && (this.clientConfig.observableGameModes.contains(param1.queueType)))
         {
            return true;
         }
         if((this.clientConfig.observableCustomGameModes == AllowSpectators.ALL) || (this.clientConfig.observableCustomGameModes == AllowSpectators.DROP_IN_ONLY))
         {
            if((param1.isGameObservable == AllowSpectators.ALL) || (param1.isGameObservable == AllowSpectators.DROP_IN_ONLY) || (param1.gameType == PresenceStatusXML.GAME_STATUS_IN_SPECTATING))
            {
               if(param1.queueType == QueueType.NONE)
               {
                  return true;
               }
               if((param1.gameType == PresenceStatusXML.GAME_STATUS_IN_SPECTATING) && (param1.featuredGameData))
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get dropInSpectateGameID() : String
      {
         return this._dropInSpectateGameID;
      }
      
      public function set dropInSpectateGameID(param1:String) : void
      {
         this._dropInSpectateGameID = param1;
      }
      
      public function getReconnectInfo() : GameReconnectionInfo
      {
         return this._reconnectInfo;
      }
      
      public function get spectatorDelaySecondsRemaining() : int
      {
         return this._305225771spectatorDelaySecondsRemaining;
      }
      
      public function set spectatorDelaySecondsRemaining(param1:int) : void
      {
         var _loc2_:Object = this._305225771spectatorDelaySecondsRemaining;
         if(_loc2_ !== param1)
         {
            this._305225771spectatorDelaySecondsRemaining = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"spectatorDelaySecondsRemaining",_loc2_,param1));
            }
         }
      }
      
      public function get spectatorDelayProgress() : Number
      {
         return this._521309151spectatorDelayProgress;
      }
      
      public function set spectatorDelayProgress(param1:Number) : void
      {
         var _loc2_:Object = this._521309151spectatorDelayProgress;
         if(_loc2_ !== param1)
         {
            this._521309151spectatorDelayProgress = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"spectatorDelayProgress",_loc2_,param1));
            }
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
   }
}
