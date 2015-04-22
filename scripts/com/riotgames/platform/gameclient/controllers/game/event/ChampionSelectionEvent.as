package com.riotgames.platform.gameclient.controllers.game.event
{
   import flash.events.Event;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   
   public class ChampionSelectionEvent extends Event
   {
      
      public static const TRADE_ACCEPTED:String = "tradeAccepted";
      
      public static const CHAMPION_LIST_SELECTED:String = "championListSelected";
      
      public static const TRADE_REQUESTED:String = "tradeRequested";
      
      public static const LOCK_IN_CHOICES:String = "lockInChoices";
      
      public static const SKINS_SELECTED:String = "skinsSelected";
      
      public static const VIEW_PARTICIPANT_CHAMPION:String = "viewParticipantChampion";
      
      public static const CHAMPION_SELECTED:String = "championSelected";
      
      public static const TRADE_CANCELED:String = "tradeCanceled";
      
      public static const TRADE_REFUSED:String = "tradeRefused";
      
      public static const VIEW_PROFILE:String = "viewProfile";
      
      public static const QUIT_GAME:String = "quitGame";
      
      public static const HARD_RANDOMED:String = "hardRandomed";
      
      public static const REROLL_REQUESTED:String = "rerollRequested";
      
      private var _playerSelection:PlayerSelection;
      
      public function ChampionSelectionEvent(param1:String, param2:PlayerSelection = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._playerSelection = param2;
      }
      
      override public function clone() : Event
      {
         return new ChampionSelectionEvent(type,this.participantChampionSelection,bubbles,cancelable);
      }
      
      public function get participantChampionSelection() : PlayerSelection
      {
         return this._playerSelection;
      }
   }
}
