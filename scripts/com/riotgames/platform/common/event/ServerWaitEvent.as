package com.riotgames.platform.common.event
{
   import flash.events.Event;
   
   public class ServerWaitEvent extends Event
   {
      
      public static const HIDE:String = "ServerWaitEvent.HIDE";
      
      public static const SHOW:String = "ServerWaitEvent.SHOW";
      
      public function ServerWaitEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}
