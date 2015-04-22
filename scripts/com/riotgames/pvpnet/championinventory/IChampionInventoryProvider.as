package com.riotgames.pvpnet.championinventory
{
   import com.riotgames.platform.common.profile.IOldProfileScreenProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.context.IContext;
   
   public interface IChampionInventoryProvider extends IOldProfileScreenProvider
   {
      
      function getChampionInventoryScreen(param1:IContext) : IMainScreen;
   }
}
