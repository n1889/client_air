package com.riotgames.pvpnet.chrome
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IChromeProvider extends IProvider
   {
      
      function addFrame(param1:DisplayAdapter) : void;
      
      function addWindowControls(param1:DisplayAdapter) : void;
      
      function registerCloseRequestedResponder(param1:Function) : void;
   }
}
