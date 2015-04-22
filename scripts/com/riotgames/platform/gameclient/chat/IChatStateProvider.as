package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.ISignal;
   
   public interface IChatStateProvider extends IProvider
   {
      
      function getCurrentState() : String;
      
      function getCurrentStateChanged() : ISignal;
   }
}
