package com.riotgames.platform.common.services
{
   import flash.events.IEventDispatcher;
   import blix.signals.ISignal;
   
   public interface ServerStatusService extends IEventDispatcher
   {
      
      function getStatusRefreshed() : ISignal;
      
      function set hostString(param1:String) : void;
      
      function getServerStatus() : void;
      
      function set endpointString(param1:String) : void;
   }
}
