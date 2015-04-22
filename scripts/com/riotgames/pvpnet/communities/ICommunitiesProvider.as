package com.riotgames.pvpnet.communities
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.IDisplayChild;
   import blix.context.IContext;
   
   public interface ICommunitiesProvider extends IProvider
   {
      
      function getCommunitiesView(param1:IContext) : IDisplayChild;
   }
}
