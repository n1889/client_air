package com.riotgames.pvpnet.system.alerter
{
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.proxy.ProxyObject;
   import blix.action.IAction;
   
   public class IAlerterProvider_proxy extends Object implements IProxyObject, IAlerterProvider
   {
      
      private var __proxy:ProxyObject;
      
      public function IAlerterProvider_proxy()
      {
         this.__proxy = new ProxyObject();
         super();
      }
      
      public function __setTarget(param1:Object) : void
      {
         this.__proxy.__setTarget(param1);
      }
      
      public function addAlert(param1:IAction) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("addAlert",[param1],_loc2_);
      }
      
      public function removeAlert(param1:IAction) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("removeAlert",[param1],_loc2_);
      }
      
      public function getActiveAlerts() : Vector.<IAction>
      {
         var _loc1_:* = null;
         _loc1_ = this.__proxy.__methodInvoke("getActiveAlerts",[],_loc1_);
         return _loc1_ as Vector.<IAction>;
      }
      
      public function getAllAlerts() : Vector.<IAction>
      {
         var _loc1_:* = null;
         _loc1_ = this.__proxy.__methodInvoke("getAllAlerts",[],_loc1_);
         return _loc1_ as Vector.<IAction>;
      }
   }
}
