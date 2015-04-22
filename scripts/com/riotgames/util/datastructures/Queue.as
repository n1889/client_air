package com.riotgames.util.datastructures
{
   import blix.IDestructible;
   import blix.ds.LinkedList;
   
   public class Queue extends Object implements IDestructible
   {
      
      private var items:LinkedList;
      
      public function Queue()
      {
         this.items = new LinkedList();
         super();
      }
      
      public function add(param1:*) : void
      {
         this.items.addItem(param1);
      }
      
      public function peek() : *
      {
         return this.items.getHead();
      }
      
      public function poll() : *
      {
         var _loc1_:* = this.items.getHead();
         this.items.removeItem(_loc1_);
         return _loc1_;
      }
      
      public function destroy() : void
      {
         var _loc1_:* = undefined;
         do
         {
            _loc1_ = this.poll();
            if(_loc1_ is IDestructible)
            {
               (_loc1_ as IDestructible).destroy();
            }
         }
         while(_loc1_ != null);
         
         this.items.removeAll();
      }
   }
}
