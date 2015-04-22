package com.riotgames.platform.common.error
{
   import com.riotgames.platform.common.exception.UnexpectedServiceException;
   import com.riotgames.platform.common.exception.ValidationException;
   import com.riotgames.platform.common.exception.PlatformException;
   import mx.rpc.events.FaultEvent;
   
   public class ServerError extends Object
   {
      
      public static const VALIDATION_ERROR:Class = ValidationException;
      
      public static const INVALID_SESSION_ERROR:String = "com.riotgames.platform.login.InvalidSessionException";
      
      public static const CONCURRENT_MODIFICATION_ERROR:String = "com.riotgames.platform.game.StaleGameVersionException";
      
      public static const ILLEGAL_ARGUMENT_ERROR:String = "java.lang.IllegalArgumentException";
      
      public static const ILLEGAL_STATE_ERROR:String = "java.lang.IllegalStateException";
      
      public static const AUTHENTICATION_CREDENTIALS_ERROR:String = "org.springframework.security.AuthenticationCredentialsNotFoundException";
      
      public static const UNEXPECTED_SERVICE_EXCEPTION:Class = UnexpectedServiceException;
      
      public static const MISSING_ARGUMENT_ERROR:String = "org.apache.commons.lang.NullArgumentException";
      
      private var _messageArguments:Array;
      
      private var _errorCode:String;
      
      public var faultEvent:FaultEvent;
      
      public function ServerError(param1:FaultEvent)
      {
         super();
         this.faultEvent = param1;
      }
      
      public function get messageArguments() : Array
      {
         var _loc1_:Array = null;
         if(this._messageArguments != null)
         {
            _loc1_ = this._messageArguments;
         }
         else if(this.faultEvent != null)
         {
            _loc1_ = this.faultEvent.fault.rootCause is PlatformException?PlatformException(this.faultEvent.fault.rootCause).substitutionArguments:null;
         }
         
         return _loc1_;
      }
      
      public function set errorCode(param1:String) : void
      {
         if(this.faultEvent)
         {
            return;
         }
         this._errorCode = param1;
      }
      
      public function get exception() : Object
      {
         if((this.faultEvent) && (this.faultEvent.fault))
         {
            return this.faultEvent.fault.rootCause;
         }
         return null;
      }
      
      public function get errorCode() : String
      {
         var _loc1_:String = null;
         if(this._errorCode != null)
         {
            _loc1_ = this._errorCode;
         }
         else
         {
            _loc1_ = this.faultEvent.fault.rootCause is PlatformException?PlatformException(this.faultEvent.fault.rootCause).errorCode:null;
         }
         return _loc1_;
      }
      
      public function set messageArguments(param1:Array) : void
      {
         if(this.faultEvent)
         {
            return;
         }
         this._messageArguments = param1;
      }
   }
}
