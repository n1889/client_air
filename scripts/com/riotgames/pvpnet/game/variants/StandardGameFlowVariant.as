package com.riotgames.pvpnet.game.variants
{
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.platform.gameclient.domain.game.GameMode;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
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
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import com.riotgames.pvpnet.game.controllers.practice.PracticeGameParametersFactory;
   import com.riotgames.platform.gameclient.domain.Champion;
   import mx.collections.ArrayCollection;
   
   class StandardGameFlowVariant extends BaseGameFlowVariant implements GameFlowVariant
   {
      
      function StandardGameFlowVariant()
      {
         super();
      }
      
      static function getDefaultGameModeForMap(param1:int) : String
      {
         var _loc2_:String = GameMode.CLASSIC;
         switch(param1)
         {
            case GameMap.CRYSTAL_SCAR_ID:
               _loc2_ = GameMode.DOMINION;
               break;
            case GameMap.PROVING_GROUNDS_ARAM_ID:
            case GameMap.HOWLING_ABYSS_WIP:
            case GameMap.HOWLING_ABYSS:
               _loc2_ = GameMode.ARAM;
               break;
         }
         return _loc2_;
      }
      
      function initializeKey(param1:String) : void
      {
         this._key = param1;
      }
      
      public function isEnabled() : Boolean
      {
         return MutatorsConfiguration.isConfigurationEnabled(MutatorsConfiguration.ENABLED_MODES,GameMode.CLASSIC);
      }
      
      public function showsAssociatedSpellsInProfile() : Boolean
      {
         return true;
      }
      
      public function getGameFlowName() : String
      {
         if(this._gameMode != null)
         {
            return RiotResourceLoader.getString(this._gameMode.toLowerCase() + "_game_mode_name");
         }
         return "";
      }
      
      public function getGameFlowColor() : uint
      {
         return 16777215;
      }
      
      public function getGameFlowOptionsColor(param1:Boolean) : uint
      {
         return 14540253;
      }
      
      public function showsGameFlowOptionsStar() : Boolean
      {
         return false;
      }
      
      public function getGameFlowQueueTitleIcon() : String
      {
         return null;
      }
      
      public function canAddBotsToCustomGame() : Boolean
      {
         return true;
      }
      
      public function getGameModeForMap(param1:int) : String
      {
         return getDefaultGameModeForMap(param1);
      }
      
      public function getJoinGameLobbyTitle() : String
      {
         return RiotResourceLoader.getString("practiceGame_createOrJoinGame_lobbyTitleNormal");
      }
      
      public function showsJoinGameLobbyItem(param1:GameFlowVariant) : Boolean
      {
         return !(param1 is FeaturedGameFlowVariant);
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
         return ResourceManager.getInstance().getString(param1,param2);
      }
      
      public function showsEndOfGameLevelUpAlertForUnlockedGameMode() : Boolean
      {
         return true;
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
         return GameStatsType.CLASSIC;
      }
      
      public function createPracticeGameParameters() : PracticeGameParameters
      {
         var _loc1_:PracticeGameParameters = new PracticeGameParameters(PracticeGameParametersFactory.CUSTOM_MODE_ID,this);
         _loc1_.filterFeaturedGamePickModes = true;
         return _loc1_;
      }
      
      public function temporarySummonChampionLogic(param1:GameDTO, param2:GameParticipant, param3:Champion, param4:ArrayCollection, param5:ArrayCollection) : void
      {
      }
   }
}
