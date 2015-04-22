package com.riotgames.platform.gameclient.chat.controllers
{
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderLinkStatusDto;
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderStatusDto;
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderContactInfoDto;
   import mx.logging.ILogger;
   import com.riotgames.platform.common.session.Session;
   import mx.utils.StringUtil;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.domain.PublicSummoner;
   import com.riotgames.platform.common.services.ServiceProxy;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import com.riotgames.util.json.jsonEncode;
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderContactDetailsDto;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   import com.riotgames.platform.gameclient.chat.config.FriendRecommendationsConfig;
   
   public class FriendRecommendationService extends Object
   {
      
      private static var _instance:FriendRecommendationService;
      
      private static var _logger:ILogger;
      
      private var _statusLoading:Boolean = false;
      
      private var _registrationWatcher:SocialRegistrationWatcher;
      
      private var _detailsUrlTemplate:String;
      
      private var _unlinkUrlConfigurationModel:ConfigurationModel;
      
      private var _status:RecofrienderStatusDto;
      
      private var _enabledPercentConfigurationModel:ConfigurationModel;
      
      private var _statusExpiryConfigurationModel:ConfigurationModel;
      
      private var _validConfig:Boolean = false;
      
      private var _contactsUrlTemplateConfigurationModel:ConfigurationModel;
      
      private var _statusFetchSignal:Signal;
      
      private var _linkStatusSignal:Signal;
      
      private var _recoRequester:RecofrienderRequester;
      
      private var _enabledPercent:Number;
      
      private var _statusChangedSignal:Signal;
      
      private var _unlinkUrlTemplate:String;
      
      private var _detailsUrlTemplateConfigurationModel:ConfigurationModel;
      
      private var _statusExpireTime:Date;
      
      private var _contactsUrlTemplate:String;
      
      public function FriendRecommendationService(param1:SingletonLock)
      {
         this._statusFetchSignal = new Signal();
         this._statusChangedSignal = new Signal();
         this._linkStatusSignal = new Signal();
         this._statusExpireTime = new Date(0,0);
         super();
         _logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         if(param1)
         {
            this._statusExpiryConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.STATUS_EXPIRY_CONFIG,FriendRecommendationsConfig.STATUS_EXPIRY_DEFAULT,this.setRuntimeConfiguration);
            this._contactsUrlTemplateConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.GET_CONTACTS_CONFIG,FriendRecommendationsConfig.GET_CONTACTS_DEFAULT,this.setRuntimeConfiguration);
            this._detailsUrlTemplateConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.CONTACT_DETAILS_URL_CONFIG,FriendRecommendationsConfig.CONTACT_DETAILS_URL_DEFAULT,this.setRuntimeConfiguration);
            this._unlinkUrlConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.UNLINK_URL_CONFIG,FriendRecommendationsConfig.UNLINK_URL_DEFAULT,this.setRuntimeConfiguration);
            this._enabledPercentConfigurationModel = FriendRecommendationsConfig.getConfigModel(FriendRecommendationsConfig.ENABLED_PERCENT_CONFIG,FriendRecommendationsConfig.ENABLED_PERCENT_DEFAULT,this.setRuntimeConfiguration);
            this.setRuntimeConfiguration();
            if(this.isEnabled())
            {
               this._recoRequester = new RecofrienderRequester();
               this._registrationWatcher = new SocialRegistrationWatcher(this);
               this.getContacts();
            }
         }
         else
         {
            _logger.error("You should only have one instance of FriendRecommendationManager");
            trace("You should only have one instance of FriendRecommendationManager");
         }
      }
      
      private static function forwardLinkStatus(param1:RecofrienderStatusDto) : Vector.<RecofrienderLinkStatusDto>
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.getLinked();
      }
      
      public static function instance() : FriendRecommendationService
      {
         if(!_instance)
         {
            _instance = new FriendRecommendationService(new SingletonLock());
         }
         return _instance;
      }
      
      private static function forwardContacts(param1:RecofrienderStatusDto) : Vector.<RecofrienderContactInfoDto>
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.getContacts();
      }
      
      private function setRuntimeConfiguration() : void
      {
         this._contactsUrlTemplate = this._contactsUrlTemplateConfigurationModel.getString();
         this._detailsUrlTemplate = this._detailsUrlTemplateConfigurationModel.getString();
         this._unlinkUrlTemplate = this._unlinkUrlConfigurationModel.getString();
         this._enabledPercent = this._enabledPercentConfigurationModel.getNumber();
         if(this._enabledPercent)
         {
            if((!this._contactsUrlTemplate) || (!this._detailsUrlTemplate) || (this._enabledPercent < 0) || (this._enabledPercent > 100))
            {
               this._validConfig = false;
               trace("runtime configuration is incorrect, url templates are invalid");
               trace("  contacts: " + this._contactsUrlTemplate == null?"<null>":this._contactsUrlTemplate);
               trace("  details: " + this._detailsUrlTemplate == null?"<null>":this._detailsUrlTemplate);
               trace("  enabled percent: " + this._enabledPercent);
            }
            else
            {
               this._validConfig = true;
            }
         }
      }
      
      public function getLinkStatus(param1:Function = null, param2:Object = null) : void
      {
         this.getStatus(param1,param2,forwardLinkStatus);
      }
      
      private function getStatusRequest(param1:Function) : void
      {
         var _loc2_:Number = Session.instance.accountSummary.accountId;
         var _loc3_:String = StringUtil.substitute(this._contactsUrlTemplate,ClientConfig.instance.platformId,_loc2_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc4_.method = URLRequestMethod.GET;
         param1(_loc4_);
      }
      
      public function getSummonerFriend(param1:Number) : RecofrienderContactInfoDto
      {
         var friendSummonerId:Number = param1;
         if((!friendSummonerId) || (!this.isEnabled()) || (this._status == null))
         {
            return null;
         }
         var retval:RecofrienderContactInfoDto = null;
         this._status.contacts.forEach(function(param1:RecofrienderContactInfoDto, param2:*, param3:*):void
         {
            if(param1.summonerId == friendSummonerId)
            {
               retval = param1;
            }
         });
         return retval;
      }
      
      public function getTags(param1:Function = null, param2:Object = null) : void
      {
         var cb:Function = param1;
         var that:Object = param2;
         this.getStatus(cb,that,function(param1:RecofrienderStatusDto):Object
         {
            if(param1 == null)
            {
               return null;
            }
            return param1.getTags();
         });
      }
      
      private function unlinkAccountRequest(param1:Function) : void
      {
         var _loc2_:Number = Session.instance.accountSummary.accountId;
         var _loc3_:String = StringUtil.substitute(this._unlinkUrlTemplate,ClientConfig.instance.platformId,_loc2_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         _loc4_.method = URLRequestMethod.POST;
         _loc4_.contentType = "application/json";
         param1(_loc4_);
      }
      
      public function unlinkAccount(param1:Function) : void
      {
         var callback:Function = param1;
         if(!this.callbackErrorIfNotEnabled(null,callback))
         {
            return;
         }
         this._recoRequester.request(this.unlinkAccountRequest,function(param1:Error, param2:Object):void
         {
            if(param1 == null)
            {
               _statusChangedSignal.dispatch(_status,null);
               _status = null;
            }
            callback(param1);
         });
      }
      
      private function updateStatus(param1:Error, param2:Object) : void
      {
         var _loc3_:RecofrienderStatusDto = null;
         if(this._statusLoading)
         {
            if(param1)
            {
               trace("Error: ",param1);
               return;
            }
            this._statusLoading = false;
            _loc3_ = this._status;
            this._statusExpireTime.setTime(new Date().getTime() + this._statusExpiryConfigurationModel.getNumber());
            this._status = RecofrienderStatusDto.buildFromJson(param2);
            this._statusChangedSignal.dispatch(_loc3_,this._status);
            this.notifyIfLinkChanged(_loc3_,this._status);
         }
      }
      
      public function getAssociationUrl(param1:Function) : void
      {
         this._registrationWatcher.followRegistrationRedirect(param1);
      }
      
      public function getContactDetailsFromSummoner(param1:Number, param2:String, param3:Function, param4:Object) : void
      {
         var onSummonerName:Function = null;
         var summonerId:Number = param1;
         var summonerName:String = param2;
         var cb:Function = param3;
         var that:Object = param4;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         var contactInfoDto:RecofrienderContactInfoDto = this.getSummonerFriend(summonerId);
         if(contactInfoDto != null)
         {
            this.getContactDetails(contactInfoDto.source,contactInfoDto.platformId,contactInfoDto.accountId,cb,that);
         }
         else if(summonerName)
         {
            onSummonerName = function(param1:ResultEvent):void
            {
               var _loc2_:PublicSummoner = param1.result as PublicSummoner;
               if(_loc2_ != null)
               {
                  getContactDetailsFromAcct(_loc2_.acctId,cb,that);
               }
               else
               {
                  cb.call(that,new Error("Summoner was not known by service"),null);
               }
            };
            ServiceProxy.instance.summonerService.getSummonerByName(summonerName,onSummonerName,null);
         }
         else
         {
            cb.call(that,new Error("No valid summonerId or summonerName provided"),null);
         }
         
      }
      
      private function notifyIfLinkChanged(param1:RecofrienderStatusDto, param2:RecofrienderStatusDto) : void
      {
         var different:Boolean = false;
         var oldStatus:RecofrienderStatusDto = param1;
         var status:RecofrienderStatusDto = param2;
         if((oldStatus == null) || (!(status.getLinked() === oldStatus.getLinked())))
         {
            different = oldStatus == null;
            if(oldStatus != null)
            {
               status.getLinked().forEach(function(param1:RecofrienderLinkStatusDto, param2:int, param3:Vector.<*>):void
               {
                  var linkStatus:RecofrienderLinkStatusDto = param1;
                  var index:int = param2;
                  var arr:Vector.<*> = param3;
                  var findThisElem:Boolean = false;
                  oldStatus.getLinked().forEach(function(param1:RecofrienderLinkStatusDto, param2:int, param3:Vector.<*>):void
                  {
                     if(param1.equals(linkStatus))
                     {
                        findThisElem = true;
                     }
                  });
                  if(!findThisElem)
                  {
                     different = true;
                  }
               });
            }
            if(different)
            {
               this._linkStatusSignal.dispatch(status.getLinked());
            }
         }
      }
      
      public function isEnabled() : Boolean
      {
         var _loc1_:Number = Session.instance.accountSummary.accountId % 100;
         return (this._validConfig) && (_loc1_ < this._enabledPercent);
      }
      
      public function get statusChangedSignal() : ISignal
      {
         return this._statusChangedSignal;
      }
      
      public function getContacts(param1:Function = null, param2:Object = null) : void
      {
         this.getStatus(param1,param2,forwardContacts);
      }
      
      private function callbackErrorIfNotEnabled(param1:*, param2:Function) : Boolean
      {
         if(!this.isEnabled())
         {
            param2.call(param1,new Error("Recof not enabled"),null);
            return false;
         }
         return true;
      }
      
      private function putStatusRequest(param1:RecofrienderContactInfoDto, param2:Object) : Function
      {
         var contact:RecofrienderContactInfoDto = param1;
         var tags:Object = param2;
         return function(param1:Function):void
         {
            var _loc2_:* = Session.instance.accountSummary.accountId;
            var _loc3_:* = ClientConfig.instance.platformId;
            var _loc4_:* = StringUtil.substitute(_contactsUrlTemplate,_loc3_,_loc2_);
            var _loc5_:* = new RecofrienderStatusDto();
            _loc5_.accountId = _loc2_;
            _loc5_.platformId = _loc3_;
            _loc5_.contacts = new Vector.<RecofrienderContactInfoDto>();
            _loc5_.tags = tags;
            if(contact != null)
            {
               _loc5_.contacts.push(contact);
            }
            var _loc6_:* = jsonEncode(_loc5_);
            var _loc7_:* = new URLRequest(_loc4_);
            _loc7_.method = URLRequestMethod.PUT;
            _loc7_.data = _loc6_;
            _loc7_.contentType = "application/json";
            param1(_loc7_);
         };
      }
      
      public function setTag(param1:String, param2:Boolean, param3:Function = null, param4:Object = null) : void
      {
         var key:String = param1;
         var val:Boolean = param2;
         var cb:Function = param3;
         var that:Object = param4;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         var map:Object = {};
         map[key] = val;
         this._recoRequester.request(this.putStatusRequest(null,map),function(param1:Error, param2:Object):void
         {
            updateStatus(param1,param2);
            if(cb != null)
            {
               cb.call(that,param1,_status);
            }
         });
      }
      
      public function get linkStatusSignal() : ISignal
      {
         return this._linkStatusSignal;
      }
      
      private function getDetailsRequest(param1:String, param2:String, param3:Number) : Function
      {
         var source:String = param1;
         var platformId:String = param2;
         var accountId:Number = param3;
         return function(param1:Function):void
         {
            var _loc2_:* = StringUtil.substitute(_detailsUrlTemplate,source,platformId,accountId);
            var _loc3_:* = new URLRequest(_loc2_);
            _loc3_.method = URLRequestMethod.GET;
            param1(_loc3_);
         };
      }
      
      public function setContact(param1:RecofrienderContactInfoDto, param2:Function = null, param3:Object = null) : void
      {
         var contactInfo:RecofrienderContactInfoDto = param1;
         var cb:Function = param2;
         var that:Object = param3;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         this._recoRequester.request(this.putStatusRequest(contactInfo,null),function(param1:Error, param2:Object):void
         {
            updateStatus(param1,param2);
            if(cb != null)
            {
               cb.call(that,param1,_status);
            }
         });
      }
      
      public function getStatus(param1:Function, param2:Object, param3:Function, param4:Boolean = false) : void
      {
         var me:Object = null;
         var cb:Function = param1;
         var that:Object = param2;
         var acc:Function = param3;
         var force:Boolean = param4;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         me = this;
         var callCallback:Function = function():void
         {
            if(cb != null)
            {
               if(acc != null)
               {
                  cb.call(that,null,acc.call(me,_status));
               }
               else
               {
                  cb.call(that,null,_status);
               }
            }
         };
         if((!force) && (new Date().getTime() < this._statusExpireTime.getTime()))
         {
            callCallback();
         }
         else
         {
            this._statusFetchSignal.addOnce(function(param1:Error, param2:Object):void
            {
               updateStatus(param1,param2);
               callCallback();
            });
            if(!this._statusLoading)
            {
               this._statusLoading = true;
               this._recoRequester.requestWithSignal(this.getStatusRequest,this._statusFetchSignal);
            }
         }
      }
      
      public function getContactDetailsFromAcct(param1:Number, param2:Function, param3:Object) : void
      {
         var accountId:Number = param1;
         var cb:Function = param2;
         var that:Object = param3;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         var onStatus:Function = function(param1:Error, param2:RecofrienderStatusDto):void
         {
            var source:String = null;
            var error:Error = param1;
            var status:RecofrienderStatusDto = param2;
            if(error == null)
            {
               source = null;
               status.linked.forEach(function(param1:RecofrienderLinkStatusDto, param2:*, param3:*):void
               {
                  if(param1.getLinked())
                  {
                     source = param1.getName();
                  }
               });
               if(source != null)
               {
                  getContactDetails(source,ClientConfig.instance.platformId,accountId,cb,that);
               }
               else
               {
                  cb.call(that,new Error("Not Linked"),null);
               }
            }
            else
            {
               cb.call(that,error,null);
            }
         };
         this.getStatus(onStatus,this,null);
      }
      
      public function getContactDetails(param1:String, param2:String, param3:Number, param4:Function, param5:Object) : void
      {
         var source:String = param1;
         var platformId:String = param2;
         var accountId:Number = param3;
         var cb:Function = param4;
         var that:Object = param5;
         if(!this.callbackErrorIfNotEnabled(that,cb))
         {
            return;
         }
         this._recoRequester.request(this.getDetailsRequest(source,platformId,accountId),function(param1:Error, param2:Object):void
         {
            var _loc3_:RecofrienderContactDetailsDto = null;
            if(param1)
            {
               trace("Error: ",param1);
               cb.call(that,param1,null);
            }
            else
            {
               _loc3_ = null;
               if(param2)
               {
                  _loc3_ = RecofrienderContactDetailsDto.buildFromJson(param2);
               }
               cb.call(that,param1,_loc3_);
            }
         });
      }
   }
}

class SingletonLock extends Object
{
   
   function SingletonLock()
   {
      super();
   }
}
