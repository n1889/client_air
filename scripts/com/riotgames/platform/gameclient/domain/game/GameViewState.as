package com.riotgames.platform.gameclient.domain.game
{
   public class GameViewState extends Object
   {
      
      public static const GAME_OVER:String = "GAME_OVER";
      
      public static const PLAYING_GAME:String = "PLAYING_GAME";
      
      public static const IN_PROGRESS:String = "IN_PROGRESS";
      
      public static const TBD_CAPTAIN_STATE:String = "TBD_CAPTAIN_STATE";
      
      public static const TEAM_SELECTION:String = "TEAM_SELECT";
      
      public static const WAIT_FOR_GAME:String = "NORMAL_WAIT_FOR_GAME";
      
      public static const CREATE_GAME:String = "CREATE_GAME";
      
      public static const CHAMPION_SELECTION:String = "CHAMP_SELECT";
      
      public static const START_REQUESTED:String = "START_REQUESTED";
      
      public static const WAIT_FOR_JOINING_GAME:String = "WAIT_FOR_JOINING_GAME";
      
      public static const JOIN_QUEUE:String = "NORMAL_JOIN_QUEUE";
      
      public static const CAP_STATE:String = "CAP_STATE";
      
      public static const TBD_INVITEE_STATE:String = "TBD_INVITEE_STATE";
      
      public static const JOIN_GAME:String = "JOIN_GAME";
      
      public static const NO_GAME:String = "";
      
      public static const TUTORIAL_GAME:String = "TUTORIAL_GAME";
      
      public static const WAIT_FOR_GAME_AFTER_MATCH:String = "NORMAL_WAIT_FOR_GAME_AFTER_MATCH";
      
      public function GameViewState()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
   }
}
