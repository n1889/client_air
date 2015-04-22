package com.riotgames.platform.gameclient.domain.celebration
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class CelebrationDTO extends Object implements IClientNotification, IEventDispatcher
   {
      
      private var _50145604celebrationType:String;
      
      private var _1389994405celebrationId:Number;
      
      private var _49599404celebrationBody:String;
      
      private var _1554041230celebrationTitle:String;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function CelebrationDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function set celebrationType(param1:String) : void
      {
         var _loc2_:Object = this._50145604celebrationType;
         if(_loc2_ !== param1)
         {
            this._50145604celebrationType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"celebrationType",_loc2_,param1));
         }
      }
      
      public function get celebrationType() : String
      {
         return this._50145604celebrationType;
      }
      
      public function get notificationType() : String
      {
         return "CLB";
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get celebrationTitle() : String
      {
         return this._1554041230celebrationTitle;
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
      
      public function set celebrationBody(param1:String) : void
      {
         var _loc2_:Object = this._49599404celebrationBody;
         if(_loc2_ !== param1)
         {
            this._49599404celebrationBody = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"celebrationBody",_loc2_,param1));
         }
      }
      
      public function get celebrationBody() : String
      {
         return this._49599404celebrationBody;
      }
      
      public function set celebrationTitle(param1:String) : void
      {
         var _loc2_:Object = this._1554041230celebrationTitle;
         if(_loc2_ !== param1)
         {
            this._1554041230celebrationTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"celebrationTitle",_loc2_,param1));
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function get celebrationId() : Number
      {
         return this._1389994405celebrationId;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
   }
}
