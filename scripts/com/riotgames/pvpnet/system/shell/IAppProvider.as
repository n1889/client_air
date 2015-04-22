package com.riotgames.pvpnet.system.shell
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.common.IAppController;
   
   public interface IAppProvider extends IProvider
   {
      
      function get appController() : IAppController;
   }
}
