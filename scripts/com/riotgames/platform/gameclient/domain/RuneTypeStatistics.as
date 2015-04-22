package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class RuneTypeStatistics extends Object implements IEventDispatcher
   {
      
      private var _1781339372runeTypeImagePath;
      
      private var _820719676runeTier:int;
      
      private var _342999563runeCount:uint;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function RuneTypeStatistics(param1:int, param2:*)
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
         this.runeCount = 0;
         this.runeTier = param1;
         this.runeTypeImagePath = param2;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function get runeTypeImagePath() : *
      {
         return this._1781339372runeTypeImagePath;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function set runeCount(param1:uint) : void
      {
         var _loc2_:Object = this._342999563runeCount;
         if(_loc2_ !== param1)
         {
            this._342999563runeCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"runeCount",_loc2_,param1));
         }
      }
      
      public function get runeCount() : uint
      {
         return this._342999563runeCount;
      }
      
      public function set runeTier(param1:int) : void
      {
         var _loc2_:Object = this._820719676runeTier;
         if(_loc2_ !== param1)
         {
            this._820719676runeTier = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"runeTier",_loc2_,param1));
         }
      }
      
      public function get runeTier() : int
      {
         return this._820719676runeTier;
      }
      
      public function set runeTypeImagePath(param1:*) : void
      {
         var _loc2_:Object = this._1781339372runeTypeImagePath;
         if(_loc2_ !== param1)
         {
            this._1781339372runeTypeImagePath = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"runeTypeImagePath",_loc2_,param1));
         }
      }
   }
}
