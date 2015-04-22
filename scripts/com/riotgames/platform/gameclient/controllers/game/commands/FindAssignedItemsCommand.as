package com.riotgames.platform.gameclient.controllers.game.commands
{
   import com.riotgames.platform.common.commands.CommandBase;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import com.riotgames.platform.gameclient.domain.game.ParticipantChampionSelection;
   import com.riotgames.platform.gameclient.domain.Champion;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.gameclient.domain.PlayerChampionSelectionDTO;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   
   public class FindAssignedItemsCommand extends CommandBase
   {
      
      private var championSelectionModel:ChampionSelectionModel;
      
      public function FindAssignedItemsCommand(param1:ChampionSelectionModel)
      {
         super();
         this.championSelectionModel = param1;
      }
      
      override public function execute() : void
      {
         super.execute();
         this.findAssignedItems();
         onComplete();
         onResult();
      }
      
      private function findAssignedItems() : void
      {
         var _loc3_:ParticipantChampionSelection = null;
         var _loc4_:Champion = null;
         var _loc5_:ChampionSkin = null;
         var _loc1_:GameDTO = this.championSelectionModel.currentGame;
         var _loc2_:PlayerChampionSelectionDTO = _loc1_.getSelectionForSummonerName(this.championSelectionModel.currentPlayerParticipant.summonerInternalName);
         if(_loc2_)
         {
            _loc3_ = this.championSelectionModel.championSelections.getSelectionByChampionId(_loc2_.championId);
            if(_loc3_)
            {
               _loc4_ = _loc3_.champion;
            }
            if((_loc4_) && (!_loc4_.isRandomChampion()))
            {
               _loc5_ = _loc4_.getChampionSkinForIndex(_loc2_.selectedSkinIndex);
               this.championSelectionModel.selectedChampion = _loc3_;
               this.championSelectionModel.currentPlayerSelection.champion = _loc4_;
               SkinsConfig.instance.setLastSelectedSkin(_loc5_);
               this.championSelectionModel.selectionsAssigned();
            }
         }
      }
   }
}
