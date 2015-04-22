package com.riotgames.pvpnet.runes
{
   import com.riotgames.platform.common.profile.IOldProfileScreenProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.context.IContext;
   
   public interface IRunesProvider extends IOldProfileScreenProvider
   {
      
      function getRunesScreen(param1:IContext) : IMainScreen;
   }
}
