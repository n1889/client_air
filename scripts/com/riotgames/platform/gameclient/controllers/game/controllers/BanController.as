package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import flash.events.EventDispatcher;
   import com.riotgames.platform.gameclient.controllers.game.builders.IChampionSelectionCommandFactory;
   import com.riotgames.platform.gameclient.chat.controllers.ChatRoom;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.common.commands.ICommand;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import flash.events.Event;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.domain.Champion;
   
   public class BanController extends EventDispatcher
   {
      
      private var championSelectionCommandFactory:IChampionSelectionCommandFactory;
      
      private var confirmedBans:Array;
      
      private var _chatRoom:ChatRoom;
      
      private var championSelectionModel:ChampionSelectionModel;
      
      public function BanController(param1:ChampionSelectionModel, param2:ChatRoom, param3:IChampionSelectionCommandFactory)
      {
         this.confirmedBans = new Array();
         super();
         this.chatRoom = param2;
         this.championSelectionModel = param1;
         this.championSelectionCommandFactory = param3;
      }
      
      private function onBansResult(param1:Array) : void
      {
         this.confirmedBans = param1;
      }
      
      public function set chatRoom(param1:ChatRoom) : void
      {
         if(this._chatRoom == param1)
         {
            return;
         }
         this._chatRoom = param1;
      }
      
      private function onGetBannableChampionsSuccess(param1:ArrayCollection) : void
      {
         this.findBanTeam();
      }
      
      public function get chatRoom() : ChatRoom
      {
         return this._chatRoom;
      }
      
      public function stop() : void
      {
         this.removeListeners();
      }
      
      private function printNewConfirmedBans(param1:ArrayCollection, param2:Array) : void
      {
         var _loc3_:ICommand = this.championSelectionCommandFactory.getPrintBansCommand(this.chatRoom,this.championSelectionModel.championSelections,param1,param2);
         _loc3_.addResponder(this.onBansResult);
         _loc3_.execute();
      }
      
      public function start() : void
      {
         this.addListeners();
         this.getChampionsForBan();
      }
      
      private function findBanTeam() : void
      {
         var _loc1_:ICommand = this.championSelectionCommandFactory.getSetVisibleChampionsCommand(this.championSelectionModel,this.championSelectionModel.championSelectionState,this.championSelectionModel.isSpectating,false,false);
         _loc1_.execute();
      }
      
      private function onBanSucccess(param1:ResultEvent) : void
      {
         this.updateBannedChampionStates();
      }
      
      protected function onPickTurnChanged(param1:Event) : void
      {
         if(!this.championSelectionModel.isSpectating)
         {
            this.printNewConfirmedBans(this.championSelectionModel.currentGame.bannedChampions,this.confirmedBans);
         }
         if(this.championSelectionModel.championSelectionState != GameState.PRE_CHAMPION_SELECTION)
         {
            return;
         }
         this.updateBannedChampionStates();
         this.findBanTeam();
      }
      
      public function banChampion(param1:Champion) : void
      {
         var _loc2_:ICommand = this.championSelectionCommandFactory.getBanCommand(param1);
         _loc2_.addResponder(this.onBanSucccess);
         _loc2_.execute();
      }
      
      public function updateBannedChampionStates() : void
      {
         var _loc1_:ICommand = this.championSelectionCommandFactory.getUpdateBansCommand(this.championSelectionModel.currentGame,this.championSelectionModel.teamOneBans,this.championSelectionModel.teamTwoBans,this.championSelectionModel,this.championSelectionModel.isSpectating);
         _loc1_.execute();
      }
      
      private function getChampionsForBan() : void
      {
         var _loc1_:ICommand = null;
         if((this.championSelectionModel) && (!this.championSelectionModel.isSpectating))
         {
            _loc1_ = this.championSelectionCommandFactory.getInitializeBannableChampionsCommand(this.championSelectionModel);
            _loc1_.addResponder(this.onGetBannableChampionsSuccess);
            _loc1_.execute();
         }
      }
      
      protected function removeListeners() : void
      {
         this.championSelectionModel.removeEventListener(ChampionSelectionModel.PICK_TURN_CHANGED,this.onPickTurnChanged);
      }
      
      protected function addListeners() : void
      {
         this.championSelectionModel.addEventListener(ChampionSelectionModel.PICK_TURN_CHANGED,this.onPickTurnChanged,false,0,true);
      }
   }
}
