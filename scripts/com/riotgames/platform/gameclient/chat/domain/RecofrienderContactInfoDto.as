package com.riotgames.platform.gameclient.chat.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class RecofrienderContactInfoDto extends Object implements IEventDispatcher
   {
      
      public static const FRIEND_STATE_NONE:String = "NONE";
      
      public static const FRIEND_STATE_DISMISSED:String = "DISMISSED";
      
      public static const FRIEND_STATE_SUGGESTED:String = "SUGGESTED";
      
      public static const FRIEND_STATE_INVITED:String = "INVITED";
      
      public var viewed:Boolean;
      
      public var recommendScore:Number;
      
      public var summonerId:Number;
      
      public var source:String;
      
      private var _1604183279displayState:String;
      
      public var platformId:String;
      
      public var accountId:Number;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1422950858action:String;
      
      public function RecofrienderContactInfoDto()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function buildFromJson(param1:Object) : RecofrienderContactInfoDto
      {
         var _loc2_:RecofrienderContactInfoDto = new RecofrienderContactInfoDto();
         _loc2_.platformId = param1.platformId;
         _loc2_.accountId = param1.accountId;
         _loc2_.summonerId = param1.summonerId;
         _loc2_.action = param1.action;
         _loc2_.source = param1.source;
         _loc2_.displayState = param1.displayState;
         _loc2_.recommendScore = param1.recommendScore;
         _loc2_.viewed = param1.viewed;
         return _loc2_;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function getSummonerId() : Number
      {
         return this.summonerId;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function getSource() : String
      {
         return this.source;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set displayState(param1:String) : void
      {
         var _loc2_:Object = this._1604183279displayState;
         if(_loc2_ !== param1)
         {
            this._1604183279displayState = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"displayState",_loc2_,param1));
         }
      }
      
      public function getPlatformId() : String
      {
         return this.platformId;
      }
      
      public function getDisplayState() : String
      {
         return this.displayState;
      }
      
      public function getStatus() : String
      {
         return this.action;
      }
      
      public function get displayState() : String
      {
         return this._1604183279displayState;
      }
      
      public function getAccountId() : Number
      {
         return this.accountId;
      }
      
      public function set action(param1:String) : void
      {
         var _loc2_:Object = this._1422950858action;
         if(_loc2_ !== param1)
         {
            this._1422950858action = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"action",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function get action() : String
      {
         return this._1422950858action;
      }
   }
}
