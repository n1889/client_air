package com.riotgames.platform.gameclient.championmastery
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import mx.events.PropertyChangeEvent;
   
   public class ChampionMasteryMiniDTO extends Object implements IEventDispatcher
   {
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1537709924championId:Number;
      
      private var _1879273436playerId:Number;
      
      private var _201916261championLevel:Number;
      
      public function ChampionMasteryMiniDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function fromObject(param1:Object) : ChampionMasteryMiniDTO
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ChampionMasteryMiniDTO = new ChampionMasteryMiniDTO();
         if(param1.hasOwnProperty("playerId"))
         {
            _loc2_.playerId = Number(param1["playerId"]);
         }
         if(param1.hasOwnProperty("championId"))
         {
            _loc2_.championId = Number(param1["championId"]);
         }
         if(param1.hasOwnProperty("championLevel"))
         {
            _loc2_.championLevel = Number(param1["championLevel"]);
         }
         return _loc2_;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
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
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function get championLevel() : Number
      {
         return this._201916261championLevel;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         _loc1_ = _loc1_ + ("PlayerId = " + this.playerId);
         _loc1_ = _loc1_ + (", championId = " + this.championId);
         _loc1_ = _loc1_ + (", championLevel = " + this.championLevel);
         return _loc1_;
      }
      
      public function set championLevel(param1:Number) : void
      {
         var _loc2_:Object = this._201916261championLevel;
         if(_loc2_ !== param1)
         {
            this._201916261championLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championLevel",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set playerId(param1:Number) : void
      {
         var _loc2_:Object = this._1879273436playerId;
         if(_loc2_ !== param1)
         {
            this._1879273436playerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerId",_loc2_,param1));
         }
      }
   }
}
