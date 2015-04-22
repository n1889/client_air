package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import blix.IDestructible;
   import com.riotgames.platform.gameclient.controllers.game.model.ParticipantChampionListView;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import mx.logging.ILogger;
   import blix.action.IAction;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import com.riotgames.platform.common.provider.ISoundProvider;
   import com.riotgames.platform.gameclient.services.GameService;
   import com.riotgames.platform.common.error.ServerError;
   import mx.resources.ResourceManager;
   import mx.resources.IResourceManager;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import com.riotgames.platform.gameclient.domain.Champion;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.gameclient.domain.game.ParticipantChampionSelection;
   import com.riotgames.platform.gameclient.championselection.enum.ChampionSelectState;
   import com.riotgames.pvpnet.system.game.GameProviderProxy;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.domain.game.GameType;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SummonChampionController extends Object implements IDestructible
   {
      
      private var participantChampionSelections:ParticipantChampionListView;
      
      private var championSelectionModel:ChampionSelectionModel;
      
      private var logger:ILogger;
      
      private var lastSound:IAction;
      
      private var targetPlayerSelection:PlayerSelection;
      
      private var soundManager:ISoundProvider;
      
      private var gameService:GameService;
      
      private var pendingChamp:Champion = null;
      
      public function SummonChampionController(param1:ChampionSelectionModel, param2:ParticipantChampionListView, param3:GameService, param4:ISoundProvider)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this.participantChampionSelections = param2;
         this.championSelectionModel = param1;
         this.soundManager = param4;
         this.gameService = param3;
      }
      
      public function destroy() : void
      {
         this.reset();
      }
      
      private function reset() : void
      {
         this.championSelectionModel.championSelectionIsBusy = false;
         this.pendingChamp = null;
         if(this.targetPlayerSelection != null)
         {
            this.targetPlayerSelection.championChanged.remove(this.onChampionChanged);
            this.targetPlayerSelection = null;
         }
      }
      
      private function onChampionSelectError(param1:ServerError) : void
      {
         this.reset();
         if(param1.errorCode == "PG-0014")
         {
            return;
         }
         var _loc2_:IResourceManager = ResourceManager.getInstance();
         var _loc3_:String = _loc2_.getString("resources",param1.errorCode,param1.messageArguments);
         var _loc4_:AlertAction = new AlertAction(_loc2_.getString("resources","championSelection_selectChampionErrorTitle"),_loc3_);
         _loc4_.add();
         this.logger.warn("0006 SummonController.onChampionSelectError: " + _loc3_);
      }
      
      public function summonChampion(param1:Champion) : void
      {
         var _loc4_:GameFlowVariant = null;
         var _loc5_:GameParticipant = null;
         this.reset();
         if((param1 == null) || (param1.isRandomChampion()))
         {
            var param1:Champion = this.participantChampionSelections.findRandomUnselectedChampion();
            if(param1 == null)
            {
               return;
            }
         }
         var _loc2_:ParticipantChampionSelection = this.participantChampionSelections.getSelectionByChampion(param1);
         var _loc3_:Boolean = (_loc2_.participant == null) || (ChampionSelectState.tutorialPickOverride) || (!(this.championSelectionModel.gameTypeConfig == null)) && (this.championSelectionModel.gameTypeConfig.duplicatePick);
         if(_loc3_)
         {
            this.pendingChamp = param1;
            _loc4_ = GameProviderProxy.instance.getCurrentGameFlowVariant();
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.getPickSoundTarget(this.championSelectionModel.currentGame,this.championSelectionModel.currentPlayerParticipant);
               this.targetPlayerSelection = this.getPlayerSelectionForParticipant(_loc5_);
               if(this.targetPlayerSelection != null)
               {
                  this.targetPlayerSelection.championChanged.add(this.onChampionChanged);
               }
            }
            this.championSelectionModel.championSelectionIsBusy = true;
            this.gameService.selectChampion(param1,null,this.onServiceRequestComplete,this.onChampionSelectError);
         }
         else
         {
            this.logger.error("0003 player attempting to summon a champion that already has a participant.");
         }
      }
      
      private function onChampionChanged(param1:ISignal, param2:Champion) : void
      {
         var _loc3_:Boolean = (this.pendingChamp) && (param2) && (this.pendingChamp.skinName == param2.skinName);
         if(_loc3_)
         {
            if(this.championSelectionModel.currentGame.gameType != GameType.TUTORIAL_GAME)
            {
               if(this.lastSound != null)
               {
                  if(!this.lastSound.getIsFinished())
                  {
                     this.lastSound.abort();
                  }
                  this.lastSound = null;
               }
               this.lastSound = this.soundManager.playSummonChampionBySkinname(param2.skinName);
            }
         }
         else
         {
            this.logger.warn("0004 ChampionSelectionController.onSummonChampionSuccess: Player Was Unable To Summon His Selected Champion.");
         }
         this.reset();
      }
      
      private function onServiceRequestComplete(param1:Object) : void
      {
         this.championSelectionModel.championSelectionIsBusy = false;
      }
      
      private function getPlayerSelectionForParticipant(param1:GameParticipant) : PlayerSelection
      {
         var _loc2_:PlayerSelection = null;
         var _loc3_:PlayerSelection = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1 == this.championSelectionModel.currentPlayerParticipant)
         {
            return this.championSelectionModel.currentPlayerSelection;
         }
         for each(_loc2_ in this.championSelectionModel.currentTeamSelections)
         {
            if(param1.summonerInternalName == _loc2_.participant.summonerInternalName)
            {
               return _loc2_;
            }
         }
         for each(_loc3_ in this.championSelectionModel.enemyTeamSelections)
         {
            if(param1.summonerInternalName == _loc3_.participant.summonerInternalName)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}
