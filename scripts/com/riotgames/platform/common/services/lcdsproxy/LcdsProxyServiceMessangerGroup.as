package com.riotgames.platform.common.services.lcdsproxy
{
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.IAsyncLcdsProxyServiceCall;
   import com.riotgames.platform.common.services.lcdsproxy.servicecalls.ILcdsProxyServiceCall;
   
   public class LcdsProxyServiceMessangerGroup extends Object implements ILcdsProxyServiceMessenger, ILcdsProxyMessageHandlerGroup
   {
      
      private var messengerArray:Array;
      
      public function LcdsProxyServiceMessangerGroup()
      {
         super();
         this.messengerArray = [];
      }
      
      public function addMessenger(param1:ILcdsProxyServiceMessenger) : void
      {
         this.messengerArray.push(param1);
      }
      
      public function onMessageReceived(param1:String, param2:String = null, param3:String = null, param4:String = null) : void
      {
         var _loc5_:ILcdsProxyServiceMessenger = null;
         for each(_loc5_ in this.messengerArray)
         {
            _loc5_.onMessageReceived(param1,param2,param3,param4);
         }
      }
      
      public function invokeAsyncProxyServiceWithSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         return null;
      }
      
      public function invokeProxyServiceWithoutSession(param1:ILcdsProxyServiceCall) : String
      {
         return null;
      }
      
      public function invokeProxyServiceWithSession(param1:ILcdsProxyServiceCall) : String
      {
         return null;
      }
      
      public function removeMessenger(param1:ILcdsProxyServiceMessenger) : void
      {
         var _loc3_:ILcdsProxyServiceMessenger = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this.messengerArray)
         {
            if(_loc3_ == param1)
            {
               this.messengerArray.splice(_loc2_,1);
               return;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      
      public function invokeAsyncProxyServiceWithoutSession(param1:IAsyncLcdsProxyServiceCall) : String
      {
         return null;
      }
      
      public function destroy() : void
      {
         this.messengerArray = [];
      }
   }
}
