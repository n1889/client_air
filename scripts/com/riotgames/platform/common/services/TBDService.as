package com.riotgames.platform.common.services
{
   import blix.signals.ISignal;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.IAsyncLcdsProxyServiceCall;
   import com.riotgames.platform.gameclient.services.IBaseLcdsService;
   import com.riotgames.platform.common.utils.decode.IDecode;
   
   public class TBDService extends CapService implements ITBDService
   {
      
      public function TBDService(param1:IBaseLcdsService, param2:IDecode)
      {
         super(param1,param2);
      }
      
      public function get timeout() : ISignal
      {
         return timeoutSignal;
      }
      
      private function getTimeoutServiceCalls() : Array
      {
         var _loc2_:IAsyncLcdsProxyServiceCall = null;
         var _loc1_:Array = [];
         for each(_loc2_ in callDictionary)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      override protected function signalTimeout() : void
      {
         timeoutSignal.dispatch(this.getTimeoutServiceCalls());
      }
   }
}
