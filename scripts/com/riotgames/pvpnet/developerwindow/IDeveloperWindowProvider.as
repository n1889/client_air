package com.riotgames.pvpnet.developerwindow
{
   import com.riotgames.platform.provider.IProvider;
   import flash.display.DisplayObject;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import com.riotgames.platform.common.session.Session;
   import com.riotgames.pvpnet.system.messaging.ShellDispatcher;
   import com.riotgames.platform.common.services.ServiceProxy;
   
   public interface IDeveloperWindowProvider extends IProvider
   {
      
      function show() : void;
      
      function addInteractiveObjectToTab(param1:String, param2:DisplayObject) : void;
      
      function minimize() : void;
      
      function restore() : void;
      
      function close() : void;
      
      function get clientConfig() : ClientConfig;
      
      function set clientConfig(param1:ClientConfig) : void;
      
      function get session() : Session;
      
      function set session(param1:Session) : void;
      
      function get shellDispatcher() : ShellDispatcher;
      
      function set shellDispatcher(param1:ShellDispatcher) : void;
      
      function get serviceProxy() : ServiceProxy;
      
      function set serviceProxy(param1:ServiceProxy) : void;
      
      function selectTab(param1:String) : void;
   }
}
