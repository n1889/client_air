package com.riotgames.pvpnet.itembrowser
{
   import com.riotgames.platform.common.profile.IOldProfileScreenProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.context.IContext;
   
   public interface IItemBrowserProvider extends IOldProfileScreenProvider
   {
      
      function getItemBrowserScreen(param1:IContext) : IMainScreen;
   }
}
