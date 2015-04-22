package com.riotgames.platform.gameclient.championselection.enum
{
   public class ChampionSelectState extends Object
   {
      
      public static const CHAMPION_SELECT_STATE_INACTIVESELF:String = "stateBlue";
      
      public static const CHAMPION_SELECT_STATE_INACTIVEOTHER:String = "stateDarkGrey";
      
      public static var tutorialPickOverride:Boolean = false;
      
      public static const CHAMPION_SELECT_STATE_ACTIVESELF:String = "stateOrangeArrowsRight";
      
      public static const CHAMPION_SELECT_STATE_ACTIVEOTHER:String = "stateLightGrey";
      
      public function ChampionSelectState()
      {
         super();
         throw new Error("This is a static enum class.");
      }
   }
}
