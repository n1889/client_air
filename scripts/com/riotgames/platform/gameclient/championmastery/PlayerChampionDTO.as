package com.riotgames.platform.gameclient.championmastery
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class PlayerChampionDTO extends Object implements IEventDispatcher
   {
      
      private var _1537709924championId:Number;
      
      private var _1879273436playerId:Number;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function PlayerChampionDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function fromObject(param1:Object) : PlayerChampionDTO
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:PlayerChampionDTO = new PlayerChampionDTO();
         if(param1.hasOwnProperty("playerId"))
         {
            _loc2_.playerId = Number(param1["playerId"]);
         }
         if(param1.hasOwnProperty("championId"))
         {
            _loc2_.championId = Number(param1["championId"]);
         }
         return _loc2_;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
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
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
   }
}
