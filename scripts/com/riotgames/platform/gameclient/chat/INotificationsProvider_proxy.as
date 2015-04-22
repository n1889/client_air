package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.gameclient.chat.domain.DockedPrompt;
   import blix.signals.ISignal;
   import com.riotgames.platform.proxy.ProxyFactory;
   import com.riotgames.platform.proxy.ProxyObject;
   
   public class INotificationsProvider_proxy extends Object implements IProxyObject, INotificationsProvider
   {
      
      private var __proxy:ProxyObject;
      
      public function INotificationsProvider_proxy()
      {
         this.__proxy = new ProxyObject();
         super();
      }
      
      public function showDockedPrompt(param1:DockedPrompt) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("showDockedPrompt",[param1],_loc2_);
      }
      
      public function getNotificationsChanged() : ISignal
      {
         var _loc1_:* = ProxyFactory.createProxy(ISignal);
         _loc1_ = this.__proxy.__methodInvoke("getNotificationsChanged",[],_loc1_);
         return _loc1_ as ISignal;
      }
      
      public function getNotificationRemoved() : ISignal
      {
         var _loc1_:* = ProxyFactory.createProxy(ISignal);
         _loc1_ = this.__proxy.__methodInvoke("getNotificationRemoved",[],_loc1_);
         return _loc1_ as ISignal;
      }
      
      public function removeNotification(param1:DockedPrompt, param2:String, param3:String = null, param4:Boolean = true) : void
      {
         var _loc5_:* = null;
         _loc5_ = this.__proxy.__methodInvoke("removeNotification",[param1,param2,param3,param4],_loc5_);
      }
      
      public function getNotifications() : Vector.<DockedPrompt>
      {
         var _loc1_:* = null;
         _loc1_ = this.__proxy.__methodInvoke("getNotifications",[],_loc1_);
         return _loc1_ as Vector.<DockedPrompt>;
      }
      
      public function __setTarget(param1:Object) : void
      {
         this.__proxy.__setTarget(param1);
      }
      
      public function getNotificationAdded() : ISignal
      {
         var _loc1_:* = ProxyFactory.createProxy(ISignal);
         _loc1_ = this.__proxy.__methodInvoke("getNotificationAdded",[],_loc1_);
         return _loc1_ as ISignal;
      }
   }
}
