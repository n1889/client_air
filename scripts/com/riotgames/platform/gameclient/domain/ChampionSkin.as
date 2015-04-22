package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import flash.events.EventDispatcher;
   import flash.events.Event;
   
   public class ChampionSkin extends RentableInventoryItem implements IEventDispatcher
   {
      
      private var _35914986freeToPlayReward:Boolean;
      
      private var _chromaParent:int;
      
      private var _isChroma:Boolean;
      
      private var _900562056skinId:Number;
      
      private var _1799051449stillObtainable:Boolean = true;
      
      private var _isDefault:Boolean;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1537709924championId:Number;
      
      private var _528878767lastSelected:Boolean;
      
      private var _106164901owned:Boolean;
      
      private var _isDisabled:Boolean = false;
      
      private var champion:Champion;
      
      public function ChampionSkin(param1:Boolean = false)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this._isDefault = param1;
      }
      
      private function set _687094720isChroma(param1:Boolean) : void
      {
         this._isChroma = param1;
      }
      
      public function getIsDefault() : Boolean
      {
         return this._isDefault;
      }
      
      public function set isChroma(param1:Boolean) : void
      {
         var _loc2_:Object = this.isChroma;
         if(_loc2_ !== param1)
         {
            this._687094720isChroma = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isChroma",_loc2_,param1));
         }
      }
      
      private function set _2016885077skinIndex(param1:Number) : void
      {
         if((this.champion.skinInfo) && (!(this.champion.skinInfo[this.skinId.toString()] == null)))
         {
            this.champion.skinInfo[this.skinId.toString()].skinIndex = param1;
         }
      }
      
      public function get name() : String
      {
         return this.champion.skinInfo[this.skinId.toString()].name;
      }
      
      public function getLocalizedSkinName() : String
      {
         var _loc1_:String = RiotResourceLoader.getChampionResourceString("name",this.championSkinName,this.championSkinName);
         var _loc2_:String = _loc1_;
         if(this.skinIndex == 0)
         {
            _loc2_ = RiotResourceLoader.getString("championSelection_skinBrowser_champion_classic","Classic");
         }
         else
         {
            _loc2_ = RiotResourceLoader.getChampionSkinResourceString("name",this.championSkinName,this.skinIndex,_loc1_);
         }
         return _loc2_;
      }
      
      public function set stillObtainable(param1:Boolean) : void
      {
         var _loc2_:Object = this._1799051449stillObtainable;
         if(_loc2_ !== param1)
         {
            this._1799051449stillObtainable = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stillObtainable",_loc2_,param1));
         }
      }
      
      public function set chromaParent(param1:int) : void
      {
         var _loc2_:Object = this.chromaParent;
         if(_loc2_ !== param1)
         {
            this._1562941120chromaParent = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chromaParent",_loc2_,param1));
         }
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function get skinDisabled() : Boolean
      {
         return this._isDisabled;
      }
      
      public function set lastSelected(param1:Boolean) : void
      {
         var _loc2_:Object = this._528878767lastSelected;
         if(_loc2_ !== param1)
         {
            this._528878767lastSelected = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lastSelected",_loc2_,param1));
         }
      }
      
      public function get owned() : Boolean
      {
         return this._106164901owned;
      }
      
      public function set skinIndex(param1:Number) : void
      {
         var _loc2_:Object = this.skinIndex;
         if(_loc2_ !== param1)
         {
            this._2016885077skinIndex = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinIndex",_loc2_,param1));
         }
      }
      
      public function get championSkinName() : String
      {
         return this.champion.skinName;
      }
      
      private function set _1410615527skinDisabled(param1:Boolean) : void
      {
         this._isDisabled = param1;
      }
      
      public function set skinDisabled(param1:Boolean) : void
      {
         var _loc2_:Object = this.skinDisabled;
         if(_loc2_ !== param1)
         {
            this._1410615527skinDisabled = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinDisabled",_loc2_,param1));
         }
      }
      
      public function isAvailable() : Boolean
      {
         return (this.owned) || (this.isRented()) || (this.skinIndex == 0) || (this.freeToPlayReward);
      }
      
      public function get isChroma() : Boolean
      {
         return this._isChroma;
      }
      
      public function get stillObtainable() : Boolean
      {
         return this._1799051449stillObtainable;
      }
      
      public function set championId(param1:Number) : void
      {
         var _loc2_:Object = this._1537709924championId;
         if(_loc2_ !== param1)
         {
            this._1537709924championId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championId",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get chromaParent() : int
      {
         return this._chromaParent;
      }
      
      public function set owned(param1:Boolean) : void
      {
         var _loc2_:Object = this._106164901owned;
         if(_loc2_ !== param1)
         {
            this._106164901owned = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"owned",_loc2_,param1));
         }
      }
      
      public function set freeToPlayReward(param1:Boolean) : void
      {
         var _loc2_:Object = this._35914986freeToPlayReward;
         if(_loc2_ !== param1)
         {
            this._35914986freeToPlayReward = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"freeToPlayReward",_loc2_,param1));
         }
      }
      
      public function get skinIndex() : Number
      {
         if((this.champion.skinInfo) && (!(this.champion.skinInfo[this.skinId.toString()] == null)))
         {
            return this.champion.skinInfo[this.skinId.toString()].skinIndex;
         }
         return 0;
      }
      
      public function get lastSelected() : Boolean
      {
         return this._528878767lastSelected;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function getChampion() : Champion
      {
         return this.champion;
      }
      
      public function setChampion(param1:Champion) : void
      {
         this.champion = param1;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      private function set _1562941120chromaParent(param1:int) : void
      {
         this._chromaParent = param1;
      }
      
      public function get freeToPlayReward() : Boolean
      {
         return this._35914986freeToPlayReward;
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set skinId(param1:Number) : void
      {
         var _loc2_:Object = this._900562056skinId;
         if(_loc2_ !== param1)
         {
            this._900562056skinId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinId",_loc2_,param1));
         }
      }
      
      public function get skinId() : Number
      {
         return this._900562056skinId;
      }
   }
}
