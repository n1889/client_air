package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class RawStatDTO extends AbstractDomainObject implements IEventDispatcher
   {
      
      private var _2033440935statTypeName:String;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _111972721value:Number;
      
      public function RawStatDTO()
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
      
      public function set value(param1:Number) : void
      {
         var _loc2_:Object = this._111972721value;
         if(_loc2_ !== param1)
         {
            this._111972721value = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"value",_loc2_,param1));
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
      
      public function get value() : Number
      {
         return this._111972721value;
      }
      
      public function set statTypeName(param1:String) : void
      {
         var _loc2_:Object = this._2033440935statTypeName;
         if(_loc2_ !== param1)
         {
            this._2033440935statTypeName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statTypeName",_loc2_,param1));
         }
      }
      
      public function get statTypeName() : String
      {
         return this._2033440935statTypeName;
      }
   }
}
