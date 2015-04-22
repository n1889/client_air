package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.chat.domain.PresenceStatusData;
   import blix.signals.ISignal;
   
   public interface ISpectatorProvider extends IProvider
   {
      
      function spectateFeaturedGame(param1:Number, param2:String, param3:String, param4:int, param5:String) : void;
      
      function canDropInSpectate(param1:PresenceStatusData) : Boolean;
      
      function getSpectatingStateChangeSignal() : ISignal;
      
      function spectateSummoner(param1:String) : void;
   }
}
