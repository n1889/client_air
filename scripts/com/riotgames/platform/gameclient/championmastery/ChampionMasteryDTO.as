package com.riotgames.platform.gameclient.championmastery
{
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ChampionMasteryDTO extends Object implements IEventDispatcher
   {
      
      private var _1537709924championId:Number;
      
      private var _158308567lastPlayTime:Number;
      
      private var _1879273436playerId:Number;
      
      private var _360666207championPointsUntilNextLevel:Number;
      
      private var _1841063252championPoints:Number;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _2132786752championPointsSinceLastLevel:Number;
      
      private var _201916261championLevel:Number;
      
      public function ChampionMasteryDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function fromObject(param1:Object) : ChampionMasteryDTO
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ChampionMasteryDTO = new ChampionMasteryDTO();
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
         if(param1.hasOwnProperty("championPoints"))
         {
            _loc2_.championPoints = Number(param1["championPoints"]);
         }
         if(param1.hasOwnProperty("lastPlayTime"))
         {
            _loc2_.lastPlayTime = Number(param1["lastPlayTime"]);
         }
         if(param1.hasOwnProperty("championPointsSinceLastLevel"))
         {
            _loc2_.championPointsSinceLastLevel = Number(param1["championPointsSinceLastLevel"]);
         }
         if(param1.hasOwnProperty("championPointsUntilNextLevel"))
         {
            _loc2_.championPointsUntilNextLevel = Number(param1["championPointsUntilNextLevel"]);
         }
         return _loc2_;
      }
      
      public function get championPointsSinceLastLevel() : Number
      {
         return this._2132786752championPointsSinceLastLevel;
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
      
      public function set championPointsSinceLastLevel(param1:Number) : void
      {
         var _loc2_:Object = this._2132786752championPointsSinceLastLevel;
         if(_loc2_ !== param1)
         {
            this._2132786752championPointsSinceLastLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsSinceLastLevel",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function getPercentToNextLevel() : Number
      {
         if(this.championPointsSinceLastLevel + this.championPointsUntilNextLevel > 0)
         {
            return this.championPointsSinceLastLevel / (this.championPointsSinceLastLevel + this.championPointsUntilNextLevel);
         }
         return 0;
      }
      
      public function get lastPlayTime() : Number
      {
         return this._158308567lastPlayTime;
      }
      
      public function set championPoints(param1:Number) : void
      {
         var _loc2_:Object = this._1841063252championPoints;
         if(_loc2_ !== param1)
         {
            this._1841063252championPoints = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPoints",_loc2_,param1));
         }
      }
      
      public function get championLevel() : Number
      {
         return this._201916261championLevel;
      }
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
      
      public function get championPointsUntilNextLevel() : Number
      {
         return this._360666207championPointsUntilNextLevel;
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
      }
      
      public function get championPoints() : Number
      {
         return this._1841063252championPoints;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function set lastPlayTime(param1:Number) : void
      {
         var _loc2_:Object = this._158308567lastPlayTime;
         if(_loc2_ !== param1)
         {
            this._158308567lastPlayTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lastPlayTime",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
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
      
      public function set playerId(param1:Number) : void
      {
         var _loc2_:Object = this._1879273436playerId;
         if(_loc2_ !== param1)
         {
            this._1879273436playerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerId",_loc2_,param1));
         }
      }
      
      public function set championPointsUntilNextLevel(param1:Number) : void
      {
         var _loc2_:Object = this._360666207championPointsUntilNextLevel;
         if(_loc2_ !== param1)
         {
            this._360666207championPointsUntilNextLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsUntilNextLevel",_loc2_,param1));
         }
      }
   }
}
