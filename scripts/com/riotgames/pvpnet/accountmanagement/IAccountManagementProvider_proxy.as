package com.riotgames.pvpnet.accountmanagement
{
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.proxy.ProxyObject;
   
   public class IAccountManagementProvider_proxy extends Object implements IProxyObject, IAccountManagementProvider
   {
      
      private var __proxy:ProxyObject;
      
      public function IAccountManagementProvider_proxy()
      {
         this.__proxy = new ProxyObject();
         super();
      }
      
      public function __setTarget(param1:Object) : void
      {
         this.__proxy.__setTarget(param1);
      }
      
      public function createEmailVerificationAlert(param1:String) : void
      {
         var _loc2_:* = null;
         _loc2_ = this.__proxy.__methodInvoke("createEmailVerificationAlert",[param1],_loc2_);
      }
   }
}
