package com.riotgames.landing
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   import blix.signals.ISignal;
   
   public interface ILobbyLandingPage extends IProvider
   {
      
      function configureLandingPage(param1:Object) : void;
      
      function showLandingPage(param1:DisplayAdapter) : void;
      
      function getReady() : ISignal;
      
      function getJsonNavigate() : ISignal;
      
      function getSpectateFeaturedGame() : ISignal;
   }
}
