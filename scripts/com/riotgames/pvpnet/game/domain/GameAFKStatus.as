package com.riotgames.pvpnet.game.domain
{
   public class GameAFKStatus extends Object
   {
      
      public var acceptedPoppedGame:Boolean = false;
      
      public var respondedToPoppedGame:Boolean = false;
      
      public var gameTerminatedFromAFK:Boolean = false;
      
      public var waitingToRejoinTeamLobbyFromAFKReinvite:Boolean = false;
      
      public var afkReinviteID:int = -1;
      
      public var initialTimerValue:int = 10;
      
      public function GameAFKStatus()
      {
         super();
      }
   }
}
