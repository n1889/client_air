package com.riotgames.platform.common.services.lcdsproxy
{
   import com.riotgames.platform.common.utils.decode.IDecode;
   import com.riotgames.platform.common.services.lcdsproxy.responses.LcdsProxyMessageAction;
   import com.riotgames.platform.common.utils.ServiceLogger;
   import mx.logging.ILogger;
   import flash.utils.Dictionary;
   import mx.logging.Log;
   import avmplus.getQualifiedClassName;
   import com.riotgames.platform.common.utils.decode.JSONDecoder;
   
   public class LcdsProxyMessageRouter extends Object implements ILcdsProxyMessageRouter
   {
      
      private var _decoder:IDecode;
      
      private var _logger:ILogger;
      
      private var _reponseMessengerDictionary:Dictionary;
      
      private var _responseActionDictionary:Dictionary;
      
      public function LcdsProxyMessageRouter(param1:IDecode = null)
      {
         this._logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this._decoder = param1 == null?new JSONDecoder():param1;
         this._responseActionDictionary = new Dictionary();
         this._reponseMessengerDictionary = new Dictionary();
      }
      
      public function removeServiceCallListener(param1:String) : void
      {
         var _loc2_:ILcdsProxyServiceMessenger = this._reponseMessengerDictionary[param1];
         if(_loc2_ != null)
         {
            delete this._reponseMessengerDictionary[param1];
            true;
         }
      }
      
      public function onMessageReceived(param1:String) : void
      {
         var _loc2_:Object = this._decoder.decode(param1);
         var _loc3_:String = LcdsProxyMessageAction.getMessageId(_loc2_);
         var _loc4_:String = LcdsProxyMessageAction.getServiceName(_loc2_);
         var _loc5_:String = LcdsProxyMessageAction.getPayload(_loc2_);
         var _loc6_:String = LcdsProxyMessageAction.getMethodName(_loc2_);
         var _loc7_:String = LcdsProxyMessageAction.getStatus(_loc2_);
         var _loc8_:ILcdsProxyServiceMessenger = this._reponseMessengerDictionary[_loc4_];
         if(_loc8_ != null)
         {
            _loc8_.onMessageReceived(_loc3_,_loc7_,_loc5_,_loc6_);
         }
         ServiceLogger.response(_loc4_,_loc6_,_loc2_);
      }
      
      public function setServiceCallListener(param1:String, param2:ILcdsProxyServiceMessenger) : void
      {
         if((param1 == null) || (param1 == ""))
         {
            throw new Error("Unable to add command with no provided service name.");
         }
         else if(param2 == null)
         {
            throw new Error("Unable to add listener - no listener provided.");
         }
         else
         {
            this._reponseMessengerDictionary[param1] = param2;
            return;
         }
         
      }
   }
}
