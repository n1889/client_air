package com.riotgames.platform.common.services.lcdsproxy.responses
{
   import blix.action.IAction;
   import blix.IDestructible;
   
   public interface ILcdsProxyMessageAction extends IAction, IDestructible
   {
      
      function set payload(param1:String) : void;
   }
}
