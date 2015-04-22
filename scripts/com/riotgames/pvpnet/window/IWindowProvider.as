package com.riotgames.pvpnet.window
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.ISignal;
   import flash.display.Stage;
   import com.riotgames.pvpnet.window.model.WindowBounds;
   
   public interface IWindowProvider extends IProvider
   {
      
      function getDisplayStateChange() : ISignal;
      
      function getTransparentWindowStage() : Stage;
      
      function restore() : void;
      
      function setVisibility(param1:Boolean) : void;
      
      function minimize() : void;
      
      function maximize() : void;
      
      function fullScreen() : void;
      
      function exitFullScreen() : void;
      
      function getExiting() : ISignal;
      
      function getExited() : ISignal;
      
      function exit() : void;
      
      function notify(param1:String = null) : void;
      
      function center(param1:Boolean = false) : void;
      
      function getWindowBounds() : WindowBounds;
      
      function getFrameRate() : Number;
      
      function setFrameRate(param1:Number) : void;
      
      function hideAirClient() : void;
      
      function showAirClient() : void;
   }
}
