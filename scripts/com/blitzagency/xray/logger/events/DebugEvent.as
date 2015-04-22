package com.blitzagency.xray.logger.events
{
   import flash.events.Event;
   
   public class DebugEvent extends Event
   {
      
      public var obj:Object;
      
      public function DebugEvent(type:String, bubbles:Boolean, cancelable:Boolean, p_obj:Object)
      {
         obj = new Object();
         super(type,bubbles,cancelable);
         obj = p_obj;
      }
   }
}
