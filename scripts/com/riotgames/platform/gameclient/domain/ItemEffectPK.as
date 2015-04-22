package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class ItemEffectPK extends Object implements IEventDispatcher
   {
      
      private var _1178662002itemId:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1017208180effectId:int;
      
      public function ItemEffectPK()
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
      
      public function get effectId() : int
      {
         return this._1017208180effectId;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get itemId() : int
      {
         return this._1178662002itemId;
      }
      
      public function set effectId(param1:int) : void
      {
         var _loc2_:Object = this._1017208180effectId;
         if(_loc2_ !== param1)
         {
            this._1017208180effectId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"effectId",_loc2_,param1));
         }
      }
      
      public function set itemId(param1:int) : void
      {
         var _loc2_:Object = this._1178662002itemId;
         if(_loc2_ !== param1)
         {
            this._1178662002itemId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemId",_loc2_,param1));
         }
      }
   }
}
