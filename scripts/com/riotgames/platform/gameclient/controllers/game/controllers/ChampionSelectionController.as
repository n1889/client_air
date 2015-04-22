package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import flash.events.EventDispatcher;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.controllers.game.EventQueue;
   import com.riotgames.platform.gameclient.controllers.game.mediators.HelpMediator;
   import com.riotgames.platform.common.provider.ISoundProvider;
   import com.riotgames.platform.gameclient.controllers.game.help.AdvancedTutorialController;
   import com.riotgames.platform.gameclient.controllers.game.GlowComponentController;
   import flash.events.Event;
   import com.riotgames.pvpnet.system.alerter.IAlerterProvider;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.common.commands.ICommand;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import com.riotgames.platform.gameclient.domain.PlayerParticipant;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import com.riotgames.platform.common.provider.IChampionDetailProvider;
   import com.riotgames.pvpnet.metrics.ChampSelectTracker;
   import com.riotgames.platform.gameclient.championselection.GameEvent;
   import com.riotgames.platform.gameclient.domain.game.GameType;
   import com.riotgames.platform.gameclient.domain.reroll.ARAMPlayerParticipant;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.common.provider.RerollProviderProxy;
   import com.riotgames.platform.gameclient.chat.controllers.ChatRoom;
   import com.riotgames.platform.gameclient.domain.PlayerChampionSelectionDTO;
   import flash.display.NativeWindow;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.common.audio.AudioKeys;
   import flash.desktop.NativeApplication;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionTrade;
   import com.riotgames.platform.common.provider.IInventory;
   import com.riotgames.platform.gameclient.domain.Spell;
   import com.riotgames.pvpnet.utils.SpellUtils;
   import com.riotgames.pvpnet.model.SpellSelection;
   import com.riotgames.platform.gameclient.controllers.game.help.ChampionSelectionTipsController;
   import com.riotgames.platform.gameclient.controllers.game.views.popup.ITipPopupManager;
   import com.riotgames.platform.gameclient.controllers.game.builders.IChampionSelectionCommandFactory;
   import mx.collections.IList;
   import com.riotgames.platform.gameclient.championselection.GameSelectionData;
   import com.riotgames.platform.common.error.ServerError;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import mx.resources.ResourceManager;
   import mx.resources.IResourceManager;
   import com.riotgames.platform.gameclient.exception.GameException;
   import com.riotgames.platform.gameclient.controllers.game.controllers.reconnect.ChampionSelectionReconnector;
   import com.riotgames.platform.gameclient.domain.Champion;
   import blix.signals.Signal;
   import com.riotgames.platform.common.xmpp.data.invite.PresenceStatusXML;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.platform.gameclient.domain.game.ParticipantChampionSelection;
   import com.riotgames.platform.common.provider.ChampionDetailProviderProxy;
   import com.riotgames.platform.common.module.championdetail.ChampionDetailContext;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.controllers.game.ArrowedAlertController;
   import blix.context.IContext;
   import blix.signals.ISignal;
   import com.riotgames.platform.masteries.objects.MasteryPageInfoSummary;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import mx.rpc.events.ResultEvent;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   import mx.collections.ArrayCollection;
   
   public class ChampionSelectionController extends EventDispatcher
   {
      
      private var glowController:GlowComponentController;
      
      private var banController:BanController;
      
      private var alerter:IAlerterProvider;
      
      private var championDetailProvider:IChampionDetailProvider;
      
      private var spectatorDelayManager:SpectatorDelayManager;
      
      private var commandFactory:IChampionSelectionCommandFactory;
      
      private var currentMatchDetailsMessages:IList;
      
      private var selectionData:GameSelectionData;
      
      private var gameUpdateController:GameUpdateController;
      
      private var advancedTutorialController:AdvancedTutorialController;
      
      private var hasConfirmedAck:Boolean = false;
      
      private var championSelectionReconnector:ChampionSelectionReconnector;
      
      private var rerollUpdated:Signal;
      
      private var hasAcked:Boolean = false;
      
      private var championTradeController:IChampionTradeController;
      
      private var logger:ILogger;
      
      private var arrowedAlertController:ArrowedAlertController;
      
      private var championSelectionViewModel:ChampionSelectionModel;
      
      private var summonChampionController:SummonChampionController;
      
      private var context:IContext;
      
      private var masteriesManager:MasteriesManager;
      
      private var serviceProxy:ServiceProxy;
      
      private var championSkinController:ChampionSkinController;
      
      private var championSelectionTipsController:ChampionSelectionTipsController;
      
      public function ChampionSelectionController(param1:IContext, param2:GameSelectionData, param3:ChampionSelectionModel)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this.currentMatchDetailsMessages = new ArrayCollection();
         this.rerollUpdated = new Signal();
         super();
         this.selectionData = param2;
         this.championSelectionViewModel = param3;
         this.context = param1;
      }
      
      public function champSelectAbandoned() : Boolean
      {
         var _loc1_:Boolean = false;
         if((this.championSelectionViewModel.championSelectionState == GameState.TEAM_SELECTION) || (this.championSelectionViewModel.championSelectionState == GameState.TERMINATED_IN_ERROR) || (this.championSelectionViewModel.championSelectionState == GameState.TERMINATED))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function enableTutorial() : void
      {
         var _loc1_:EventQueue = new EventQueue();
         var _loc2_:HelpMediator = new HelpMediator(_loc1_,this.context.getDependency(ISoundProvider),this.arrowedAlertController,this.glowController);
         this.advancedTutorialController = new AdvancedTutorialController(this.alerter,this.championSelectionViewModel,_loc2_,this.commandFactory);
         this.advancedTutorialController.activate();
         this.advancedTutorialController.addEventListener("logout",this.requestLogout);
      }
      
      public function switchToSkins() : void
      {
         this.championSelectionViewModel.setMainMenuToSkins();
      }
      
      public function cancelTrade() : void
      {
         if(this.championTradeController)
         {
            this.championTradeController.cancelTrade();
         }
      }
      
      private function onChampionSelectionStateChanged(param1:Event) : void
      {
         this.printMatchDetails(this.championSelectionViewModel.championSelectionState);
      }
      
      public function printMatchDetails(param1:String) : void
      {
         if(this.selectionData.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_TOURNAMENT)
         {
            return;
         }
         var _loc2_:ICommand = this.commandFactory.getPrintMatchDetailsCommand(this.championSelectionViewModel.chatRoom,param1,this.currentMatchDetailsMessages);
         _loc2_.execute();
      }
      
      protected function createSpellSelections() : void
      {
         var _loc1_:ICommand = this.commandFactory.getCreateSpellSelectionsCommand(this.championSelectionViewModel,this.championSelectionViewModel.currentGame.gameMode,this.selectionData.session.summonerLevel.summonerLevel);
         _loc1_.execute();
      }
      
      public function onRerollSuccess(param1:Object = null) : void
      {
         this.rerollUpdated.dispatch(this);
      }
      
      public function requestTrade(param1:PlayerSelection) : void
      {
         if(this.championTradeController)
         {
            this.championTradeController.requestTrade(param1.participant as PlayerParticipant,param1.champion);
         }
      }
      
      private function cleanupChatRoom() : void
      {
         var _loc1_:ICommand = this.commandFactory.getCloseChatRoomCommand(this.championSelectionViewModel);
         _loc1_.execute();
      }
      
      private function cleanupUpdateController() : void
      {
         if(this.gameUpdateController)
         {
            this.gameUpdateController.stop();
            this.gameUpdateController = null;
         }
         if(this.championSelectionViewModel)
         {
            this.championSelectionViewModel.removeEventListener(ChampionSelectionModel.CURRENT_GAME_CHANGED,this.onGameUpdated);
         }
         if(this.summonChampionController != null)
         {
            this.summonChampionController.destroy();
         }
      }
      
      private function tryToAck() : Boolean
      {
         if(this.championSelectionViewModel.isSpectating)
         {
            this.hasAcked = true;
            return true;
         }
         var _loc1_:Boolean = !this.hasAcked;
         if(_loc1_)
         {
            this.hasAcked = true;
            this.serviceProxy.gameService.setClientReceivedGameMessage(this.championSelectionViewModel.currentGame.id,"CHAMP_SELECT_CLIENT",this.onChampionSelectAckSuccess,null,this.onChampionSelectAckError);
            return true;
         }
         return false;
      }
      
      public function switchToChampions() : void
      {
         this.championSelectionViewModel.setMainMenuToChampions();
      }
      
      public function lockInChoices() : void
      {
         if(this.championSelectionViewModel.championSelectionState != GameState.PRE_CHAMPION_SELECTION)
         {
            this.championSelectionViewModel.championSelectionIsBusy = true;
            this.serviceProxy.gameService.championSelectCompleted(null,function():*
            {
               championSelectionViewModel.championSelectionIsBusy = false;
            });
         }
      }
      
      public function leaveChampionSelection() : void
      {
         ChampSelectTracker.instance.champSelectCancelled();
         this.cleanupChatRoom();
         this.cleanupChampionSelection();
         dispatchEvent(new GameEvent(GameEvent.END_CHAMPION_SELECTION,this.championSelectionViewModel.currentGame));
      }
      
      private function setChampionSelectionsAvailability(param1:Object = null) : void
      {
         var _loc2_:ICommand = this.commandFactory.getSetVisibleChampionsCommand(this.championSelectionViewModel,this.championSelectionViewModel.championSelectionState,this.championSelectionViewModel.isSpectating,this.championSelectionViewModel.currentGame.gameType == GameType.TUTORIAL_GAME,GameType.isRanked(this.championSelectionViewModel.currentGame.gameType));
         _loc2_.execute();
      }
      
      private function startReroll() : void
      {
         var _loc3_:ARAMPlayerParticipant = null;
         var _loc4_:uint = 0;
         var _loc1_:GameDTO = this.championSelectionViewModel.currentGame;
         var _loc2_:PlayerParticipant = null;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.teamOne.length)
         {
            _loc2_ = _loc1_.teamOne.getItemAt(_loc4_) as PlayerParticipant;
            if((_loc2_ is ARAMPlayerParticipant) && (_loc2_.isMe))
            {
               _loc3_ = _loc2_ as ARAMPlayerParticipant;
               RerollProviderProxy.instance.setPointSummary(_loc3_.pointSummary);
               return;
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.teamTwo.length)
         {
            _loc2_ = _loc1_.teamTwo.getItemAt(_loc4_) as PlayerParticipant;
            if((_loc2_ is ARAMPlayerParticipant) && (_loc2_.isMe))
            {
               _loc3_ = _loc2_ as ARAMPlayerParticipant;
               RerollProviderProxy.instance.setPointSummary(_loc3_.pointSummary);
               return;
            }
            _loc4_++;
         }
      }
      
      private function onChatRoomCreated(param1:ChatRoom) : void
      {
         if(this.banController)
         {
            this.banController.chatRoom = param1;
         }
         this.printMatchDetails(this.championSelectionViewModel.championSelectionState);
      }
      
      private function onGameUpdated(param1:Event) : void
      {
         var _loc3_:ICommand = null;
         var _loc4_:PlayerChampionSelectionDTO = null;
         var _loc5_:ICommand = null;
         var _loc6_:ICommand = null;
         var _loc7_:NativeWindow = null;
         var _loc2_:GameDTO = this.championSelectionViewModel.currentGame;
         if(_loc2_)
         {
            this.championSelectionViewModel.championSelectionState = _loc2_.gameState;
            if(this.hasAcked)
            {
               this.hasConfirmedAck = true;
            }
            if(this.banController)
            {
               this.banController.updateBannedChampionStates();
            }
            _loc3_ = this.commandFactory.getGameUpdateCommand(this.championSelectionViewModel,this.championSelectionViewModel.championSelections,this.selectionData.session.accountSummary.accountId,this.selectionData.playerRoster);
            _loc3_.execute();
            if(!this.championSelectionViewModel.isSpectating)
            {
               _loc4_ = this.championSelectionViewModel.currentGame.getSelectionForSummonerName(this.championSelectionViewModel.currentPlayerParticipant.summonerInternalName);
               _loc5_ = this.commandFactory.getUpdateSpellSelectionFromDtoCommand(this.championSelectionViewModel.currentPlayerSelection,_loc4_,this.championSelectionViewModel.allSpells);
               _loc5_.execute();
            }
            if(this.championSelectionViewModel.currentPlayerParticipant)
            {
               if((!(this.championSelectionViewModel.currentPickMode == this.championSelectionViewModel.currentPlayerParticipant.pickMode)) && (this.championSelectionViewModel.currentPlayerParticipant.pickMode == GameParticipant.PICK_MODE_ACTIVE))
               {
                  _loc6_ = this.commandFactory.getPlaySoundCommand(AudioKeys.NEW_SOUND_YOUR_TURN);
                  _loc6_.execute();
                  _loc7_ = NativeApplication.nativeApplication.openedWindows[0];
                  _loc7_.activate();
                  _loc7_.orderToFront();
                  _loc7_.alwaysInFront = true;
                  _loc7_.alwaysInFront = false;
               }
               else if((!(this.championSelectionViewModel.currentPickMode == this.championSelectionViewModel.currentPlayerParticipant.pickMode)) && (!(this.championSelectionViewModel.currentPlayerParticipant.pickMode == GameParticipant.PICK_MODE_ACTIVE)))
               {
                  _loc6_ = this.commandFactory.getPlaySoundCommand(AudioKeys.NEW_SOUND_CHALK_CHECK);
                  _loc6_.execute();
               }
               
               this.championSelectionViewModel.currentPickMode = this.championSelectionViewModel.currentPlayerParticipant.pickMode;
            }
            else
            {
               this.championSelectionViewModel.currentPickMode = GameParticipant.PICK_MODE_NOT_PICKING;
            }
            this.championSelectionViewModel.pickTurn = _loc2_.pickTurn;
            if(!this.hasAcked)
            {
               this.tryToAck();
            }
            if((this.championSelectionViewModel.championSelectionState == GameState.POST_CHAMPION_SELECTION) && (!this.championSelectionViewModel.isSpectating) && (this.championSelectionViewModel.gameTypeConfig.allowTrades))
            {
               if(!this.championTradeController)
               {
                  this.championTradeController = new PlatformChampionTradeController(this.serviceProxy.messageRouterService,this.serviceProxy.championTradeService,this.championSelectionViewModel,new ChampionTrade(),this.commandFactory,this.context.getDependency(IInventory));
                  this.championTradeController.initialize();
               }
            }
            if((this.banController) && (!(this.championSelectionViewModel.championSelectionState == GameState.PRE_CHAMPION_SELECTION)))
            {
               this.banController = null;
               this.setChampionSelectionsAvailability();
            }
            if(this.championSelectionTipsController)
            {
               this.championSelectionTipsController.updateGame();
            }
            this.championSelectionViewModel.featuredGameInfo = _loc2_.featuredGameInfo;
            if((!this.championSelectionViewModel.isSpectating) && (!((GameState.isInChampionSelectionState(_loc2_.gameState)) || (_loc2_.gameState == GameState.START_REQUESTED))))
            {
               this.leaveChampionSelection();
            }
            else if(this.champSelectAbandoned())
            {
               this.leaveChampionSelection();
            }
            else if(_loc2_.gameState == GameState.START_REQUESTED)
            {
               this.completeChampionSelect();
            }
            
            
         }
      }
      
      public function confirmSpells(param1:Spell, param2:Spell) : void
      {
         if(param1 == null)
         {
            var param1:Spell = this.championSelectionViewModel.currentPlayerSelection.spell1;
            if(param1 == param2)
            {
               param1 = this.championSelectionViewModel.currentPlayerSelection.spell2;
            }
         }
         if(param2 == null)
         {
            var param2:Spell = this.championSelectionViewModel.currentPlayerSelection.spell2;
            if(param1 == param2)
            {
               param2 = this.championSelectionViewModel.currentPlayerSelection.spell1;
            }
         }
         var _loc3_:SpellSelection = SpellUtils.getSelectionForSpellFromSelectionCollection(param1,this.championSelectionViewModel.allSpells);
         var _loc4_:SpellSelection = SpellUtils.getSelectionForSpellFromSelectionCollection(param2,this.championSelectionViewModel.allSpells);
         if((_loc3_.selected) && (_loc4_.selected) && (param1 == this.championSelectionViewModel.currentPlayerSelection.spell1) && (param2 == this.championSelectionViewModel.currentPlayerSelection.spell2))
         {
            return;
         }
         var _loc5_:ICommand = this.commandFactory.getSpellSelectCommand(_loc3_.spell,_loc4_.spell,this.championSelectionViewModel);
         _loc5_.execute();
      }
      
      public function acceptTrade() : void
      {
         if(this.championTradeController)
         {
            this.championTradeController.acceptTrade();
         }
      }
      
      private function loadTips() : void
      {
         this.championSelectionTipsController = new ChampionSelectionTipsController(this.selectionData.parentDisplay,this.context.getDependency(ITipPopupManager),this.championSelectionViewModel,this.context.getDependency(ISoundProvider));
      }
      
      private function playMusic() : void
      {
         var _loc1_:ICommand = this.commandFactory.getPlayMusicCommand(this.championSelectionViewModel.currentGame.gameMode,this.championSelectionViewModel.currentGame.gameType,!(this.selectionData.gameMap == null)?this.selectionData.gameMap.mapId:-1,this.championSelectionViewModel.gameTypeConfig);
         _loc1_.execute();
      }
      
      public function onRerollError(param1:ServerError = null) : void
      {
         var _loc3_:AlertAction = null;
         var _loc4_:String = null;
         var _loc2_:IResourceManager = ResourceManager.getInstance();
         if(param1.exception is GameException)
         {
            _loc4_ = _loc2_.getString("resources","championSelection_rerollCriticalError");
            RerollProviderProxy.instance.getPointsBalance(this.onRerollSuccess,null,null);
         }
         else
         {
            _loc4_ = _loc2_.getString("resources",param1.errorCode,param1.messageArguments);
         }
         _loc3_ = new AlertAction(_loc2_.getString("resources","championSelection_rerollErrorTitle"),_loc4_);
         _loc3_.add();
      }
      
      private function cleanupSoundManager() : void
      {
         var _loc1_:ISoundProvider = this.context.getDependency(ISoundProvider);
         if(_loc1_)
         {
            _loc1_.stopBackgroundMusic();
         }
      }
      
      public function openTutorialSpellSelect() : void
      {
         if(this.advancedTutorialController)
         {
            this.advancedTutorialController.openSpellSelect();
         }
      }
      
      private function cleanupTutorialController() : void
      {
         if(this.advancedTutorialController)
         {
            this.advancedTutorialController.destroy();
            this.advancedTutorialController.removeEventListener("logout",this.requestLogout);
            this.advancedTutorialController = null;
         }
      }
      
      private function summonChampion(param1:Champion) : void
      {
         if(!this.summonChampionController)
         {
            this.summonChampionController = new SummonChampionController(this.championSelectionViewModel,this.championSelectionViewModel.championSelections,this.serviceProxy.gameService,this.context.getDependency(ISoundProvider));
         }
         this.summonChampionController.summonChampion(param1);
      }
      
      public function completeChampionSelect() : void
      {
         if(!this.championSelectionViewModel.isSpectating)
         {
            this.commandFactory.getChangeChampionPresenceCommand(this.championSelectionViewModel.currentPlayerSelection.champion).execute();
         }
         ChampSelectTracker.instance.enterGame();
         this.cleanupChampionSelection();
         dispatchEvent(new GameEvent(GameEvent.COMPLETE_CHAMPION_SELECT,this.championSelectionViewModel.currentGame));
      }
      
      private function cleanupMasteriesManager() : void
      {
         if(this.masteriesManager)
         {
            this.masteriesManager.destroy();
            this.masteriesManager = null;
         }
      }
      
      public function startup() : void
      {
         var _loc2_:ICommand = null;
         this.commandFactory = this.context.getDependency(IChampionSelectionCommandFactory);
         this.printMatchDetails(null);
         this.championSelectionViewModel.chatController = this.selectionData.chatController;
         if(this.championSelectionViewModel.chatController)
         {
            this.championSelectionViewModel.chatController.changePresence(PresenceStatusXML.GAME_STATUS_CHAMPION_SELECT);
         }
         this.arrowedAlertController = this.selectionData.arrowedAlertController;
         this.glowController = this.selectionData.glowController;
         this.alerter = this.context.getDependency(IAlerterProvider);
         this.serviceProxy = this.context.getDependency(ServiceProxy);
         this.commandFactory.getChangeChampionPresenceCommand(null).execute();
         this.championSelectionViewModel.addEventListener(ChampionSelectionModel.CURRENT_GAME_CHANGED,this.onGameUpdated,false,0,true);
         this.championSelectionViewModel.addEventListener(ChampionSelectionModel.CURRENT_PLAYER_SELECTION_CHANGED,this.onCurrentPlayerSelectionChanged,false,0,true);
         this.championSelectionViewModel.addEventListener(ChampionSelectionModel.CHAMPION_SELECTION_STATE_CHANGED,this.onChampionSelectionStateChanged,false,0,true);
         this.championSelectionViewModel.onRequestSkinSelection.add(this.onPlayerChangedSelectedSkin);
         this.createSpellSelections();
         if((this.championSelectionViewModel.currentGame) && (this.championSelectionViewModel.currentGame.gameType == GameType.TUTORIAL_GAME))
         {
            this.enableTutorial();
         }
         if(!this.championSelectionViewModel.isSpectating)
         {
            this.loadMasteries();
            this.loadTips();
         }
         else
         {
            this.createSpectatorDelayManager();
         }
         var _loc1_:ICommand = this.commandFactory.getDisabledChampionsForGameCommand(this.championSelectionViewModel.currentGame,this.championSelectionViewModel.championSelections);
         _loc1_.execute();
         if(this.championSelectionViewModel.currentGame.gameState == GameState.PRE_CHAMPION_SELECTION)
         {
            this.banController = new BanController(this.championSelectionViewModel,this.championSelectionViewModel.chatRoom,this.commandFactory);
            this.banController.start();
         }
         else if((this.championSelectionViewModel.gameTypeConfig.votePickGameTypeConfig) && (!this.championSelectionViewModel.isSpectating))
         {
            _loc2_ = this.commandFactory.getInitializeBannableChampionsCommand(this.championSelectionViewModel);
            _loc2_.addResponder(this.setChampionSelectionsAvailability);
            _loc2_.execute();
         }
         
         this.startGameUpdates();
         this.startReroll();
         this.setChampionSelectionsAvailability();
         this.onGameUpdated(null);
         this.tryToCreateChatRoom();
         this.playMusic();
         this.enableReconnector();
         ChampSelectTracker.instance.enterChampSelect(this.championSelectionViewModel.currentGame,this.championSelectionViewModel.gameTypeConfig);
      }
      
      private function disableReconnector() : void
      {
         if(this.championSelectionReconnector != null)
         {
            this.championSelectionReconnector.championSelectionViewModel = null;
         }
      }
      
      public function selectChampion(param1:Champion) : void
      {
         var _loc2_:ParticipantChampionSelection = null;
         if(this.championSelectionViewModel.currentPlayerParticipant.pickMode != GameParticipant.PICK_MODE_ACTIVE)
         {
            return;
         }
         if(!this.isChampionAvailableForChoosing(param1))
         {
            return;
         }
         this.tryToAck();
         if(this.championSelectionViewModel.championSelectionState == GameState.CHAMPION_SELECTION)
         {
            _loc2_ = this.championSelectionViewModel.championSelections.getSelectionByChampion(param1);
            if(!_loc2_.banned)
            {
               this.summonChampion(param1);
            }
         }
         else if(this.championSelectionViewModel.championSelectionState == GameState.PRE_CHAMPION_SELECTION)
         {
            if(param1.active)
            {
               this.banChampion(param1);
            }
         }
         
      }
      
      public function showChampionDetailsPage(param1:Champion) : void
      {
         if((!(param1 == null)) && (!param1.isWildCardChampion()))
         {
            this.championDetailProvider = ChampionDetailProviderProxy.instance;
            this.championDetailProvider.displayChampionDetailView(ChampionDetailContext.CHAMPION_SELECT,param1);
         }
      }
      
      private function banChampion(param1:Champion) : void
      {
         this.banController.banChampion(param1);
      }
      
      private function get tipPopupManager() : ITipPopupManager
      {
         return this.context.getDependency(ITipPopupManager);
      }
      
      private function createSpectatorDelayManager() : void
      {
         this.spectatorDelayManager = new SpectatorDelayManager(this.championSelectionViewModel);
         this.spectatorDelayManager.addEventListener(SpectatorDelayManager.DELAY_EXPIRED,this.onDelayExpired,false,0,true);
      }
      
      public function useReroll() : void
      {
         RerollProviderProxy.instance.useReroll(this.onRerollSuccess,null,this.onRerollError);
      }
      
      private function onChampionSelectAckError() : void
      {
         trace("error");
      }
      
      private function tryToCreateChatRoom() : void
      {
         var _loc1_:ICommand = this.commandFactory.getCreateChatRoomCommand(this.championSelectionViewModel.currentGame,this.championSelectionViewModel);
         _loc1_.addResponder(this.onChatRoomCreated);
         _loc1_.execute();
      }
      
      private function onDelayExpired(param1:Event) : void
      {
         this.leaveChampionSelection();
      }
      
      public function refuseTrade() : void
      {
         if(this.championTradeController)
         {
            this.championTradeController.rejectTrade();
         }
      }
      
      public function getRerollUpdated() : ISignal
      {
         return this.rerollUpdated;
      }
      
      private function startGameUpdates() : void
      {
         this.gameUpdateController = new GameUpdateController(this.championSelectionViewModel,this.serviceProxy.gameService,this.serviceProxy.messageRouterService,this.alerter);
         this.gameUpdateController.start();
      }
      
      private function closeChampionDetailsPage() : void
      {
         if(this.championDetailProvider != null)
         {
            this.championDetailProvider.close();
         }
      }
      
      private function onCurrentPlayerSelectionChanged(param1:Event) : void
      {
         if(this.championSelectionViewModel.currentPlayerSelection == null)
         {
            return;
         }
         if(!this.championSkinController)
         {
            this.championSkinController = new ChampionSkinController(this.championSelectionViewModel,this.commandFactory);
         }
      }
      
      public function setMasteryPage(param1:MasteryPageInfoSummary) : void
      {
         if(this.masteriesManager)
         {
            this.masteriesManager.setMasteryPage(param1);
         }
      }
      
      private function isChampionAvailableForChoosing(param1:Champion) : Boolean
      {
         var _loc2_:ParticipantChampionSelection = null;
         var _loc3_:ParticipantChampionSelection = null;
         if(!param1)
         {
            return false;
         }
         if(this.championSelectionViewModel.isSpectating)
         {
            return true;
         }
         if(!param1.active)
         {
            return false;
         }
         if(this.championSelectionViewModel.championSelectionState == GameState.PRE_CHAMPION_SELECTION)
         {
            _loc2_ = this.championSelectionViewModel.championSelections.getSelectionByChampion(param1);
            return !_loc2_.banned;
         }
         if((this.championSelectionViewModel) && (this.championSelectionViewModel.championSelections) && (!(this.championSelectionViewModel.championSelections.filterFunction == null)))
         {
            _loc3_ = this.championSelectionViewModel.championSelections.getSelectionByChampion(param1);
            return this.championSelectionViewModel.championSelections.filterFunction.apply(this,[_loc3_]);
         }
         return param1.isAvailable(this.championSelectionViewModel.allowFreeChampions);
      }
      
      private function onPlayerChangedSelectedSkin(param1:ISignal, param2:ChampionSkin) : void
      {
         this.championSkinController.useSkin(param2);
      }
      
      private function onChampionSelectAckSuccess(param1:ResultEvent) : void
      {
         if((!(this.championSelectionViewModel.currentGame.gameType == GameType.TUTORIAL_GAME)) && (!(this.gameUpdateController == null)))
         {
            this.gameUpdateController.requestGameState();
         }
      }
      
      private function cleanupChampionSelection() : void
      {
         this.disableReconnector();
         this.tipPopupManager.removeAllPopups();
         this.cleanupUpdateController();
         this.cleanupTips();
         this.closeChampionDetailsPage();
         this.cleanupTutorialController();
         this.cleanupTradeController();
         this.cleanupMasteriesManager();
         this.cleanupSoundManager();
         this.cleanupReroll();
         this.championSelectionViewModel.removeEventListener(ChampionSelectionModel.CURRENT_GAME_CHANGED,this.onGameUpdated);
         this.championSelectionViewModel.removeEventListener(ChampionSelectionModel.CURRENT_PLAYER_SELECTION_CHANGED,this.onCurrentPlayerSelectionChanged);
         this.championSelectionViewModel.removeEventListener(ChampionSelectionModel.CHAMPION_SELECTION_STATE_CHANGED,this.onChampionSelectionStateChanged);
         this.championSelectionViewModel.onRequestSkinSelection.remove(this.onPlayerChangedSelectedSkin);
      }
      
      public function quitGame() : void
      {
         ChampSelectTracker.instance.quitChampSelect();
         this.cleanupUpdateController();
         this.cleanupChatRoom();
         this.cleanupChampionSelection();
         dispatchEvent(new GameEvent(GameEvent.ABORT_CHAMPION_SELECTION,this.championSelectionViewModel.currentGame));
      }
      
      private function cleanupTradeController() : void
      {
         if(this.championTradeController)
         {
            this.championTradeController.destroy();
            this.championTradeController = null;
         }
      }
      
      private function loadMasteries() : void
      {
         if(!this.masteriesManager)
         {
            this.masteriesManager = new MasteriesManager(this.championSelectionViewModel);
         }
         this.masteriesManager.loadMasteries();
      }
      
      private function cleanupReroll() : void
      {
         RerollProviderProxy.instance.updateRerollCache();
      }
      
      private function requestLogout(param1:Event) : void
      {
         this.quitGame();
      }
      
      private function cleanupTips() : void
      {
         if(this.championSelectionTipsController)
         {
            this.championSelectionTipsController.destroy();
            this.championSelectionTipsController = null;
         }
      }
      
      public function closeTutorialSpellSelect() : void
      {
         if(this.advancedTutorialController)
         {
            this.advancedTutorialController.closeSpellSelect();
         }
      }
      
      private function enableReconnector() : void
      {
         if(this.championSelectionReconnector == null)
         {
            this.championSelectionReconnector = new ChampionSelectionReconnector(this,this.gameUpdateController);
         }
         this.championSelectionReconnector.championSelectionViewModel = this.championSelectionViewModel;
      }
   }
}
