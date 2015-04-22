package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.util.string.RiotStringUtil;
   import com.riotgames.pvpnet.system.game.MutatorsConfiguration;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.Models.IChampionSelectionPlayerSelectionModel;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.gameclient.domain.PlayerParticipant;
   import com.riotgames.platform.gameclient.championselection.enum.ChampionSelectState;
   import com.riotgames.platform.gameclient.domain.PlayerChampionSelectionDTO;
   import com.riotgames.platform.gameclient.domain.game.GameMutator;
   import mx.resources.ResourceManager;
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.Champion;
   
   class FeaturedGameFlowVariant extends BaseGameFlowVariant implements GameFlowVariant
   {
      
      var _gameKey:String;
      
      var _identifyingGameMode:String;
      
      var _identifyingGameMutator:String;
      
      var _customGameBotsEnabled:Boolean = false;
      
      function FeaturedGameFlowVariant()
      {
         super();
      }
      
      function initializeKey(param1:String, param2:String, param3:String) : void
      {
         this._gameKey = param1;
         _key = !(param2 == null)?param2:param3;
         this._identifyingGameMode = param2;
         this._identifyingGameMutator = param3;
      }
      
      public function isEnabled() : Boolean
      {
         var _loc1_:Boolean = false;
         if(!RiotStringUtil.isEmpty(this._identifyingGameMutator))
         {
            _loc1_ = MutatorsConfiguration.isConfigurationEnabled(MutatorsConfiguration.ENABLED_MUTATORS,this._identifyingGameMutator);
         }
         else if(!RiotStringUtil.isEmpty(this._identifyingGameMode))
         {
            _loc1_ = MutatorsConfiguration.isConfigurationEnabled(MutatorsConfiguration.ENABLED_MODES,this._identifyingGameMode);
         }
         
         return _loc1_;
      }
      
      public function showsAssociatedSpellsInProfile() : Boolean
      {
         return false;
      }
      
      public function getGameFlowName() : String
      {
         return RiotResourceLoader.getString(this._gameKey + "_game_mode_name");
      }
      
      public function getGameFlowColor() : uint
      {
         return FeaturedGameFlowConstants.COLOR_FEATURED_TEXT;
      }
      
      public function getGameFlowOptionsColor(param1:Boolean) : uint
      {
         if(!param1)
         {
            return FeaturedGameFlowConstants.COLOR_FEATURED_TEXT;
         }
         return 14540253;
      }
      
      public function showsGameFlowOptionsStar() : Boolean
      {
         return true;
      }
      
      public function getGameFlowQueueTitleIcon() : String
      {
         return null;
      }
      
      public function canAddBotsToCustomGame() : Boolean
      {
         return this._customGameBotsEnabled;
      }
      
      public function getGameModeForMap(param1:int) : String
      {
         if(this._identifyingGameMode != null)
         {
            return this._identifyingGameMode;
         }
         return StandardGameFlowVariant.getDefaultGameModeForMap(param1);
      }
      
      public function getJoinGameLobbyTitle() : String
      {
         return RiotResourceLoader.getString("practiceGame_createOrJoinGame_lobbyTitleFeatured",null,[this.getGameFlowName()]);
      }
      
      public function showsJoinGameLobbyItem(param1:GameFlowVariant) : Boolean
      {
         return _key == BaseGameFlowVariant(param1).key;
      }
      
      public function validateStartCustomGame(param1:GameDTO) : String
      {
         return null;
      }
      
      public function getChampionOverlayPosition() : Point
      {
         return new Point(1000,117);
      }
      
      public function getMatchDetailsMessage(param1:String) : String
      {
         return null;
      }
      
      public function getCustomLockInButtonLabel() : String
      {
         return null;
      }
      
      public function getCustomChampionSelectionNewbieTip(param1:String, param2:String) : String
      {
         return null;
      }
      
      public function getCustomChampionSelectionStateDescription(param1:String, param2:GameDTO, param3:Boolean, param4:Boolean, param5:int, param6:String) : String
      {
         return null;
      }
      
      public function setPlayerSelectionState(param1:IChampionSelectionPlayerSelectionModel, param2:GameDTO, param3:GameParticipant, param4:Boolean) : void
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = param3 is PlayerParticipant?param3.isMe:false;
         if((param3.pickMode == GameParticipant.PICK_MODE_ACTIVE) && (!param4))
         {
            _loc5_ = _loc6_?ChampionSelectState.CHAMPION_SELECT_STATE_ACTIVESELF:ChampionSelectState.CHAMPION_SELECT_STATE_ACTIVEOTHER;
         }
         else
         {
            _loc5_ = _loc6_?ChampionSelectState.CHAMPION_SELECT_STATE_INACTIVESELF:ChampionSelectState.CHAMPION_SELECT_STATE_INACTIVEOTHER;
         }
         if(param1.selectionState != _loc5_)
         {
            param1.selectionState = _loc5_;
         }
      }
      
      public function getPickedChampionId(param1:GameDTO, param2:GameParticipant) : int
      {
         var _loc3_:PlayerChampionSelectionDTO = null;
         if(param1 != null)
         {
            for each(_loc3_ in param1.playerChampionSelections)
            {
               if(_loc3_.summonerInternalName == param2.summonerInternalName)
               {
                  return _loc3_.championId;
               }
            }
         }
         return 0;
      }
      
      public function allowSkinSelection(param1:String) : Boolean
      {
         return true;
      }
      
      public function getPickSoundTarget(param1:GameDTO, param2:GameParticipant) : GameParticipant
      {
         return param2;
      }
      
      public function supportsBattleBoost() : Boolean
      {
         return GameMutator.hasMutator(this._gameMutators,GameMutator.BATTLE_BOOST);
      }
      
      public function getGameResultOverrideText(param1:String, param2:String) : String
      {
         var _loc3_:String = ResourceManager.getInstance().getString(param1,param2 + "_" + _key);
         if(!RiotStringUtil.isEmpty(_loc3_))
         {
            return _loc3_;
         }
         return ResourceManager.getInstance().getString(param1,param2);
      }
      
      public function showsEndOfGameLevelUpAlertForUnlockedGameMode() : Boolean
      {
         return false;
      }
      
      public function getEndOfGameProfileIcon(param1:PlayerParticipantStatsSummary) : int
      {
         return param1.profileIconId;
      }
      
      public function getEndOfGameCoOpVsAiText(param1:String) : String
      {
         return RiotResourceLoader.getString("practiceGame_gameMode_COOP_VS_AI_GAME") + " (" + RiotResourceLoader.getString("game_flow_mm_pve_difficulty_" + param1.toLowerCase() + "_title") + ")";
      }
      
      public function getEndOfGameCoOpVsAiIcon(param1:String) : String
      {
         return null;
      }
      
      public function showPointsInfo() : Boolean
      {
         return false;
      }
      
      public function useClassicKDATooltip() : Boolean
      {
         return true;
      }
      
      public function getNexusFinalHealthTooltip() : String
      {
         return "";
      }
      
      public function showStatCategory(param1:String) : Boolean
      {
         return true;
      }
      
      public function getGameStatsType(param1:int) : String
      {
         if(GameMap.HOWLING_ABYSS == param1)
         {
            return GameStatsType.ARAM;
         }
         if(GameMap.CRYSTAL_SCAR_ID == param1)
         {
            return GameStatsType.DOMINION;
         }
         return GameStatsType.CLASSIC;
      }
      
      public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = new PracticeGameParameters(this._gameKey,this);
         _loc1_.overriddenGamePickIds = new ArrayCollection([GameTypeConfig.PICK_ID_BLIND_PICK]);
         _loc1_.overriddenGameTitle = RiotResourceLoader.getString("custom_" + this._gameKey + "_game_mode_title");
         _loc1_.overriddenGameDescription = RiotResourceLoader.getString("custom_" + this._gameKey + "_game_mode_description");
         if(this._identifyingGameMode != null)
         {
            _loc1_.gameMode = this._identifyingGameMode;
         }
         else if(this._identifyingGameMutator != null)
         {
            _loc1_.gameMutators = [this._identifyingGameMutator];
         }
         
         return _loc1_;
      }
      
      public function temporarySummonChampionLogic(param1:GameDTO, param2:GameParticipant, param3:Champion, param4:ArrayCollection, param5:ArrayCollection) : void
      {
      }
   }
}
