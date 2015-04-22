package com.riotgames.pvpnet.system.game
{
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import flash.geom.Point;
   import com.riotgames.platform.gameclient.Models.IChampionSelectionPlayerSelectionModel;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   
   public interface GameFlowVariant
   {
      
      function isEnabled() : Boolean;
      
      function showsAssociatedSpellsInProfile() : Boolean;
      
      function getGameFlowName() : String;
      
      function getGameFlowColor() : uint;
      
      function getGameFlowOptionsColor(param1:Boolean) : uint;
      
      function showsGameFlowOptionsStar() : Boolean;
      
      function getGameFlowQueueTitleIcon() : String;
      
      function canAddBotsToCustomGame() : Boolean;
      
      function createPracticeGameParameters() : PracticeGameParameters;
      
      function getGameModeForMap(param1:int) : String;
      
      function getJoinGameLobbyTitle() : String;
      
      function showsJoinGameLobbyItem(param1:GameFlowVariant) : Boolean;
      
      function validateStartCustomGame(param1:GameDTO) : String;
      
      function getChampionOverlayPosition() : Point;
      
      function getMatchDetailsMessage(param1:String) : String;
      
      function getCustomLockInButtonLabel() : String;
      
      function getCustomChampionSelectionNewbieTip(param1:String, param2:String) : String;
      
      function getCustomChampionSelectionStateDescription(param1:String, param2:GameDTO, param3:Boolean, param4:Boolean, param5:int, param6:String) : String;
      
      function setPlayerSelectionState(param1:IChampionSelectionPlayerSelectionModel, param2:GameDTO, param3:GameParticipant, param4:Boolean) : void;
      
      function getPickedChampionId(param1:GameDTO, param2:GameParticipant) : int;
      
      function allowSkinSelection(param1:String) : Boolean;
      
      function getPickSoundTarget(param1:GameDTO, param2:GameParticipant) : GameParticipant;
      
      function supportsBattleBoost() : Boolean;
      
      function getGameResultOverrideText(param1:String, param2:String) : String;
      
      function getEndOfGameProfileIcon(param1:PlayerParticipantStatsSummary) : int;
      
      function showsEndOfGameLevelUpAlertForUnlockedGameMode() : Boolean;
      
      function getEndOfGameCoOpVsAiText(param1:String) : String;
      
      function getEndOfGameCoOpVsAiIcon(param1:String) : String;
      
      function showPointsInfo() : Boolean;
      
      function useClassicKDATooltip() : Boolean;
      
      function getNexusFinalHealthTooltip() : String;
      
      function showStatCategory(param1:String) : Boolean;
      
      function getGameStatsType(param1:int) : String;
   }
}
