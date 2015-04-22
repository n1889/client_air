package com.riotgames.platform.gameclient.module.login.controller
{
   import com.riotgames.platform.common.services.login.queue.LoginQueueState;
   import com.riotgames.platform.common.services.login.queue.AuthResult;
   import com.riotgames.platform.common.event.LoginQueueEvent;
   import com.riotgames.platform.common.session.Session;
   import com.riotgames.pvpnet.tracking.trackers.login.ILoginProcessTracker;
   import mx.logging.ILogger;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.util.json.jsonDecode;
   import com.riotgames.util.json.jsonEncode;
   import flash.utils.setTimeout;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LoginQueueController extends Object
   {
      
      public static var MAX_POSITION:int = 9000;
      
      private static const RETRY_WINDOW:Number = 3000;
      
      public static const FAIL_UNKNOWN:String = "unknown";
      
      public static const FAIL_SERVER_FULL:String = "server_full";
      
      private static const PESSIMISM_FACTOR:Number = 0.3;
      
      public static const FAIL_INACTIVE:String = "account_inactive";
      
      public static const FAIL_INVALID:String = "invalid_credentials";
      
      private static const PESSIMISTIC_THRESHOLD:int = 1000;
      
      public static const FAIL_BANNED:String = "account_banned";
      
      private var model:LoginQueueState;
      
      public var inQueue:Boolean;
      
      private var loginTracker:ILoginProcessTracker;
      
      private var logger:ILogger;
      
      private var authToken:String;
      
      public var serviceProxy:ServiceProxy;
      
      public function LoginQueueController(param1:ILoginProcessTracker = null)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this.serviceProxy = ServiceProxy.instance;
         super();
         this.loginTracker = param1;
      }
      
      private function initializeQueueDepth(param1:LoginQueueState) : void
      {
         var _loc2_:int = param1.getDepth();
         var _loc3_:int = param1.loginsPerSecond * param1.publishDelay / 1000 - 1;
         if(_loc2_ < _loc3_)
         {
            param1.queueDepth = _loc3_ - _loc2_;
         }
         if((param1.isCapped) && (param1.getDepth() > PESSIMISTIC_THRESHOLD))
         {
            param1.loginsPerSecond = Math.max(param1.loginsPerSecond * PESSIMISM_FACTOR,1);
         }
      }
      
      private function pollForAuthToken(param1:String, param2:Function, param3:Function, param4:int) : void
      {
         var username:String = param1;
         var onSuccess:Function = param2;
         var onFailure:Function = param3;
         var triesLeft:int = param4;
         var success:Function = function(param1:String):void
         {
            onAuthTokenReceived(param1,username,onSuccess,onFailure,triesLeft);
         };
         var failure:Function = function(param1:Object):void
         {
            onAuthTokenReceived(null,username,onSuccess,onFailure,triesLeft);
         };
         this.serviceProxy.authService.getAuthToken(this.authToken,success,failure);
      }
      
      private function onAuthResponse(param1:AuthResult, param2:Function, param3:Function, param4:Function, param5:Function) : void
      {
         var dataModel:LoginQueueState = null;
         var result:AuthResult = param1;
         var authSuccess:Function = param2;
         var authFailure:Function = param3;
         var queueUpdater:Function = param4;
         var inGameHandler:Function = param5;
         this.inQueue = false;
         Session.instance.userToken = result.lqt;
         Session.instance.gasToken = result.gasToken;
         Session.instance.idToken = result.idToken;
         if((result.status == AuthResult.BUSY_STATUS) || (result.status == AuthResult.FAILED_STATUS) || (result.status == AuthResult.ARL_STATUS))
         {
            this.logger.error("Queue status failure: " + result.status);
            authFailure(result);
            return;
         }
         this.authToken = result.lqt;
         if(result.status == AuthResult.LOGIN_STATUS)
         {
            this.logger.warn("LoginFlow: Queue success, proceed to login");
            authSuccess(result.lqt,result.username);
            return;
         }
         this.logger.warn("LoginFlow: Queue state detected");
         if((!(result.inGameCredentials == null)) && (result.inGameCredentials.inGame == true) && (!(inGameHandler == null)))
         {
            this.logger.warn("LoginFlow: Queue state detected while in game");
            inGameHandler(result.inGameCredentials);
         }
         this.inQueue = true;
         dataModel = result.queueState;
         MAX_POSITION = result.vcap;
         dataModel.isCapped = result.reason == FAIL_SERVER_FULL;
         this.initializeQueueDepth(dataModel);
         this.model = dataModel;
         var handler:Function = function(param1:LoginQueueEvent):void
         {
            handleQueueStatusChange(dataModel,param1,result.username,authSuccess,authFailure,queueUpdater);
         };
         var onDisconnect:Function = function(param1:Object):void
         {
            onStatusDisconnect(param1,authFailure);
         };
         this.serviceProxy.authService.listenForStatusChange(dataModel,handler,onDisconnect);
         var event:LoginQueueEvent = dataModel.createStatusEvent(dataModel.getDepth(),this.serviceProxy.authService.getPollInterval());
         handler(event);
         this.loginTracker.joinedQueue(dataModel.getDepth(),dataModel.getEstimatedMillisLeft());
      }
      
      private function handleQueueStatusChange(param1:LoginQueueState, param2:LoginQueueEvent, param3:String, param4:Function, param5:Function, param6:Function) : void
      {
         if(param2.depth == 0)
         {
            this.serviceProxy.authService.stopListening();
            this.pollForAuthToken(param3,param4,param5,5);
         }
         else
         {
            param6(param2);
         }
      }
      
      private function onStatusDisconnect(param1:Object, param2:Function) : void
      {
         this.logger.error("onStatusDisconnect");
         param2(param1);
         this.inQueue = false;
      }
      
      public function authenticate(param1:String, param2:Function, param3:Function, param4:Function, param5:Function) : void
      {
         var credentials:String = param1;
         var onSuccess:Function = param2;
         var onFailure:Function = param3;
         var queueStatusUpdate:Function = param4;
         var inGameHandler:Function = param5;
         this.inQueue = false;
         var successCallback:Function = function(param1:AuthResult):void
         {
            onAuthResponse(param1,onSuccess,onFailure,queueStatusUpdate,inGameHandler);
         };
         this.serviceProxy.authService.authenticate(credentials,successCallback,onFailure);
      }
      
      public function forcePollUpdate() : void
      {
         this.serviceProxy.authService.forcePoll();
      }
      
      public function cancelQueue(param1:Function) : void
      {
         var callback:Function = param1;
         var cancelCallback:Function = function():void
         {
            onQueueCancelled(callback);
         };
         this.serviceProxy.authService.cancelQueue(this.authToken,cancelCallback,cancelCallback);
      }
      
      private function onAuthTokenReceived(param1:String, param2:String, param3:Function, param4:Function, param5:int) : void
      {
         var _loc6_:Object = null;
         if(param1 == null)
         {
            if(param5 <= 0)
            {
               this.logger.error("token is null, unable to log in");
               param4("Unable to login.");
            }
            else
            {
               this.waitAndFetchAuthToken(param2,param3,param4,RETRY_WINDOW,param5 - 1);
            }
         }
         else
         {
            if(param1.indexOf("lqt") >= 0)
            {
               _loc6_ = jsonDecode(param1);
               if((!(_loc6_ == null)) && (_loc6_.hasOwnProperty("lqt")))
               {
                  var param1:String = jsonEncode(_loc6_.lqt);
               }
            }
            param3(param1,param2);
         }
         this.onQueueExit();
      }
      
      private function waitAndFetchAuthToken(param1:String, param2:Function, param3:Function, param4:Number, param5:int) : void
      {
         var username:String = param1;
         var onSuccess:Function = param2;
         var onFailure:Function = param3;
         var timeout:Number = param4;
         var triesLeft:int = param5;
         var fetcher:Function = function():void
         {
            pollForAuthToken(username,onSuccess,onFailure,triesLeft);
         };
         setTimeout(fetcher,timeout);
      }
      
      private function onQueueExit() : void
      {
         this.inQueue = false;
         this.model = null;
      }
      
      private function onQueueCancelled(param1:Function) : void
      {
         this.serviceProxy.authService.stopListening();
         this.onQueueExit();
         if(param1 != null)
         {
            param1();
         }
      }
   }
}
