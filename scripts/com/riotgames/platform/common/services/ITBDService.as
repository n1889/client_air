package com.riotgames.platform.common.services
{
   import com.riotgames.platform.common.services.lcdsproxy.ILcdsProxyServiceMessenger;
   import blix.signals.ISignal;
   
   public interface ITBDService extends ILcdsProxyServiceMessenger
   {
      
      function get timeout() : ISignal;
   }
}
