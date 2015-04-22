package com.riotgames.platform.gameclient.chat.controllers
{
   import flash.events.HTTPStatusEvent;
   import mx.logging.ILogger;
   import com.riotgames.platform.common.session.Session;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLLoader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ErrorEvent;
   import blix.signals.Signal;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class RecofrienderRequester extends Object
   {
      
      private static var _logger:ILogger;
      
      public function RecofrienderRequester()
      {
         super();
         _logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
      }
      
      private static function requestStatus(param1:HTTPStatusEvent) : void
      {
         if((param1.status < 200) || (param1.status > 299))
         {
            _logger.error("recofriender returned status: " + param1.status);
            trace("recofriender returned status: " + param1.status);
         }
      }
      
      public function request(param1:Function, param2:Function) : void
      {
         var _loc4_:Error = null;
         var _loc3_:String = Session.instance.idToken;
         if(_loc3_)
         {
            param1(this.handleRequest(_loc3_,param2));
         }
         else
         {
            _loc4_ = new Error("No id token in session");
            trace("Authentication failed: ",_loc4_);
            _logger.error("Authentication failed: " + _loc4_.message);
            param2(_loc4_,null);
         }
      }
      
      private function handleRequest(param1:String, param2:Function) : Function
      {
         var token:String = param1;
         var callback:Function = param2;
         return function(param1:URLRequest):void
         {
            param1.requestHeaders.push(new URLRequestHeader("Authorization","JwtBearer " + token));
            printCurlForRequest(param1);
            var _loc2_:* = new URLLoader();
            _loc2_.addEventListener(Event.COMPLETE,requestComplete(callback));
            _loc2_.addEventListener(IOErrorEvent.IO_ERROR,requestError(callback));
            _loc2_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,requestError(callback));
            _loc2_.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,requestStatus);
            _loc2_.load(param1);
         };
      }
      
      private function requestComplete(param1:Function) : Function
      {
         var callback:Function = param1;
         var callCallback:Function = function(param1:Event):void
         {
            var error:Error = null;
            var dataString:String = null;
            var event:Event = param1;
            error = null;
            var dataObject:Object = null;
            try
            {
               dataString = event.target.data;
               if(dataString.length > 0)
               {
                  dataObject = JSON.parse(dataString);
               }
            }
            catch(er:Error)
            {
               error = er;
               trace("Error parsing recofriender request: ",error);
               _logger.error("Error parsing recofriender request: " + error);
            }
            callback(error,dataObject);
         };
         return callCallback;
      }
      
      private function requestError(param1:Function) : Function
      {
         var callback:Function = param1;
         var callCallback:Function = function(param1:ErrorEvent):void
         {
            trace("Error connecting to recofriender: " + param1.target.data);
            _logger.error("Error connecting to recofriender: " + param1.target.data);
            var _loc2_:Error = new Error("Error " + param1.toString() + " data:" + param1.target.data);
            callback(_loc2_,null);
         };
         return callCallback;
      }
      
      public function requestWithSignal(param1:Function, param2:Signal) : void
      {
         var requestFetch:Function = param1;
         var signal:Signal = param2;
         this.request(requestFetch,function(param1:Error, param2:Object):void
         {
            signal.dispatch(param1,param2);
         });
      }
      
      private function printCurlForRequest(param1:URLRequest) : void
      {
         var curlCmd:String = null;
         var request:URLRequest = param1;
         curlCmd = "curl -S -X " + request.method + " ";
         request.requestHeaders.forEach(function(param1:URLRequestHeader, param2:int, param3:Array):void
         {
            curlCmd = curlCmd + ("-H \'" + param1.name + ": " + param1.value + "\' ");
         });
         if(request.data)
         {
            curlCmd = curlCmd + (" -d \'" + request.data + "\' ");
         }
         curlCmd = curlCmd + request.url;
         trace("requesting at: ",new Date());
         trace(curlCmd);
      }
   }
}
