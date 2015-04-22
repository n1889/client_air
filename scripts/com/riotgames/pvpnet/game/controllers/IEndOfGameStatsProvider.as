package com.riotgames.pvpnet.game.controllers
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.ISignal;
   
   public interface IEndOfGameStatsProvider extends IProvider
   {
      
      function getTutorialGameComplete() : ISignal;
      
      function getEndOfGameMessageReceived() : ISignal;
   }
}
