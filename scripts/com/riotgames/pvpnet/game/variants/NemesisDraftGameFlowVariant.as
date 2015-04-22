package com.riotgames.pvpnet.game.variants
{
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.domain.game.TeamColors;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.gameclient.Models.IChampionSelectionPlayerSelectionModel;
   import com.riotgames.platform.gameclient.Models.PlayerSelectionEmphasis;
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class NemesisDraftGameFlowVariant extends FeaturedGameFlowVariant
   {
      
      public static const PICK_STATE_LIGHT_GREY:String = "stateLightGrey";
      
      public static const PICK_STATE_LIGHT_GREY_ARROWS_RIGHT:String = "stateLightGreyArrowsRight";
      
      public static const PICK_STATE_LIGHT_GREY_ARROWS_LEFT:String = "stateLightGreyArrowsLeft";
      
      public static const PICK_STATE_DARK_GREY:String = "stateDarkGrey";
      
      public static const PICK_STATE_ORANGE_ARROWS_RIGHT:String = "stateOrangeArrowsRight";
      
      public static const PICK_STATE_ORANGE_ARROWS_LEFT:String = "stateOrangeArrowsLeft";
      
      public static const PICK_STATE_BLUE:String = "stateBlue";
      
      public static const PICK_STATE_BLUE_ARROWS_RIGHT:String = "stateBlueArrowsRight";
      
      public static const PICK_STATE_BLUE_ARROWS_LEFT:String = "stateBlueArrowsLeft";
      
      public static const STATE_YOUR_BAN_TURN_1:String = "banTurn1";
      
      public static const STATE_YOUR_BAN_TURN_2:String = "banTurn2";
      
      public static const STATE_YOUR_BAN_TURN_3:String = "banTurn3";
      
      public static const STATE_POTENTIAL_BANNER:String = "potentialBanner";
      
      public static const STATE_NOT_BANNING:String = "notBanning";
      
      public static const STATE_YOUR_PICK_TURN:String = "pickTurn";
      
      public static const STATE_PICK_LOCK_IN:String = "lockInPick";
      
      public static const STATE_UPCOMING_TURN:String = "upcomingTurn";
      
      public static const STATE_TURN_DONE:String = "turnOver";
      
      public static const STATE_POST_PICK:String = "postPick";
      
      public static const STATE_POST_PICK_REROLL:String = "postPickReroll";
      
      public static const CS_HUGE_FONT_SIZE:uint = 18;
      
      public static const CS_LARGE_FONT_SIZE:uint = 16;
      
      public static const CS_ORANGE:String = "#E38914";
      
      private var logger:ILogger;
      
      public function NemesisDraftGameFlowVariant()
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
      }
      
      override public function validateStartCustomGame(param1:GameDTO) : String
      {
         if(param1.teamOne.length != param1.teamTwo.length)
         {
            return RiotResourceLoader.getString("enterChampionSelect_validationErrorUnevenTeams");
         }
         return null;
      }
      
      override public function getChampionOverlayPosition() : Point
      {
         return null;
      }
      
      override public function getMatchDetailsMessage(param1:String) : String
      {
         if(param1 == null)
         {
            return RiotResourceLoader.getString("matchDetails_message_intro_ctr");
         }
         if(param1 == GameState.PRE_CHAMPION_SELECTION)
         {
            return RiotResourceLoader.getString("matchDetails_message_ban_ctr");
         }
         if(param1 == GameState.CHAMPION_SELECTION)
         {
            return RiotResourceLoader.getString("matchDetails_message_pick_ctr");
         }
         if(param1 == GameState.POST_CHAMPION_SELECTION)
         {
            return RiotResourceLoader.getString("matchDetails_message_trade_ctr");
         }
         return null;
      }
      
      override public function getCustomLockInButtonLabel() : String
      {
         return RiotResourceLoader.getString("championSelection_lockin_ctr_label");
      }
      
      override public function getCustomChampionSelectionNewbieTip(param1:String, param2:String) : String
      {
         if(param2 == GameState.CHAMPION_SELECTION)
         {
            switch(param1)
            {
               case STATE_PICK_LOCK_IN:
                  return RiotResourceLoader.getString("championSelection_newbietip_ctr_lockInTip");
               case STATE_YOUR_PICK_TURN:
                  return RiotResourceLoader.getString("championSelection_newbietip_ctr_pickActiveTip");
               case STATE_TURN_DONE:
                  return RiotResourceLoader.getString("championSelection_newbietip_ctr_pickConfirmedTip");
               case STATE_UPCOMING_TURN:
                  return RiotResourceLoader.getString("championSelection_newbietip_ctr_pickWaitingTip");
            }
         }
         else if(param2 == GameState.POST_CHAMPION_SELECTION)
         {
            return RiotResourceLoader.getString("championSelection_newbietip_ctr_postPickTip");
         }
         
         return null;
      }
      
      override public function getCustomChampionSelectionStateDescription(param1:String, param2:GameDTO, param3:Boolean, param4:Boolean, param5:int, param6:String) : String
      {
         var _loc7_:String = null;
         var _loc8_:String = "<font size=\'" + CS_HUGE_FONT_SIZE + "\'>";
         var _loc9_:String = "<font size=\'" + CS_LARGE_FONT_SIZE + "\'>";
         var _loc10_:String = "<font color=\'" + CS_ORANGE + "\'>";
         var _loc11_:String = "<font color=\'" + TeamColors.FRIENDLY_TEAM_COLOR + "\'>";
         var _loc12_:String = "<font color=\'" + TeamColors.ENEMY_TEAM_COLOR + "\'>";
         var _loc13_:String = "</font>";
         switch(param1)
         {
            case STATE_YOUR_PICK_TURN:
               _loc7_ = _loc8_;
               _loc7_ = _loc7_ + RiotResourceLoader.getString("championSelection_messageCenter_ctr_yourTurn",null,[_loc10_,_loc12_,_loc13_]);
               _loc7_ = _loc7_ + _loc13_;
               break;
            case STATE_UPCOMING_TURN:
            case STATE_TURN_DONE:
               _loc7_ = _loc9_;
               if((this.isMyTeamActive(param2.teamOne)) || (this.isMyTeamActive(param2.teamTwo)))
               {
                  _loc7_ = _loc7_ + RiotResourceLoader.getString("championSelection_messageCenter_ctr_friendlyPick",null,[param6,_loc11_,_loc12_,_loc13_]);
               }
               else
               {
                  _loc7_ = _loc7_ + RiotResourceLoader.getString("championSelection_messageCenter_ctr_enemyPick",null,[param6,_loc12_,_loc11_,_loc13_]);
               }
               _loc7_ = _loc7_ + _loc13_;
               break;
            case STATE_POST_PICK:
               if((param5 > 0) && (!param3))
               {
                  _loc7_ = _loc8_;
                  _loc7_ = _loc7_ + RiotResourceLoader.getString("championSelection_messageCenter_ctr_trade",null,[_loc11_,_loc13_]);
                  _loc7_ = _loc7_ + _loc13_;
               }
               break;
         }
         return _loc7_;
      }
      
      private function isMyTeamActive(param1:ArrayCollection) : Boolean
      {
         var _loc4_:GameParticipant = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(_loc4_ in param1)
         {
            if(_loc4_.isMe)
            {
               _loc2_ = true;
            }
            if(_loc4_.pickMode == GameParticipant.PICK_MODE_ACTIVE)
            {
               _loc3_ = true;
            }
         }
         return (_loc2_) && (_loc3_);
      }
      
      override public function setPlayerSelectionState(param1:IChampionSelectionPlayerSelectionModel, param2:GameDTO, param3:GameParticipant, param4:Boolean) : void
      {
         var _loc5_:PlayerSelectionEmphasis = null;
         var _loc6_:String = null;
         if(param2.gameState != GameState.CHAMPION_SELECTION)
         {
            param1.emphasis = null;
            super.setPlayerSelectionState(param1,param2,param3,param4);
         }
         else
         {
            _loc5_ = this.getSelectionEmphasis(param2,param3);
            _loc6_ = this.getCounterPickState(param2,param3);
            if((this.isAnimatedArrowState(_loc6_)) && (!(_loc5_ == null)))
            {
               _loc5_.syncAnimationsOnly = param1.selectionState == _loc6_;
               param1.selectionState = PICK_STATE_DARK_GREY;
            }
            param1.emphasis = _loc5_;
            param1.selectionState = _loc6_;
         }
      }
      
      private function getSelectionEmphasis(param1:GameDTO, param2:GameParticipant) : PlayerSelectionEmphasis
      {
         var _loc3_:GameParticipant = this.getOpposingPlayer(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:PlayerSelectionEmphasis = new PlayerSelectionEmphasis();
         var _loc5_:Boolean = param2.pickMode == GameParticipant.PICK_MODE_ACTIVE;
         var _loc6_:Boolean = _loc3_.pickMode == GameParticipant.PICK_MODE_ACTIVE;
         if((_loc5_) || (_loc6_))
         {
            _loc4_.championHighlighted = ((param2.isMe) || (_loc3_.isMe)) && (_loc6_);
            if(_loc6_)
            {
               _loc4_.fadeDirection = param2.team == GameParticipant.FRIENDLY_TEAM?PlayerSelectionEmphasis.FADE_DIRECTION_LEFT:PlayerSelectionEmphasis.FADE_DIRECTION_RIGHT;
            }
         }
         return _loc4_;
      }
      
      private function isAnimatedArrowState(param1:String) : Boolean
      {
         switch(param1)
         {
            case PICK_STATE_ORANGE_ARROWS_RIGHT:
            case PICK_STATE_BLUE_ARROWS_LEFT:
               return true;
         }
      }
      
      private function getCounterPickState(param1:GameDTO, param2:GameParticipant) : String
      {
         var _loc6_:GameParticipant = null;
         var _loc7_:* = false;
         var _loc3_:int = param2.pickMode;
         var _loc4_:GameParticipant = this.getOpposingPlayer(param1,param2);
         var _loc5_:int = !(_loc4_ == null)?_loc4_.pickMode:GameParticipant.PICK_MODE_NOT_PICKING;
         if(param2.isMe)
         {
            if(_loc3_ == GameParticipant.PICK_MODE_ACTIVE)
            {
               return PICK_STATE_ORANGE_ARROWS_RIGHT;
            }
            if(_loc5_ == GameParticipant.PICK_MODE_ACTIVE)
            {
               return PICK_STATE_BLUE_ARROWS_LEFT;
            }
            return PICK_STATE_BLUE;
         }
         if((_loc5_ == GameParticipant.PICK_MODE_ACTIVE) && (_loc4_.isMe))
         {
            return PICK_STATE_ORANGE_ARROWS_RIGHT;
         }
         if((_loc3_ == GameParticipant.PICK_MODE_ACTIVE) && (_loc4_.isMe))
         {
            return PICK_STATE_BLUE_ARROWS_LEFT;
         }
         if((_loc3_ == GameParticipant.PICK_MODE_ACTIVE) || (_loc5_ == GameParticipant.PICK_MODE_ACTIVE))
         {
            _loc6_ = _loc3_ == GameParticipant.PICK_MODE_ACTIVE?param2:_loc4_;
            _loc7_ = _loc6_.team == GameParticipant.FRIENDLY_TEAM;
            return _loc7_?PICK_STATE_LIGHT_GREY_ARROWS_RIGHT:PICK_STATE_LIGHT_GREY_ARROWS_LEFT;
         }
         return PICK_STATE_DARK_GREY;
      }
      
      override public function getPickedChampionId(param1:GameDTO, param2:GameParticipant) : int
      {
         var _loc3_:GameParticipant = this.getOpposingPlayer(param1,param2);
         if(_loc3_ == null)
         {
            return 0;
         }
         return super.getPickedChampionId(param1,_loc3_);
      }
      
      private function getOpposingPlayer(param1:GameDTO, param2:GameParticipant) : GameParticipant
      {
         var _loc8_:GameParticipant = null;
         var _loc3_:Boolean = param1.isPlayerOnTeamOne(param2.summonerName);
         var _loc4_:ArrayCollection = _loc3_?param1.teamOne:param1.teamTwo;
         var _loc5_:ArrayCollection = _loc3_?param1.teamTwo:param1.teamOne;
         var _loc6_:int = -1;
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc8_ = _loc4_.getItemAt(_loc7_) as GameParticipant;
            if(_loc8_.summonerName == param2.summonerName)
            {
               _loc6_ = _loc7_;
            }
            _loc7_++;
         }
         if((_loc6_ >= 0) && (_loc5_.length > _loc6_))
         {
            return _loc5_.getItemAt(_loc6_) as GameParticipant;
         }
         return null;
      }
      
      override public function allowSkinSelection(param1:String) : Boolean
      {
         return param1 == GameState.POST_CHAMPION_SELECTION;
      }
      
      override public function getPickSoundTarget(param1:GameDTO, param2:GameParticipant) : GameParticipant
      {
         return this.getOpposingPlayer(param1,param2);
      }
      
      override public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = super.createPracticeGameParameters();
         _loc1_.overriddenGamePickIds = new ArrayCollection([GameTypeConfig.PICK_ID_CTR_DRAFT]);
         _loc1_.overriddenMapIds = new ArrayCollection([GameMap.SUMMONERS_RIFT_UPDATE_SHIPPING,GameMap.SUMMONERS_RIFT_ID,GameMap.CRYSTAL_SCAR_ID,GameMap.HOWLING_ABYSS,GameMap.TWISTED_TREELINE_ID]);
         return _loc1_;
      }
   }
}
