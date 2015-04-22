package com.riotgames.pvpnet.system.alerter
{
   import com.riotgames.platform.provider.IProvider;
   import blix.action.IAction;
   
   public interface IAlerterProvider extends IProvider
   {
      
      function addAlert(param1:IAction) : void;
      
      function removeAlert(param1:IAction) : void;
      
      function getActiveAlerts() : Vector.<IAction>;
      
      function getAllAlerts() : Vector.<IAction>;
   }
}
