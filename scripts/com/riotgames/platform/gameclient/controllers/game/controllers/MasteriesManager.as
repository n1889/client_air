package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import blix.IDestructible;
   import com.riotgames.platform.masteries.objects.MasteryPageInfoSummary;
   import com.riotgames.platform.gameclient.controllers.game.enums.MenuStates;
   import com.riotgames.platform.masteries.IMasteriesProvider;
   import mx.events.CollectionEvent;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.provider.ProviderLookup;
   import flash.events.Event;
   
   public class MasteriesManager extends Object implements IMasteriesManager, IDestructible
   {
      
      private var masteriesProvider:IMasteriesProvider;
      
      private var championSelectionModel:ChampionSelectionModel;
      
      public function MasteriesManager(param1:ChampionSelectionModel)
      {
         super();
         this.championSelectionModel = param1;
      }
      
      private function getSelectedPage() : MasteryPageInfoSummary
      {
         var _loc1_:MasteryPageInfoSummary = null;
         if((this.championSelectionModel) && (this.championSelectionModel.masteryPages))
         {
            for each(_loc1_ in this.championSelectionModel.masteryPages)
            {
               if(_loc1_.isCurrent)
               {
                  return _loc1_;
               }
            }
         }
         return null;
      }
      
      public function setMasteryPage(param1:MasteryPageInfoSummary) : void
      {
         if((!this.masteriesProvider) || (!param1))
         {
            return;
         }
         this.masteriesProvider.setSelectedPageByID(param1.pageID);
         this.championSelectionModel.selectedMasteryPage = param1;
      }
      
      private function updateMasteriesState() : void
      {
         this.championSelectionModel.masteriesSynced = this.championSelectionModel.masteriesMenuState == MenuStates.SMALL_MENU_STATE_ACTIVE;
      }
      
      private function onMasteriesProvider(param1:IMasteriesProvider) : void
      {
         this.masteriesProvider = param1;
         this.championSelectionModel.masteryPages = this.masteriesProvider.getPagesInfo();
         if(this.championSelectionModel.masteryPages.length > 0)
         {
            this.championSelectionModel.selectedMasteryPage = this.getSelectedPage();
         }
         else
         {
            this.championSelectionModel.masteryPages.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onPagesUpdated);
         }
         this.updateMasteriesState();
         this.championSelectionModel.addEventListener(ChampionSelectionModel.MASTERIES_MENU_CHANGED,this.onMasteriesMenuChanged,false,0,true);
         this.masteriesProvider.getPagesInfoUpdated().add(this.onPagesInfoUpdated);
      }
      
      private function onPagesInfoUpdated(param1:ArrayCollection) : void
      {
         if(this.championSelectionModel != null)
         {
            this.championSelectionModel.masteryPages = param1;
            if(this.championSelectionModel.masteryPages != null)
            {
               this.championSelectionModel.masteryPages.refresh();
            }
         }
      }
      
      public function loadMasteries() : void
      {
         if(this.masteriesProvider)
         {
            return;
         }
         ProviderLookup.getProvider(IMasteriesProvider,this.onMasteriesProvider);
      }
      
      private function onPagesUpdated(param1:CollectionEvent) : void
      {
         this.championSelectionModel.selectedMasteryPage = this.getSelectedPage();
      }
      
      private function getPageById(param1:int) : MasteryPageInfoSummary
      {
         var _loc2_:MasteryPageInfoSummary = null;
         if((this.championSelectionModel) && (this.championSelectionModel.masteryPages))
         {
            for each(_loc2_ in this.championSelectionModel.masteryPages)
            {
               if(_loc2_.pageID == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function destroy() : void
      {
         if(this.championSelectionModel != null)
         {
            this.championSelectionModel.removeEventListener(ChampionSelectionModel.MASTERIES_MENU_CHANGED,this.onMasteriesMenuChanged);
            if(this.championSelectionModel.masteryPages != null)
            {
               this.championSelectionModel.masteryPages.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onPagesUpdated);
            }
         }
         if(this.masteriesProvider != null)
         {
            this.masteriesProvider.getPagesInfoUpdated().remove(this.onPagesInfoUpdated);
         }
      }
      
      private function onMasteriesMenuChanged(param1:Event) : void
      {
         this.updateMasteriesState();
      }
   }
}
