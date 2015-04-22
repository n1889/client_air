package com.riotgames.platform.gameclient.domain.celebration
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class CelebrationResponseDTO extends Object implements IEventDispatcher
   {
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _1389994405celebrationId:Number;
      
      public function CelebrationResponseDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function get celebrationId() : Number
      {
         return this._1389994405celebrationId;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set celebrationId(param1:Number) : void
      {
         var _loc2_:Object = this._1389994405celebrationId;
         if(_loc2_ !== param1)
         {
            this._1389994405celebrationId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"celebrationId",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}
