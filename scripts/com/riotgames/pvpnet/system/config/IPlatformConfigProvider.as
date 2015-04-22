package com.riotgames.pvpnet.system.config
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.systemstates.ClientSystemStatesNotification;
   
   public interface IPlatformConfigProvider extends IProvider
   {
      
      function initializePlatformConfigMonitoring() : void;
      
      function updatePlatformConfig(param1:ClientSystemStatesNotification) : void;
      
      function getPlatformConfig() : PlatformConfig;
   }
}
