package com.riotgames.platform.gameclient.utils
{
   import flash.utils.Dictionary;
   
   public class NotifyingDictionary extends Object
   {
      
      private var map:Dictionary;
      
      private var listeners:Dictionary;
      
      public function NotifyingDictionary()
      {
         this.map = new Dictionary();
         this.listeners = new Dictionary();
         super();
      }
      
      public function addValue(param1:*, param2:Object) : void
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Function = null;
         this.map[param1] = param2;
         if(this.listeners[param1])
         {
            _loc3_ = this.listeners[param1];
            for each(_loc4_ in _loc3_)
            {
               _loc4_(param2);
            }
            delete this.listeners[param1];
            true;
         }
      }
      
      public function removeListener(param1:*, param2:Function) : void
      {
         var _loc3_:Dictionary = null;
         if(this.listeners[param1])
         {
            _loc3_ = this.listeners[param1];
            delete _loc3_[param2];
            true;
         }
      }
      
      public function getValue(param1:*) : *
      {
         return this.map[param1];
      }
      
      public function listenToKey(param1:*, param2:Function) : void
      {
         var _loc3_:Object = this.getValue(param1);
         if(_loc3_)
         {
            param2(_loc3_);
            return;
         }
         if(!this.listeners[param1])
         {
            this.listeners[param1] = new Dictionary();
         }
         var _loc4_:Dictionary = this.listeners[param1];
         _loc4_[param2] = param2;
      }
   }
}
