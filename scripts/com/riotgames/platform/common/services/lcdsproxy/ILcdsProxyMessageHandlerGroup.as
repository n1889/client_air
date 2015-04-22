package com.riotgames.platform.common.services.lcdsproxy
{
   public interface ILcdsProxyMessageHandlerGroup extends ILcdsProxyServiceMessenger
   {
      
      function addMessenger(param1:ILcdsProxyServiceMessenger) : void;
      
      function removeMessenger(param1:ILcdsProxyServiceMessenger) : void;
   }
}
