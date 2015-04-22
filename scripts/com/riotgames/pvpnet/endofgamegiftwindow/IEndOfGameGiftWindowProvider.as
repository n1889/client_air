package com.riotgames.pvpnet.endofgamegiftwindow
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.common.view.IMainScreen;
   import com.riotgames.pvpnet.endofgamegiftwindow.controllers.IEndOfGameGiftWindowController;
   import blix.context.IContext;
   
   public interface IEndOfGameGiftWindowProvider extends IProvider, IMainScreen, IEndOfGameGiftWindowController
   {
      
      function initializeEndOfGameGiftWindow(param1:IContext, param2:String) : void;
   }
}
