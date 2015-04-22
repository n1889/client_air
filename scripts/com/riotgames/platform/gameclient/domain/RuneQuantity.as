package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class RuneQuantity extends Object implements IEventDispatcher
   {
      
      private var _919815691runeId:int;
      
      private var _1285004149quantity:int;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function RuneQuantity()
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
      
      public function set runeId(param1:int) : void
      {
         var _loc2_:Object = this._919815691runeId;
         if(_loc2_ !== param1)
         {
            this._919815691runeId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"runeId",_loc2_,param1));
         }
      }
      
      public function get quantity() : int
      {
         return this._1285004149quantity;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get runeId() : int
      {
         return this._919815691runeId;
      }
      
      public function set quantity(param1:int) : void
      {
         var _loc2_:Object = this._1285004149quantity;
         if(_loc2_ !== param1)
         {
            this._1285004149quantity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"quantity",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
   }
}
