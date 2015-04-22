package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.context.IContext;
   
   public interface ILoginProvider extends IProvider
   {
      
      function createLoginModule(param1:IContext) : IMainScreen;
   }
}
