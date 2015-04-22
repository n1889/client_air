package com.riotgames.platform.gameclient.controllers.game.mediators
{
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.platform.gameclient.domain.Champion;
   import blix.signals.ISignal;
   import blix.signals.Signal;
   import com.riotgames.platform.gameclient.components.button.ChromaSwatchButton;
   import com.riotgames.platform.gameclient.controllers.game.utils.ChampionImagesCache;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import mx.containers.HBox;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   import mx.controls.Image;
   import mx.events.FlexEvent;
   import flash.display.Bitmap;
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   import com.riotgames.platform.gameclient.controllers.game.utils.ChromaUtils;
   
   public class ChromaMediator extends Object
   {
      
      private var _onUpdateChromaDisplay:Signal;
      
      private var _chromaInventory:Vector.<ChampionSkin>;
      
      private var _onChromaSelected:Signal;
      
      private var _chromaEnabledConfig:ConfigurationModel;
      
      private var _chromaButtonContainer:HBox;
      
      private var _chromaPreviewImage:Image;
      
      private var _chromaSelectionManager:ChromaSelectionManager;
      
      private var _chromaEnabledChange:Signal;
      
      public function ChromaMediator(param1:HBox, param2:Image)
      {
         super();
         this._chromaButtonContainer = param1;
         this._chromaPreviewImage = param2;
         this._chromaEnabledConfig = DynamicClientConfigManager.getConfiguration(ChromaUtils.CHROMA_CONFIG_NAMESPACE,ChromaUtils.ENABLED_SETTING,false,this.onChromaEnabledChange);
         this._chromaSelectionManager = new ChromaSelectionManager();
         this._chromaInventory = new Vector.<ChampionSkin>();
         this._chromaEnabledChange = new Signal();
         this._onUpdateChromaDisplay = new Signal();
         this._onChromaSelected = new Signal();
      }
      
      private function onChromaButtonClick() : void
      {
         this.fadeOutChromaPreview();
         this._onChromaSelected.dispatch(this._chromaSelectionManager.selectedData);
      }
      
      private function fetchChromasForSkin(param1:ChampionSkin) : void
      {
         var _loc2_:Champion = param1.getChampion();
         var _loc3_:int = param1.championId;
         var _loc4_:int = param1.skinIndex;
         var _loc5_:int = int(_loc3_.toString() + "000") + _loc4_;
         if(_loc2_.chromas.hasOwnProperty(_loc5_.toString()))
         {
            this._chromaInventory = _loc2_.chromas[_loc5_];
            return;
         }
         this._chromaInventory = new Vector.<ChampionSkin>();
      }
      
      public function get onUpdateChromaDisplay() : ISignal
      {
         return this._onUpdateChromaDisplay;
      }
      
      public function updateSkinSelection(param1:ChampionSkin) : void
      {
         if((!this._chromaEnabledConfig.getBoolean()) || (!param1))
         {
            return;
         }
         this.updateChromaDisplay(param1);
      }
      
      private function addChromaButton(param1:ChampionSkin, param2:Boolean = false) : void
      {
         var _loc3_:ChromaSwatchButton = new ChromaSwatchButton();
         _loc3_.data = param1;
         _loc3_.enabled = param1.isAvailable();
         this._chromaSelectionManager.addButton(_loc3_,param2);
         this._chromaButtonContainer.addChild(_loc3_);
         ChampionImagesCache.instance.getChromaSwatch(param1.championSkinName,param1.skinIndex,_loc3_.onSwatchLoaded);
      }
      
      private function addChromaParentButton(param1:ChampionSkin, param2:Boolean = false) : void
      {
         if(param1.isChroma)
         {
            var param1:ChampionSkin = param1.getChampion().getChampionSkinForIndex(param1.chromaParent % 1000);
         }
         var _loc3_:ChromaSwatchButton = new ChromaSwatchButton();
         _loc3_.data = param1;
         _loc3_.enabled = param1.isAvailable();
         this._chromaSelectionManager.addButton(_loc3_,param2);
         this._chromaButtonContainer.addChild(_loc3_);
         ChampionImagesCache.instance.getNoSelectionChromaSwatch(_loc3_.onSwatchLoaded);
      }
      
      private function drawChromaButtons(param1:ChampionSkin) : void
      {
         var _loc3_:ChampionSkin = null;
         this.clearChromaButtons();
         this._chromaSelectionManager.chromaSelectionChange.add(this.onChromaButtonClick);
         this.addChromaParentButton(param1,!param1.isChroma);
         var _loc2_:int = 0;
         while(_loc2_ < this._chromaInventory.length)
         {
            _loc3_ = this._chromaInventory[_loc2_];
            this.addChromaButton(_loc3_,param1.skinId == _loc3_.skinId);
            _loc2_++;
         }
      }
      
      private function fadeOutChromaButtons() : void
      {
         if(this._chromaButtonContainer.visible)
         {
            this._chromaButtonContainer.visible = false;
         }
      }
      
      private function clearChromaDisplay() : void
      {
         this.clearChromaButtons();
         this.cleanChromaInventory();
      }
      
      private function fadeOutChromaPreview() : void
      {
         if(this._chromaPreviewImage.visible)
         {
            this._chromaPreviewImage.visible = false;
         }
      }
      
      public function chromaIsEnabled() : Boolean
      {
         return this._chromaEnabledConfig.getBoolean();
      }
      
      public function updatePlayerSelection(param1:Champion) : void
      {
         if((!this._chromaEnabledConfig.getBoolean()) || (!param1))
         {
            return;
         }
         var _loc2_:ChampionSkin = SkinsConfig.instance.getLastSelectedSkinForChampion(param1);
         this.updateSkinSelection(_loc2_);
      }
      
      private function updateChromaDisplay(param1:ChampionSkin) : void
      {
         var _loc2_:* = 0;
         var _loc3_:ChampionSkin = null;
         this.fetchChromasForSkin(param1);
         if(this._chromaInventory.length > 0)
         {
            this.fadeOutChromaPreview();
            this.clearChromaButtons();
            this.drawChromaButtons(param1);
            this.fadeInChromaButtons();
         }
         else if(!param1.isChroma)
         {
            this.hideChromaElements();
         }
         else
         {
            _loc2_ = param1.chromaParent % 1000;
            _loc3_ = param1.getChampion().getChampionSkinForIndex(_loc2_);
            this.fetchChromasForSkin(_loc3_);
            this.drawChromaButtons(param1);
            this.updateChromaPreview();
            this.fadeInChromaButtons();
            this._onUpdateChromaDisplay.dispatch(param1);
         }
         
      }
      
      private function clearChromaButtons() : void
      {
         this._chromaSelectionManager.chromaSelectionChange.remove(this.onChromaButtonClick);
         this._chromaSelectionManager.clearButtonList();
         this._chromaButtonContainer.removeAllChildren();
      }
      
      private function updateChromaPreview() : void
      {
         var _loc1_:String = null;
         var _loc2_:* = NaN;
         if(this._chromaSelectionManager.selectedData.isChroma)
         {
            _loc1_ = this._chromaSelectionManager.selectedData.championSkinName;
            _loc2_ = this._chromaSelectionManager.selectedData.skinIndex;
            ChampionImagesCache.instance.getChampCard(_loc1_,_loc2_,this.onChromaPreviewLoaded);
         }
      }
      
      private function fadeInChromaButtons() : void
      {
         this._chromaButtonContainer.visible = true;
      }
      
      private function onChromaEnabledChange() : void
      {
         this._chromaEnabledChange.dispatch(this._chromaEnabledConfig.getBoolean());
         if(this._chromaEnabledConfig.getBoolean())
         {
            return;
         }
         this.clearChromaDisplay();
         this.cleanChromaInventory();
      }
      
      public function hideChromaElements() : void
      {
         this.fadeOutChromaButtons();
         this.fadeOutChromaPreview();
      }
      
      public function get onChromaSelected() : ISignal
      {
         return this._onChromaSelected;
      }
      
      private function fadeInChromaPreview(param1:FlexEvent) : void
      {
         param1.stopImmediatePropagation();
         this._chromaPreviewImage.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.fadeInChromaPreview,false);
         this._chromaPreviewImage.visible = true;
      }
      
      public function get chromaEnabledChange() : ISignal
      {
         return this._chromaEnabledChange;
      }
      
      private function cleanChromaInventory() : void
      {
         this._chromaInventory = new Vector.<ChampionSkin>();
      }
      
      private function onChromaPreviewLoaded(param1:Bitmap) : void
      {
         this._chromaPreviewImage.addEventListener(FlexEvent.UPDATE_COMPLETE,this.fadeInChromaPreview,false,0,true);
         this._chromaPreviewImage.source = param1;
      }
   }
}
