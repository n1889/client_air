package com.riotgames.platform.gameclient.domain.rankedTeams
{
   import com.riotgames.platform.gameclient.domain.AbstractDomainObject;
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import com.riotgames.platform.gameclient.domain.AggregatedStats;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class PlayerAggregatedStats extends AbstractDomainObject implements IEventDispatcher
   {
      
      private var _1879273436playerId:Number;
      
      private var _640804122aggregatedStats:AggregatedStats;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function PlayerAggregatedStats()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set aggregatedStats(param1:AggregatedStats) : void
      {
         var _loc2_:Object = this._640804122aggregatedStats;
         if(_loc2_ !== param1)
         {
            this._640804122aggregatedStats = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"aggregatedStats",_loc2_,param1));
         }
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
      
      public function get aggregatedStats() : AggregatedStats
      {
         return this._640804122aggregatedStats;
      }
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
   }
}
