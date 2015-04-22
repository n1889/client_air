package com.riotgames.platform.provider
{
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.riotgames.platform.proxy.IProxyObject;
   import com.riotgames.platform.proxy.ProxyFactory;
   
   public class ProviderLookup extends Object
   {
      
      private static var proxies:Dictionary = new Dictionary();
      
      private static var _instance:IProviderLookup;
      
      public function ProviderLookup()
      {
         super();
      }
      
      public static function publishProvider(param1:Class, param2:IProvider) : void
      {
         if(!(param2 is param1))
         {
            throw new Error("The provider instance is not the type of the interface.");
         }
         else
         {
            var _loc3_:String = getQualifiedClassName(param1);
            instance.publishProvider(_loc3_,param2);
            return;
         }
      }
      
      public static function getProvider(param1:Class, param2:Function = null, param3:Function = null) : void
      {
         var _loc4_:String = getQualifiedClassName(param1);
         if(param2 != null)
         {
            instance.getSpecificProviderPublished(_loc4_).add(param2);
         }
         if(param3 != null)
         {
            instance.getSpecificProviderFailed(_loc4_).add(param3);
         }
         instance.requestProvider(_loc4_);
      }
      
      public static function getProviderProxy(param1:Class) : *
      {
         var proxy:IProxyObject = null;
         var providerInterface:Class = param1;
         var providerId:String = getQualifiedClassName(providerInterface);
         if(providerId in proxies)
         {
            return proxies[providerId];
         }
         proxy = ProxyFactory.createProxy(providerInterface);
         proxies[providerId] = proxy;
         instance.getSpecificProviderPublished(providerId).add(function(param1:IProvider):void
         {
            proxy.__setTarget(param1);
         });
         instance.requestProvider(providerId);
         return proxy;
      }
      
      static function setProviderProxy(param1:Class, param2:*) : void
      {
         var _loc3_:String = getQualifiedClassName(param1);
         proxies[_loc3_] = param2;
      }
      
      public static function registerImpl(param1:IProviderLookup) : void
      {
         _instance = param1;
      }
      
      public static function get instance() : IProviderLookup
      {
         if(!_instance)
         {
            throw new Error("The provider lookup implementation must be registered through ProviderLookup.registerImpl");
         }
         else
         {
            return _instance;
         }
      }
   }
}
