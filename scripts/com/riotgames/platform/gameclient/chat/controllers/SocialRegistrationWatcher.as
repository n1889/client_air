package com.riotgames.platform.gameclient.chat.controllers
{
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderLinkStatusDto;
   import flash.utils.Timer;
   import flash.net.URLRequest;
   import flash.net.URLLoader;
   import com.riotgames.platform.common.session.Session;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import mx.utils.StringUtil;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.events.ErrorEvent;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   import com.riotgames.platform.gameclient.chat.config.FriendRecommendationsConfig;
   
   public class SocialRegistrationWatcher extends Object
   {
      
      private var _registrationUpdate:Number;
      
      private var _registrationUpdateTimer:Timer;
      
      private var _friendRecoManager:FriendRecommendationService;
      
      private var _registrationUrlTemplate:String;
      
      private var _registrationPollDurationTimer:Timer;
      
      private var _validConfig:Boolean;
      
      private var _registering:Boolean = false;
      
      private var _registrationPollDurationConfigurationModel:ConfigurationModel;
      
      private var _registrationPollRateConfigurationModel:ConfigurationModel;
      
      private var _registrationPollDuration:Number;
      
      private var _logger:ILogger;
      
      private var _registrationUrlConfigurationModel:ConfigurationModel;
      
      public function SocialRegistrationWatcher(param1:FriendRecommendationService)
      {
         super();
         this._logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this._registrationPollDurationConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.REGISTER_POLL_DURATION_CONFIG,FriendRecommendationsConfig.REGISTER_POLL_DURATION_DEFAULT,this.setRuntimeConfiguration);
         this._registrationPollRateConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.REGISTER_POLL_RATE_CONFIG,FriendRecommendationsConfig.REGISTER_POLL_RATE_DEFAULT,this.setRuntimeConfiguration);
         this._registrationUrlConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.REGISTER_URL_CONFIG,FriendRecommendationsConfig.REGISTER_URL_DEFAULT,this.setRuntimeConfiguration);
         this.setRuntimeConfiguration();
         if(this._validConfig)
         {
            this._friendRecoManager = param1;
            this._friendRecoManager.statusChangedSignal.add(this.getStatusUpdate,false);
            this._friendRecoManager.linkStatusSignal.add(this.getLinkStatusUpdate);
         }
      }
      
      private function getLinkStatusUpdate(param1:Vector.<RecofrienderLinkStatusDto>) : void
      {
         var links:Vector.<RecofrienderLinkStatusDto> = param1;
         if(this._registering)
         {
            links.forEach(function(param1:RecofrienderLinkStatusDto, param2:int, param3:Vector.<RecofrienderLinkStatusDto>):void
            {
               if(param1.getLinked())
               {
                  stop();
               }
            });
         }
      }
      
      public function followRegistrationRedirect(param1:Function) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:URLRequest = null;
         var _loc7_:URLLoader = null;
         var _loc8_:Error = null;
         if(this._validConfig)
         {
            _loc2_ = Session.instance.idToken;
            this._registering = true;
            if(_loc2_)
            {
               _loc3_ = ClientConfig.instance.locale;
               _loc4_ = _loc3_.substr(0,2);
               _loc5_ = StringUtil.substitute(this._registrationUrlTemplate,_loc4_);
               _loc6_ = new URLRequest(_loc5_);
               _loc6_.requestHeaders.push(new URLRequestHeader("Authorization","JwtBearer " + _loc2_));
               _loc6_.method = URLRequestMethod.GET;
               _loc7_ = new URLLoader();
               _loc7_.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS,this.registrationRequestSuccess(param1));
               _loc7_.addEventListener(IOErrorEvent.IO_ERROR,this.registrationRequestError(param1));
               _loc7_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.registrationRequestError(param1));
               _loc7_.load(_loc6_);
            }
            else
            {
               _loc8_ = new Error("no id token in session");
               this._logger.error("Error while authenticating: " + _loc8_.message);
               param1(_loc8_,null);
            }
         }
         else
         {
            trace("ERROR: social registration watcher has invalid config");
         }
      }
      
      private function setRuntimeConfiguration() : void
      {
         this._registrationUpdate = this._registrationPollRateConfigurationModel.getNumber();
         this._registrationPollDuration = this._registrationPollDurationConfigurationModel.getNumber();
         this._registrationUrlTemplate = this._registrationUrlConfigurationModel.getString();
         this._validConfig = (this._registrationUrlTemplate) && (this._registrationPollDuration) && (this._registrationUpdate);
         if(this._validConfig)
         {
            if(this._registrationUpdateTimer != null)
            {
               this._registrationUpdateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.registrationTimerComplete);
            }
            if(this._registrationPollDurationTimer != null)
            {
               this._registrationUpdateTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.stopPollingForRegister);
            }
            this._registrationUpdateTimer = new Timer(this._registrationUpdate,1);
            this._registrationUpdateTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.registrationTimerComplete);
            this._registrationPollDurationTimer = new Timer(this._registrationPollDuration,1);
            this._registrationPollDurationTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.stopPollingForRegister);
         }
         else
         {
            trace("ERROR: social registration watcher has invalid config");
            trace("poll rate: ",this._registrationUpdate,", poll duration: ",this._registrationPollDuration,", reg URL: ",this._registrationUrlTemplate);
         }
      }
      
      private function stop() : void
      {
         if(this._registering)
         {
            this._registering = false;
            this._registrationUpdateTimer.reset();
            this._registrationPollDurationTimer.reset();
         }
      }
      
      private function getStatusUpdate() : void
      {
         if(this._registering)
         {
            this._registrationUpdateTimer.reset();
            this._registrationUpdateTimer.start();
         }
      }
      
      private function registrationRequestSuccess(param1:Function) : Function
      {
         var callback:Function = param1;
         return function(param1:HTTPStatusEvent):void
         {
            var _loc2_:* = undefined;
            if((param1.status < 300) && (param1.status > 199))
            {
               start();
               _loc2_ = param1.responseURL;
               callback(null,_loc2_);
            }
            else
            {
               callback(new Error("bad status on redirect",param1.status),null);
            }
         };
      }
      
      private function registrationRequestError(param1:Function) : Function
      {
         var callback:Function = param1;
         return function(param1:ErrorEvent):void
         {
            stop();
            callback(new Error(param1.target),null);
         };
      }
      
      private function registrationTimerComplete(param1:TimerEvent) : void
      {
         this._friendRecoManager.getStatus(null,null,null,true);
      }
      
      private function stopPollingForRegister(param1:TimerEvent) : void
      {
         this.stop();
      }
      
      private function start() : void
      {
         if(this._registering)
         {
            this._registrationUpdateTimer.start();
            this._registrationPollDurationTimer.start();
         }
      }
   }
}
