package com.riotgames.platform.gameclient.CDC
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   import flash.events.EventDispatcher;
   
   public class ClientDynamicConfigurationNotification extends Object implements IClientNotification, IEventDispatcher
   {
      
      private var _95468472delta:Boolean;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _951117169configs:String;
      
      public function ClientDynamicConfigurationNotification()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function set configs(param1:String) : void
      {
         var _loc2_:Object = this._951117169configs;
         if(_loc2_ !== param1)
         {
            this._951117169configs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"configs",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.DYNAMIC_CONFIGURATION;
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
      
      public function set delta(param1:Boolean) : void
      {
         var _loc2_:Object = this._95468472delta;
         if(_loc2_ !== param1)
         {
            this._95468472delta = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"delta",_loc2_,param1));
         }
      }
      
      public function get configs() : String
      {
         return this._951117169configs;
      }
      
      public function get delta() : Boolean
      {
         return this._95468472delta;
      }
   }
}
