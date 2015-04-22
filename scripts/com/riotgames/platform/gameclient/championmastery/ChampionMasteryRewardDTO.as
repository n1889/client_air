package com.riotgames.platform.gameclient.championmastery
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class ChampionMasteryRewardDTO extends Object implements IEventDispatcher
   {
      
      private var _1537709924championId:Number;
      
      private var _1879273436playerId:Number;
      
      private var _889681794rewardValue:String;
      
      private var _1691230985rewardType:String;
      
      private var _102865796level:Number;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function ChampionMasteryRewardDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function fromObject(param1:Object) : ChampionMasteryRewardDTO
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ChampionMasteryRewardDTO = new ChampionMasteryRewardDTO();
         if(param1.hasOwnProperty("playerId"))
         {
            _loc2_.playerId = Number(param1["playerId"]);
         }
         if(param1.hasOwnProperty("championId"))
         {
            _loc2_.championId = Number(param1["championId"]);
         }
         if(param1.hasOwnProperty("level"))
         {
            _loc2_.level = Number(param1["level"]);
         }
         if(param1.hasOwnProperty("rewardType"))
         {
            _loc2_.rewardType = String(param1["rewardType"]);
         }
         if(param1.hasOwnProperty("rewardValue"))
         {
            _loc2_.rewardValue = String(param1["rewardValue"]);
         }
         return _loc2_;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function get rewardValue() : String
      {
         return this._889681794rewardValue;
      }
      
      public function get level() : Number
      {
         return this._102865796level;
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
      
      public function get rewardType() : String
      {
         return this._1691230985rewardType;
      }
      
      public function set rewardValue(param1:String) : void
      {
         var _loc2_:Object = this._889681794rewardValue;
         if(_loc2_ !== param1)
         {
            this._889681794rewardValue = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rewardValue",_loc2_,param1));
         }
      }
      
      public function set level(param1:Number) : void
      {
         var _loc2_:Object = this._102865796level;
         if(_loc2_ !== param1)
         {
            this._102865796level = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"level",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set rewardType(param1:String) : void
      {
         var _loc2_:Object = this._1691230985rewardType;
         if(_loc2_ !== param1)
         {
            this._1691230985rewardType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rewardType",_loc2_,param1));
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
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
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
