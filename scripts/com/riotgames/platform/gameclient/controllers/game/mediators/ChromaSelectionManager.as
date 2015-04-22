package com.riotgames.platform.gameclient.controllers.game.mediators
{
   import com.riotgames.platform.gameclient.components.button.ChromaSwatchButton;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import blix.signals.ISignal;
   import blix.signals.Signal;
   
   public class ChromaSelectionManager extends Object
   {
      
      private var _selectedData:ChampionSkin;
      
      private var _chromaSelectionChange:Signal;
      
      private var _selectedButton:ChromaSwatchButton;
      
      private var _buttonList:Vector.<ChromaSwatchButton>;
      
      public function ChromaSelectionManager()
      {
         super();
         this.clearButtonList();
         this._chromaSelectionChange = new Signal();
      }
      
      private function onSelected(param1:ChromaSwatchButton) : void
      {
         var _loc3_:ChromaSwatchButton = null;
         this._selectedButton = param1;
         this._selectedData = ChampionSkin(this._selectedButton.data);
         var _loc2_:int = 0;
         while(_loc2_ < this._buttonList.length)
         {
            _loc3_ = this._buttonList[_loc2_];
            _loc3_.selected = false;
            _loc2_++;
         }
         this._selectedButton.selected = true;
         this._chromaSelectionChange.dispatch();
      }
      
      public function get selectedData() : ChampionSkin
      {
         return this._selectedData;
      }
      
      public function get chromaSelectionChange() : ISignal
      {
         return this._chromaSelectionChange;
      }
      
      public function addButton(param1:ChromaSwatchButton, param2:Boolean = false) : void
      {
         this._buttonList.push(param1);
         param1.selectedChange.add(this.onSelected);
         if(param2)
         {
            this._selectedButton = param1;
            this._selectedData = ChampionSkin(this._selectedButton.data);
            this._selectedButton.selected = true;
         }
      }
      
      public function clearButtonList() : void
      {
         var _loc1_:ChromaSwatchButton = null;
         if(this._buttonList)
         {
            while(this._buttonList.length > 0)
            {
               _loc1_ = this._buttonList.shift();
               _loc1_.selectedChange.remove(this.onSelected);
               _loc1_ = null;
            }
         }
         this._buttonList = new Vector.<ChromaSwatchButton>();
      }
   }
}
