package com.riotgames.pvpnet.game
{
   import blix.action.BasicAction;
   import com.riotgames.pvpnet.game.controllers.MasterGameController;
   import com.riotgames.platform.gameclient.services.GameService;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.common.error.ServerError;
   import mx.resources.ResourceManager;
   import mx.resources.IResourceManager;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class QuitPracticeGameAction extends BasicAction
   {
      
      private var _masterGameController:MasterGameController;
      
      private var _gameService:GameService;
      
      private var _logger:ILogger;
      
      public function QuitPracticeGameAction(param1:MasterGameController, param2:GameService)
      {
         this._logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super(false);
         this._masterGameController = param1;
         this._gameService = param2;
      }
      
      override protected function doInvocation() : void
      {
         this.quitGame();
      }
      
      private function quitGame() : void
      {
         var _loc1_:GameDTO = this._masterGameController.currentGame;
         if(!_loc1_)
         {
            complete();
            return;
         }
         this._gameService.quitGame(this.onQuitGameSuccess,null,this.onServiceRequestError);
      }
      
      private function onQuitGameSuccess(param1:ResultEvent) : void
      {
         this._masterGameController.gameMap = null;
         this._masterGameController.inviteController.setPlayerQuittingGame(true);
         this._masterGameController.cleanupAfterGameCompleteOrAborted();
         this._masterGameController.inviteController.setPlayerQuittingGame(false);
         this._masterGameController.startPracticeGameFlowAtJoinGame();
         complete();
      }
      
      private function onServiceRequestError(param1:ServerError) : void
      {
         var _loc2_:IResourceManager = ResourceManager.getInstance();
         var _loc3_:AlertAction = new AlertAction(_loc2_.getString("resources","practiceGame_new_quitGameErrorTitle"),_loc2_.getString("resources",param1.errorCode,param1.messageArguments));
         _loc3_.add();
         if(param1.faultEvent)
         {
            err(param1.faultEvent.fault);
         }
         else
         {
            err(new Error(param1.exception));
         }
      }
   }
}
