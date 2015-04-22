package com.riotgames.pvpnet.watch
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.Signal;
   import flash.display.DisplayObjectContainer;
   import blix.context.IContext;
   import com.riotgames.platform.common.view.IMainScreen;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IWatchTabProvider extends IProvider
   {
      
      function isReplayModeChanged() : Signal;
      
      function setContentHolder(param1:DisplayObjectContainer) : void;
      
      function isReplayMode() : Boolean;
      
      function createWatchButton(param1:String, param2:IContext, param3:Number, param4:String, param5:Boolean, param6:Boolean, param7:Boolean) : IWatchReplayButton;
      
      function isEnabled() : Boolean;
      
      function getWatchTabScreen(param1:IContext) : IMainScreen;
      
      function getDragOverlayAsset(param1:DisplayAdapter) : void;
      
      function acceptDragDrop() : Boolean;
      
      function setNavHolder(param1:DisplayObjectContainer) : void;
   }
}
