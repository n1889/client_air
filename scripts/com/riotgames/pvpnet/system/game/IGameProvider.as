package com.riotgames.pvpnet.system.game
{
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.gameclient.Models.GameModel;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.controllers.IGamePreloadController;
   
   public interface IGameProvider
   {
      
      function get currentGame() : GameDTO;
      
      function get gameModel() : GameModel;
      
      function set gameModel(param1:GameModel) : void;
      
      function get gameModelChanged() : ISignal;
      
      function set currentState(param1:String) : void;
      
      function get currentState() : String;
      
      function joinPracticeGame(param1:GameDTO) : void;
      
      function getMatchmakingState() : String;
      
      function joinQueueWithMapName(param1:int, param2:Boolean, param3:String, param4:String) : void;
      
      function cancelMatchmaking() : void;
      
      function getGameStateChanged() : ISignal;
      
      function getCurrentGameChanged() : ISignal;
      
      function getPreloadController() : IGamePreloadController;
      
      function cancelGameFlow() : void;
      
      function setPlayingDisconnected() : void;
      
      function getCurrentGameFlowVariant() : GameFlowVariant;
   }
}
