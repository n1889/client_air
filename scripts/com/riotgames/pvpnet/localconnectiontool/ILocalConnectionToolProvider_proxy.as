package com.riotgames.pvpnet.localconnectiontool
{
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.proxy.ProxyObject;
   
   public class ILocalConnectionToolProvider_proxy extends Object implements IProxyObject, ILocalConnectionToolProvider
   {
      
      private var __proxy:ProxyObject;
      
      public function ILocalConnectionToolProvider_proxy()
      {
         this.__proxy = new ProxyObject();
         super();
      }
      
      public function __setTarget(param1:Object) : void
      {
         this.__proxy.__setTarget(param1);
      }
   }
}
