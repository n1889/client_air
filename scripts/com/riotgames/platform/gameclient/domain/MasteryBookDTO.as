package com.riotgames.platform.gameclient.domain
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.collections.ArrayCollection;
   import mx.events.PropertyChangeEvent;
   import flash.events.EventDispatcher;
   
   public class MasteryBookDTO extends AbstractBook implements IEventDispatcher
   {
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      public function MasteryBookDTO()
      {
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function get bookPages() : ArrayCollection
      {
         return _bookPages;
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
      
      private function set _2010394203bookPages(param1:ArrayCollection) : void
      {
         _bookPages = param1;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function set bookPages(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this.bookPages;
         if(_loc2_ !== param1)
         {
            this._2010394203bookPages = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bookPages",_loc2_,param1));
         }
      }
   }
}
