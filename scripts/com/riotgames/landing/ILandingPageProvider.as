package com.riotgames.landing
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.context.IContext;
   
   public interface ILandingPageProvider extends IProvider
   {
      
      function createLandingPage(param1:IContext) : IMainScreen;
   }
}
