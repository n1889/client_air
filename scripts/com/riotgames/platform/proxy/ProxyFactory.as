package com.riotgames.platform.proxy
{
   import flash.system.ApplicationDomain;
   import flash.utils.getQualifiedClassName;
   import flash.utils.describeType;
   
   public class ProxyFactory extends Object
   {
      
      public function ProxyFactory()
      {
         super();
      }
      
      public static function hasProxy(param1:Class, param2:ApplicationDomain = null) : Boolean
      {
         if(param2 == null)
         {
            var param2:ApplicationDomain = ApplicationDomain.currentDomain;
         }
         var _loc3_:String = getQualifiedClassName(param1);
         return param2.hasDefinition(_loc3_ + "_proxy");
      }
      
      public static function createProxy(param1:Class, param2:ApplicationDomain = null) : *
      {
         var describeTypeXml:XML = null;
         var proxyClass:Class = null;
         var clazz:Class = param1;
         var applicationDomain:ApplicationDomain = param2;
         if(applicationDomain == null)
         {
            applicationDomain = ApplicationDomain.currentDomain;
         }
         var className:String = getQualifiedClassName(clazz);
         if(!applicationDomain.hasDefinition(className + "_proxy"))
         {
            describeTypeXml = describeType(clazz);
            if(describeTypeXml.factory.metadata.(@name == "GenerateProxy").length() == 0)
            {
               throw new Error("Attempted to create a proxy for: " + className + " which did not have the metadata GenerateProxy.");
            }
            else
            {
               throw new Error("Could not find the proxy for: " + className + ". Make sure the generate-proxies ant target is set up correctly.");
            }
         }
         else
         {
            proxyClass = applicationDomain.getDefinition(className + "_proxy") as Class;
            return new proxyClass();
         }
      }
   }
}
