package com.riotgames.platform.gameclient.controllers.game.help
{
   import flash.events.EventDispatcher;
   import com.riotgames.platform.gameclient.domain.Champion;
   import flash.utils.clearTimeout;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.util.string.RiotStringUtil;
   import com.riotgames.platform.common.audio.AudioKeys;
   import com.riotgames.pvpnet.system.game.GameProviderProxy;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.platform.gameclient.controllers.game.views.popup.ITipPopupManager;
   import com.riotgames.platform.common.provider.ISoundProvider;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import flash.display.DisplayObject;
   import com.riotgames.platform.gameclient.domain.game.TeamColors;
   import mx.events.PropertyChangeEvent;
   import flash.events.Event;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.domain.game.GameType;
   import com.riotgames.pvpnet.system.config.UserPreferencesManager;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import flash.utils.setTimeout;
   
   public class ChampionSelectionTipsController extends EventDispatcher
   {
      
      public static const EVENT_NEW_TURN:String = "newTurnEvent";
      
      public static const CS_BIG_FONT_SIZE:uint = 25;
      
      public static const STATE_POST_PICK_REROLL:String = "postPickReroll";
      
      public static const STATE_YOUR_BAN_TURN_2:String = "banTurn2";
      
      public static const STATE_NOT_BANNING:String = "notBanning";
      
      public static const STATE_TURN_DONE:String = "turnOver";
      
      public static const STATE_POTENTIAL_BANNER:String = "potentialBanner";
      
      public static const CS_ORANGE:String = "#E38914";
      
      public static const STATE_GAME_STARTING:String = "gameStarting";
      
      public static const STATE_POST_PICK:String = "postPick";
      
      public static const STATE_YOUR_PICK_TURN:String = "pickTurn";
      
      public static const TOOLTIP_NEWBIE:String = "newbie";
      
      public static const TOOLTIP_RANKED:String = "ranked";
      
      public static const STATE_PICK_LOCK_IN:String = "lockInPick";
      
      private static const TOOLTIP_X_POS:Number = 744;
      
      private static const TOOLTIP_Y_POS:Number = 413;
      
      public static const STATE_UPCOMING_TURN:String = "upcomingTurn";
      
      public static const STATE_YOUR_BAN_TURN_1:String = "banTurn1";
      
      public static const STATE_YOUR_BAN_TURN_3:String = "banTurn3";
      
      private var shownPickWaitingTip:Boolean = false;
      
      private var tipHeader:String;
      
      private var tipPopupManager:ITipPopupManager;
      
      protected var soundManager:ISoundProvider;
      
      private var shownPostPickTip:Boolean = false;
      
      private var parent:DisplayObject;
      
      private var shownPickConfirmedTip:Boolean = false;
      
      private var shownRerollTip:Boolean = false;
      
      private var turnEndingSoonPickTurn:int = -1;
      
      private var shownLockInTip:Boolean = false;
      
      private var shownActivePickTip:Boolean = false;
      
      private var championSelectionModel:ChampionSelectionModel;
      
      private var timeoutId:uint;
      
      private var _currentState:String = "";
      
      private var shownNotBanningTip:Boolean = false;
      
      public function ChampionSelectionTipsController(param1:DisplayObject, param2:ITipPopupManager, param3:ChampionSelectionModel, param4:ISoundProvider)
      {
         super();
         this.championSelectionModel = param3;
         this.soundManager = param4;
         this.parent = param1;
         this.tipPopupManager = param2;
         this.activate();
      }
      
      private function hasChampionPicked() : Boolean
      {
         var _loc1_:Champion = this.championSelectionModel.getPickedChampion();
         return (!(_loc1_ == null)) && (!_loc1_.isRandomChampion());
      }
      
      public function destroy() : void
      {
         clearTimeout(this.timeoutId);
         this.timeoutId = 0;
         this.tipPopupManager.removeAllPopups();
         this.championSelectionModel.removeEventListener(ChampionSelectionModel.TIME_REMAINING_SECONDS_CHANGED,this.onGameTimerChanged);
      }
      
      private function updateStateDescription() : void
      {
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc1_:uint = CS_BIG_FONT_SIZE;
         var _loc2_:String = CS_ORANGE;
         var _loc3_:String = "</font>";
         var _loc4_:String = "<font size=\'" + _loc1_ + "\'>";
         var _loc5_:String = "<font color=\'" + _loc2_ + "\'>";
         var _loc6_:String = "";
         var _loc7_:String = null;
         switch(this.currentState)
         {
            case STATE_YOUR_BAN_TURN_1:
               _loc6_ = _loc4_;
               _loc6_ = _loc6_ + RiotResourceLoader.getString("championSelection_messageCenter_banTurn1",null,[_loc5_,_loc3_]);
               _loc6_ = _loc6_ + _loc3_;
               _loc6_ = _loc6_ + this.findBanProgress();
               _loc6_ = _loc6_ + this.findTimerWarning();
               break;
            case STATE_YOUR_BAN_TURN_2:
               _loc6_ = _loc4_;
               _loc6_ = _loc6_ + RiotResourceLoader.getString("championSelection_messageCenter_banTurn2",null,[_loc5_,_loc3_]);
               _loc6_ = _loc6_ + _loc3_;
               _loc6_ = _loc6_ + this.findBanProgress();
               _loc6_ = _loc6_ + this.findTimerWarning();
               break;
            case STATE_YOUR_BAN_TURN_3:
               _loc6_ = _loc4_;
               _loc6_ = _loc6_ + RiotResourceLoader.getString("championSelection_messageCenter_banTurn3",null,[_loc5_,_loc3_]);
               _loc6_ = _loc6_ + _loc3_;
               _loc6_ = _loc6_ + this.findBanProgress();
               _loc6_ = _loc6_ + this.findTimerWarning();
               break;
            case STATE_POTENTIAL_BANNER:
               _loc7_ = this.findCurrentActivePlayers();
               _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_potentialBanner",null,[_loc7_]);
               _loc6_ = _loc6_ + this.findBanProgress();
               break;
            case STATE_NOT_BANNING:
               _loc7_ = this.findCurrentActivePlayers();
               if(this.championSelectionModel.isSpectating)
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_spectator_notBanner",null,[_loc7_]);
               }
               else
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_notBanner",null,[_loc7_]);
               }
               _loc6_ = _loc6_ + this.findBanProgress();
               break;
            case STATE_YOUR_PICK_TURN:
               _loc6_ = _loc4_;
               _loc9_ = this.votePick?"championSelection_messageCenter_vote":"championSelection_messageCenter_yourTurn";
               _loc6_ = _loc6_ + RiotResourceLoader.getString(_loc9_,null,[_loc5_,_loc3_]);
               _loc6_ = _loc6_ + _loc3_;
               _loc6_ = _loc6_ + this.findTimerWarning();
               break;
            case STATE_PICK_LOCK_IN:
               _loc6_ = _loc4_;
               _loc10_ = this.votePick?"championSelection_messageCenter_vote":"championSelection_messageCenter_lockIn";
               _loc6_ = _loc6_ + RiotResourceLoader.getString(_loc10_,null,[_loc5_,_loc3_]);
               _loc6_ = _loc6_ + _loc3_;
               _loc6_ = _loc6_ + this.findTimerWarning();
               break;
            case STATE_UPCOMING_TURN:
               _loc7_ = this.findCurrentActivePlayers();
               if(this.championSelectionModel.isSpectating)
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_turnDone",null,[_loc7_]);
               }
               else if(!this.championSelectionModel.isOccludingActivePickTurns)
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_upcomingTurn",null,[_loc7_]);
               }
               
               break;
            case STATE_TURN_DONE:
               if(!this.championSelectionModel.isOccludingActivePickTurns)
               {
                  _loc7_ = this.findCurrentActivePlayers();
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_turnDone",null,[_loc7_]);
               }
               break;
            case STATE_POST_PICK_REROLL:
               if(this.championSelectionModel.timeRemainingSeconds <= 0)
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_gameStartSoon");
               }
               else
               {
                  _loc6_ = RiotResourceLoader.getString("championSelection_messageCenter_postPickARAM","**Your champion has been randomly selected.");
               }
               break;
            case STATE_POST_PICK:
               if(this.championSelectionModel.timeRemainingSeconds <= 0)
               {
                  _loc6_ = "<font color=\'#FF5555\'>";
                  _loc6_ = _loc6_ + RiotResourceLoader.getString("championSelection_messageCenter_gameStartSoon");
                  _loc6_ = _loc6_ + "</font>";
               }
               else if(this.championSelectionModel.isSpectating)
               {
                  _loc6_ = "<font color=\'#FF5555\'>";
                  _loc6_ = _loc6_ + RiotResourceLoader.getString("championSelection_messageCenter_spectatorWait","**Waiting for all players to select champions");
                  _loc6_ = _loc6_ + "</font>";
               }
               else
               {
                  _loc11_ = this.getSpecialPickOutcome();
                  if(!RiotStringUtil.isEmpty(_loc11_))
                  {
                     _loc12_ = RiotResourceLoader.getString("championSelection_messageCenter_pickOutcome_" + _loc11_,null,[_loc5_,_loc3_]);
                     _loc6_ = _loc4_ + _loc12_ + _loc3_;
                  }
                  else
                  {
                     _loc6_ = "";
                  }
               }
               
               break;
            case STATE_GAME_STARTING:
               _loc6_ = this.championSelectionModel.currentGame.queuePosition > 1?RiotResourceLoader.getString("championSelection_queuedPositionWaitLabel",null,[this.championSelectionModel.currentGame.queuePosition]):RiotResourceLoader.getString("championSelection_queuedPosition1Label");
               if(this.championSelectionModel.currentGame.queuePosition == 1)
               {
                  this.soundManager.stopBackgroundMusic();
                  this.soundManager.play(AudioKeys.SOUND_GAME_STARTING);
               }
               break;
         }
         var _loc8_:GameFlowVariant = GameProviderProxy.instance.getCurrentGameFlowVariant();
         if(_loc8_ != null)
         {
            _loc13_ = _loc8_.getCustomChampionSelectionStateDescription(this.currentState,this.championSelectionModel.currentGame,this.championSelectionModel.isSpectating,this.championSelectionModel.isOccludingActivePickTurns,this.championSelectionModel.timeRemainingSeconds,_loc7_);
            if(!RiotStringUtil.isEmpty(_loc13_))
            {
               _loc6_ = _loc13_;
            }
         }
         this.championSelectionModel.stateDescriptionText = _loc6_;
      }
      
      public function get currentState() : String
      {
         return this._currentState;
      }
      
      private function checkPickTips() : TipData
      {
         var _loc1_:String = null;
         if(this.championSelectionModel.currentPickMode == GameParticipant.PICK_MODE_ACTIVE)
         {
            if(this.hasChampionPicked())
            {
               this.currentState = STATE_PICK_LOCK_IN;
               if(!this.shownLockInTip)
               {
                  this.shownLockInTip = true;
                  _loc1_ = this.votePick?"championSelection_newbietip_votePick_voting":"championSelection_newbietip_lockInTip";
                  return new TipData(RiotResourceLoader.getString(_loc1_),989);
               }
            }
            else
            {
               this.currentState = STATE_YOUR_PICK_TURN;
               if(!this.shownActivePickTip)
               {
                  this.shownActivePickTip = true;
                  this.dispatchNewTurnEvent();
                  _loc1_ = this.votePick?"championSelection_newbietip_votePick_voting":"championSelection_newbietip_pickActiveTip";
                  return new TipData(RiotResourceLoader.getString(_loc1_),989);
               }
            }
         }
         else if(this.hasChampionPicked())
         {
            this.currentState = STATE_TURN_DONE;
            if((!this.shownPickConfirmedTip) && (!this.votePick))
            {
               this.shownPickConfirmedTip = true;
               return new TipData(RiotResourceLoader.getString("championSelection_newbietip_pickConfirmedTip"));
            }
         }
         else
         {
            this.currentState = STATE_UPCOMING_TURN;
            if(!this.shownPickWaitingTip)
            {
               this.shownPickWaitingTip = true;
               return new TipData(RiotResourceLoader.getString("championSelection_newbietip_pickWaitingTip"));
            }
         }
         
         return null;
      }
      
      private function get votePick() : Boolean
      {
         return this.championSelectionModel.gameTypeConfig.votePickGameTypeConfig;
      }
      
      private function findCurrentActivePlayers() : String
      {
         var _loc3_:GameParticipant = null;
         var _loc4_:GameParticipant = null;
         var _loc1_:Boolean = true;
         var _loc2_:String = "";
         for each(_loc3_ in this.championSelectionModel.currentTeam)
         {
            if(_loc3_.pickMode == GameParticipant.PICK_MODE_ACTIVE)
            {
               if(!_loc1_)
               {
                  _loc2_ = _loc2_ + ",";
               }
               else
               {
                  _loc1_ = false;
               }
               _loc2_ = _loc2_ + (" " + "<font color=\'" + TeamColors.FRIENDLY_TEAM_COLOR + "\'>" + _loc3_.summonerName + "</font>");
            }
         }
         for each(_loc4_ in this.championSelectionModel.enemyTeam)
         {
            if(_loc4_.pickMode == GameParticipant.PICK_MODE_ACTIVE)
            {
               if(!_loc1_)
               {
                  _loc2_ = _loc2_ + ",";
               }
               else
               {
                  _loc1_ = false;
               }
               _loc2_ = _loc2_ + (" " + "<font color=\'" + TeamColors.ENEMY_TEAM_COLOR + "\'>" + _loc4_.summonerName + "</font>");
            }
         }
         return _loc2_;
      }
      
      public function set currentState(param1:String) : void
      {
         var _loc2_:Object = this.currentState;
         if(_loc2_ !== param1)
         {
            this._1457822360currentState = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentState",_loc2_,param1));
         }
      }
      
      private function checkBanTips() : TipData
      {
         if(this.votePick)
         {
            return null;
         }
         if(this.championSelectionModel.currentPickMode == GameParticipant.PICK_MODE_ACTIVE)
         {
            switch(this.championSelectionModel.pickTurn)
            {
               case 1:
                  this.currentState = STATE_YOUR_BAN_TURN_1;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip1"));
               case 2:
                  this.currentState = STATE_YOUR_BAN_TURN_1;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip1"));
               case 3:
                  this.currentState = STATE_YOUR_BAN_TURN_2;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip2"));
               case 4:
                  this.currentState = STATE_YOUR_BAN_TURN_2;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip2"));
               case 5:
                  this.currentState = STATE_YOUR_BAN_TURN_3;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip3"));
               case 6:
                  this.currentState = STATE_YOUR_BAN_TURN_3;
                  this.dispatchNewTurnEvent();
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_banTip3"));
            }
         }
         else if(this.isPotentialBanner())
         {
            this.currentState = STATE_POTENTIAL_BANNER;
            switch(this.championSelectionModel.pickTurn)
            {
               case 1:
               case 2:
                  return new TipData(RiotResourceLoader.getString("championSelection_newbietip_potentialBannerTip"));
            }
         }
         else
         {
            this.currentState = STATE_NOT_BANNING;
            if(!this.shownNotBanningTip)
            {
               this.shownNotBanningTip = true;
               return new TipData(RiotResourceLoader.getString("championSelection_newbietip_notBanningTip"));
            }
         }
         
         return null;
      }
      
      private function onGameTimerChanged(param1:Event) : void
      {
         if((this.championSelectionModel.timeRemainingSeconds > 0) && (this.championSelectionModel.timeRemainingSeconds <= 10) && (!(this.championSelectionModel.pickTurn == this.turnEndingSoonPickTurn)) && (this.championSelectionModel.currentPickMode == GameParticipant.PICK_MODE_ACTIVE))
         {
            this.turnEndingSoonPickTurn = this.championSelectionModel.pickTurn;
            this.soundManager.play(AudioKeys.SOUND_TURN_ENDING_SOON);
         }
         if((this.championSelectionModel.timeRemainingSeconds <= 0) && (this.championSelectionModel.championSelectionState == GameState.POST_CHAMPION_SELECTION))
         {
            this.update();
         }
      }
      
      private function update() : void
      {
         if((!this.championSelectionModel.currentGame) || (this.championSelectionModel.isSpectating))
         {
            return;
         }
         if((this.turnEndingSoonPickTurn > -1) && (!(this.turnEndingSoonPickTurn == this.championSelectionModel.pickTurn)))
         {
            this.soundManager.stop(AudioKeys.SOUND_TURN_ENDING_SOON);
         }
         this.updateNewbieTips();
         if((!GameType.IsTutorial(this.championSelectionModel.currentGame.gameType)) && (!this.aramPick))
         {
            if(this.championSelectionModel.timeRemainingSeconds <= 0)
            {
               this.currentState = STATE_GAME_STARTING;
            }
         }
         this.updateStateDescription();
      }
      
      public function updateGame() : void
      {
         this.update();
      }
      
      private function showTip(param1:String, param2:TipData) : void
      {
         if((!UserPreferencesManager.userPrefs.newbieTipsEnabled) && (param1 == TOOLTIP_NEWBIE))
         {
            return;
         }
         if(param2.tipXPos < 0)
         {
            param2.tipXPos = TOOLTIP_X_POS;
         }
         if(param2.tipYPos < 0)
         {
            param2.tipYPos = TOOLTIP_Y_POS;
         }
         if(param2.tipTitle == null)
         {
            param2.tipTitle = this.tipHeader;
         }
         this.tipPopupManager.createTipPopup(this.parent,param1,param2.tipTitle,param2.tipText,param2.tipXPos,param2.tipYPos);
      }
      
      private function updateNewbieTips() : void
      {
         var _loc2_:GameFlowVariant = null;
         var _loc3_:String = null;
         var _loc1_:TipData = null;
         if((GameType.IsTutorial(this.championSelectionModel.currentGame.gameType)) || (this.aramPick))
         {
            _loc1_ = this.checkAllRandomTips();
         }
         else if(this.championSelectionModel.championSelectionState == GameState.PRE_CHAMPION_SELECTION)
         {
            _loc1_ = this.checkBanTips();
         }
         else if(this.championSelectionModel.championSelectionState == GameState.CHAMPION_SELECTION)
         {
            _loc1_ = this.checkPickTips();
         }
         else if(this.championSelectionModel.championSelectionState == GameState.POST_CHAMPION_SELECTION)
         {
            _loc1_ = this.checkPostPickTips();
         }
         
         
         
         if(_loc1_ != null)
         {
            _loc2_ = GameProviderProxy.instance.getCurrentGameFlowVariant();
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.getCustomChampionSelectionNewbieTip(this.currentState,this.championSelectionModel.championSelectionState);
               if(!RiotStringUtil.isEmpty(_loc3_))
               {
                  _loc1_.tipText = _loc3_;
               }
            }
            this.showTip(TOOLTIP_NEWBIE,_loc1_);
         }
      }
      
      private function isPotentialBanner() : Boolean
      {
         var _loc1_:ArrayCollection = this.championSelectionModel.currentTeam;
         var _loc2_:GameParticipant = _loc1_.getItemAt(0) as GameParticipant;
         return _loc2_.isMe;
      }
      
      private function checkPostPickTips() : TipData
      {
         var _loc2_:String = null;
         var _loc1_:TipData = null;
         if(!this.shownPostPickTip)
         {
            this.shownPostPickTip = true;
            this.currentState = STATE_POST_PICK;
            _loc1_ = new TipData(RiotResourceLoader.getString("championSelection_newbietip_postPickTip",null,[this.championSelectionModel.timeRemainingSeconds]));
            if(this.votePick)
            {
               _loc2_ = this.getSpecialPickOutcome();
               if(!RiotStringUtil.isEmpty(_loc2_))
               {
                  _loc1_.tipTitle = RiotResourceLoader.getString("championSelection_newbietip_votePick_resultTitle_" + _loc2_);
                  _loc1_.tipText = RiotResourceLoader.getString("championSelection_newbietip_votePick_resultDescr_" + _loc2_);
               }
            }
            this.soundManager.play(AudioKeys.SOUND_PHASE_CHANGE);
         }
         return _loc1_;
      }
      
      private function set _1457822360currentState(param1:String) : void
      {
         this._currentState = param1;
      }
      
      private function get aramPick() : Boolean
      {
         return this.championSelectionModel.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_ALL_RANDOM;
      }
      
      private function get draftPick() : Boolean
      {
         return (this.championSelectionModel.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_DRAFT_MODE_SINGLE_PICK) || (this.championSelectionModel.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_TOURNAMENT) || (this.championSelectionModel.gameTypeConfig.id == GameTypeConfig.PICK_ID_SIM_BAN) || (this.championSelectionModel.gameTypeConfig.id == GameTypeConfig.PICK_ID_SIM_BAN_SHORT_TIMER) || (this.championSelectionModel.gameTypeConfig.id == GameTypeConfig.PICK_ID_CTR_DRAFT);
      }
      
      private function findBanProgress() : String
      {
         var _loc1_:uint = this.championSelectionModel.gameTypeConfig.maxAllowableBans;
         var _loc2_:uint = this.championSelectionModel.pickTurn;
         var _loc3_:String = " (" + _loc2_ + "/" + _loc1_ + ")";
         return RiotResourceLoader.getString("championSelection_messageCenter_banProgress",null,[_loc3_]);
      }
      
      private function getSpecialPickOutcome() : String
      {
         var _loc2_:* = 0;
         var _loc1_:String = null;
         if((!(this.championSelectionModel.currentGame == null)) && (!(this.championSelectionModel.currentPlayerParticipant == null)))
         {
            _loc2_ = this.championSelectionModel.currentGame.getTeamForPlayer(this.championSelectionModel.currentPlayerParticipant.summonerName);
            switch(_loc2_)
            {
               case 1:
                  _loc1_ = this.championSelectionModel.currentGame.teamOnePickOutcome;
                  break;
               case 2:
                  _loc1_ = this.championSelectionModel.currentGame.teamTwoPickOutcome;
                  break;
            }
         }
         return _loc1_;
      }
      
      private function findTimerWarning() : String
      {
         var _loc1_:String = null;
         if(this.championSelectionModel.timeRemainingSeconds <= 0)
         {
            _loc1_ = "<p></p><font color=\'#FF5555\'>";
            _loc1_ = _loc1_ + RiotResourceLoader.getString("championSelection_messageCenter_timerWarning");
            _loc1_ = _loc1_ + "</font>";
            return _loc1_;
         }
         return "";
      }
      
      public function activate() : void
      {
         var _loc1_:TipData = null;
         if((this.championSelectionModel.currentGame.gameType == "RANKED_GAME") && (UserPreferencesManager.userPrefs.rankedChampionSelectTipsEnabled))
         {
            _loc1_ = new TipData(RiotResourceLoader.getString("championSelection_rankedtip_queueDodge"),-1,210);
            _loc1_.tipTitle = RiotResourceLoader.getString("championSelection_rankedheader_queueDodge");
            this.showTip(TOOLTIP_RANKED,_loc1_);
         }
         if(this.draftPick)
         {
            this.tipHeader = RiotResourceLoader.getString("championSelection_newbieheader_draftPick");
         }
         else if(this.aramPick)
         {
            this.tipHeader = RiotResourceLoader.getString("championSelection_newbieheader_allRandom");
         }
         else if(this.votePick)
         {
            this.tipHeader = RiotResourceLoader.getString("championSelection_newbieheader_votePick");
         }
         else
         {
            this.tipHeader = RiotResourceLoader.getString("championSelection_newbieheader_blindPick");
         }
         
         
         this.championSelectionModel.addEventListener(ChampionSelectionModel.TIME_REMAINING_SECONDS_CHANGED,this.onGameTimerChanged,false,0,true);
         this.timeoutId = setTimeout(this.update,50);
      }
      
      private function checkAllRandomTips() : TipData
      {
         if((!this.shownRerollTip) && (this.championSelectionModel) && (this.championSelectionModel.allowReroll))
         {
            this.shownRerollTip = true;
            this.currentState = STATE_POST_PICK_REROLL;
            return new TipData(RiotResourceLoader.getString("championSelection_newbietip_rerollTip"),989);
         }
         return null;
      }
      
      private function dispatchNewTurnEvent() : void
      {
         dispatchEvent(new Event(EVENT_NEW_TURN));
      }
   }
}

class TipData extends Object
{
   
   public var tipYPos:int = -1;
   
   public var tipXPos:int = -1;
   
   public var tipText:String;
   
   public var tipTitle:String = null;
   
   function TipData(param1:String, param2:int = -1, param3:int = -1)
   {
      super();
      this.tipText = param1;
      this.tipXPos = param2;
      this.tipYPos = param3;
   }
}
