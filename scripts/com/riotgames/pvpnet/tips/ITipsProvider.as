package com.riotgames.pvpnet.tips
{
   import com.riotgames.platform.provider.IProvider;
   import blix.components.tooltip.IToolTipManager;
   import blix.assets.proxy.DisplayObjectContainerProxy;
   import com.riotgames.pvpnet.tips.config.ToolTipConfig;
   import blix.assets.proxy.InteractiveObjectProxy;
   import flash.display.Stage;
   import flash.display.InteractiveObject;
   
   public interface ITipsProvider extends IProvider
   {
      
      function createWindowToolTipManager(param1:DisplayObjectContainerProxy, param2:ToolTipConfig = null) : IToolTipManager;
      
      function assignCustomToolTip(param1:InteractiveObjectProxy, param2:*, param3:Class, param4:ToolTipConfig = null) : void;
      
      function registerDeprecatedToolTipManager(param1:Stage, param2:ToolTipConfig = null) : void;
      
      function assignDeprecatedToolTip(param1:InteractiveObject, param2:String) : void;
   }
}
