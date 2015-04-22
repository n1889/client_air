package com.riotgames.pvpnet.game.controllers.lobby
{
   public class MatchMakingState extends Object
   {
      
      public static const MATCHMAKING_NOT_PARTICIPATING:String = "matchmakingNotQueued";
      
      public static const MATCHMAKING_QUEUED:String = "matchmakingQueued";
      
      public static const MATCHMAKING_MATCHED:String = "matchmakingMatched";
      
      public static const MATCHMAKING_CREATE_TEAM:String = "matchmakingCreateTeam";
      
      public static const MATCHMAKING_CUSTOM_GAME_LOBBY:String = "matchmakingCustomGameLobby";
      
      public static const MATCHMAKING_SPECTATING_CHAMP_SELECT:String = "spectatingChampSelect";
      
      public static const MATCHMAKING_CAP:String = "matchmakingCap";
      
      public static const MATCHMAKING_TBD_CAPTAIN:String = "matchmakingTBDCaptain";
      
      public static const MATCHMAKING_TBD_INVITEE:String = "matchmakingTBDInvitee";
      
      public function MatchMakingState()
      {
         super();
      }
   }
}
