package com.riotgames.pvpnet.summonerprofile
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface ISummonerProfileContainerProvider extends IProvider
   {
      
      function showProfileContainer(param1:DisplayAdapter) : void;
      
      function hideProfileContainer(param1:DisplayAdapter) : void;
   }
}
