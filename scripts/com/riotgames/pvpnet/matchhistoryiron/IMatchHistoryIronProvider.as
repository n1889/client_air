package com.riotgames.pvpnet.matchhistoryiron
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IMatchHistoryIronProvider extends IProvider
   {
      
      function show(param1:Number, param2:DisplayAdapter) : void;
      
      function hide() : void;
   }
}
