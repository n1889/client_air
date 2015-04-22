package com.riotgames.pvpnet.system.game
{
   import com.riotgames.platform.provider.proxy.ProviderProxyBase;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.gameclient.Models.GameModel;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.controllers.IGamePreloadController;
   
   public class GameProviderProxy extends ProviderProxyBase implements IGameProvider
   {
      
      private static var _instance:IGameProvider;
      
      public function GameProviderProxy()
      {
         super(IGameProvider);
      }
      
      static function setInstance(param1:IGameProvider) : void
      {
         _instance = param1;
      }
      
      public static function get instance() : IGameProvider
      {
         if(_instance == null)
         {
            _instance = new GameProviderProxy();
         }
         return _instance;
      }
      
      public function get currentGame() : GameDTO
      {
         return _invokeGetter("currentGame");
      }
      
      public function get gameModel() : GameModel
      {
         return _invokeGetter("currentGame");
      }
      
      public function set gameModel(param1:GameModel) : void
      {
         _invokeSetter("gameModel",param1);
      }
      
      public function get gameModelChanged() : ISignal
      {
         return _invokeGetter("gameModelChanged");
      }
      
      public function set currentState(param1:String) : void
      {
         _invokeSetter("currentState",param1);
      }
      
      public function get currentState() : String
      {
         return _invokeGetter("currentState");
      }
      
      public function joinPracticeGame(param1:GameDTO) : void
      {
         _invoke("joinPracticeGame",[param1]);
      }
      
      public function getMatchmakingState() : String
      {
         return _invoke("getMatchmakingState");
      }
      
      public function joinQueueWithMapName(param1:int, param2:Boolean, param3:String, param4:String) : void
      {
         _invoke("joinQueueWithMapName",[param1,param2,param3,param4]);
      }
      
      public function cancelMatchmaking() : void
      {
         _invoke("cancelMatchmaking");
      }
      
      public function getGameStateChanged() : ISignal
      {
         return _invoke("getGameStateChanged");
      }
      
      public function getCurrentGameChanged() : ISignal
      {
         return _invoke("getCurrentGameChanged");
      }
      
      public function getPreloadController() : IGamePreloadController
      {
         return _invoke("getPreloadController");
      }
      
      public function cancelGameFlow() : void
      {
         _invoke("cancelGameFlow");
      }
      
      public function setPlayingDisconnected() : void
      {
         _invoke("setPlayingDisconnected");
      }
      
      public function getCurrentGameFlowVariant() : GameFlowVariant
      {
         return _invoke("getCurrentGameFlowVariant");
      }
   }
}
