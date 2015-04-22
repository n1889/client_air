package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   import com.riotgames.rust.components.sidebar.INestedScreen;
   import blix.context.IContext;
   import blix.signals.Signal;
   
   public interface ICLSProvider extends IProvider
   {
      
      function hide(param1:DisplayAdapter) : void;
      
      function loadDataForSummoner(param1:Number) : void;
      
      function set currentSummoner(param1:String) : void;
      
      function getTeamProfileDecayMessages(param1:String) : Object;
      
      function processLatestMessage(param1:Object) : Boolean;
      
      function getCLS(param1:IContext) : INestedScreen;
      
      function get statsSignal() : Signal;
      
      function processDecayMessages() : void;
      
      function get leagueUpdateMessageReceivedSignal() : Signal;
      
      function show(param1:DisplayAdapter) : void;
      
      function get lobbySignal() : Signal;
   }
}
