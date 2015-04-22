package com.riotgames.pvpnet.profilehovercard
{
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.proxy.ProxyObject;
   import blix.assets.proxy.InteractiveObjectProxy;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   import com.riotgames.pvpnet.tips.config.ToolTipConfig;
   import flash.display.InteractiveObject;
   
   public class IProfileHoverCardProvider_proxy extends Object implements IProxyObject, IProfileHoverCardProvider
   {
      
      private var __proxy:ProxyObject;
      
      public function IProfileHoverCardProvider_proxy()
      {
         this.__proxy = new ProxyObject();
         super();
      }
      
      public function __setTarget(param1:Object) : void
      {
         this.__proxy.__setTarget(param1);
      }
      
      public function assignHovercardTooltipByBuddy(param1:InteractiveObjectProxy, param2:Buddy, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void
      {
         var _loc6_:* = null;
         _loc6_ = this.__proxy.__methodInvoke("assignHovercardTooltipByBuddy",[param1,param2,param3,param4,param5],_loc6_);
      }
      
      public function assignHovercardTooltipBySummonerName(param1:InteractiveObjectProxy, param2:String, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void
      {
         var _loc6_:* = null;
         _loc6_ = this.__proxy.__methodInvoke("assignHovercardTooltipBySummonerName",[param1,param2,param3,param4,param5],_loc6_);
      }
      
      public function assignHovercardTooltipBySuggestedPlayer(param1:InteractiveObjectProxy, param2:Object, param3:ToolTipConfig = null, param4:String = null, param5:InteractiveObject = null) : void
      {
         var _loc6_:* = null;
         _loc6_ = this.__proxy.__methodInvoke("assignHovercardTooltipBySuggestedPlayer",[param1,param2,param3,param4,param5],_loc6_);
      }
      
      public function unassignHovercardTooltip(param1:InteractiveObjectProxy) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("unassignHovercardTooltip",[param1],_loc2_);
      }
      
      public function proxyHovercardTooltipByBuddy(param1:InteractiveObject, param2:Buddy, param3:ToolTipConfig = null, param4:String = null) : void
      {
         var _loc5_:* = null;
         _loc5_ = this.__proxy.__methodInvoke("proxyHovercardTooltipByBuddy",[param1,param2,param3,param4],_loc5_);
      }
      
      public function proxyHovercardTooltipBySummonerName(param1:InteractiveObject, param2:String, param3:ToolTipConfig = null, param4:String = null) : void
      {
         var _loc5_:* = null;
         _loc5_ = this.__proxy.__methodInvoke("proxyHovercardTooltipBySummonerName",[param1,param2,param3,param4],_loc5_);
      }
      
      public function proxyHovercardTooltipBySuggestedPlayer(param1:InteractiveObject, param2:Object, param3:ToolTipConfig = null, param4:String = null) : void
      {
         var _loc5_:* = null;
         _loc5_ = this.__proxy.__methodInvoke("proxyHovercardTooltipBySuggestedPlayer",[param1,param2,param3,param4],_loc5_);
      }
      
      public function unassignHovercardTooltipProxy(param1:InteractiveObject) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("unassignHovercardTooltipProxy",[param1],_loc2_);
      }
      
      public function registerInjection(param1:*, param2:String, param3:Function, param4:Function) : void
      {
         var _loc5_:* = null;
         _loc5_ = this.__proxy.__methodInvoke("registerInjection",[param1,param2,param3,param4],_loc5_);
      }
      
      public function deregisterInjection(param1:*) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("deregisterInjection",[param1],_loc2_);
      }
   }
}
