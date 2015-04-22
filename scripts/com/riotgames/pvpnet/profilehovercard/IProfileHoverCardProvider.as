package com.riotgames.pvpnet.profilehovercard
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.InteractiveObjectProxy;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   import com.riotgames.pvpnet.tips.config.ToolTipConfig;
   import flash.display.InteractiveObject;
   
   public interface IProfileHoverCardProvider extends IProvider
   {
      
      function assignHovercardTooltipByBuddy(param1:InteractiveObjectProxy, param2:Buddy, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void;
      
      function assignHovercardTooltipBySummonerName(param1:InteractiveObjectProxy, param2:String, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void;
      
      function assignHovercardTooltipBySuggestedPlayer(param1:InteractiveObjectProxy, param2:Object, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void;
      
      function unassignHovercardTooltip(param1:InteractiveObjectProxy) : void;
      
      function proxyHovercardTooltipByBuddy(param1:InteractiveObject, param2:Buddy, param3:ToolTipConfig = null, param4:String = null) : void;
      
      function proxyHovercardTooltipBySummonerName(param1:InteractiveObject, param2:String, param3:ToolTipConfig = null, param4:String = null) : void;
      
      function proxyHovercardTooltipBySuggestedPlayer(param1:InteractiveObject, param2:Object, param3:ToolTipConfig = null, param4:String = null) : void;
      
      function unassignHovercardTooltipProxy(param1:InteractiveObject) : void;
      
      function registerInjection(param1:*, param2:String, param3:Function, param4:Function) : void;
      
      function deregisterInjection(param1:*) : void;
   }
}
