package com.riotgames.pvpnet.system.config
{
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.game.GameReconnectionInfo;
   import com.riotgames.platform.gameclient.domain.PlayerStatSummaries;
   import com.riotgames.platform.gameclient.domain.broadcast.BroadcastNotification;
   import com.riotgames.platform.gameclient.domain.kudos.PendingKudos;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class LoginConfig extends Object
   {
      
      private static var _instance:LoginConfig;
      
      public var languages:ArrayCollection;
      
      public var inGhostGame:Boolean;
      
      public var maxPracticeGameSize:int;
      
      public var matchMakingEnabled:Boolean;
      
      public var reconnectInfo:GameReconnectionInfo;
      
      public var hasReconnected:Boolean = false;
      
      public var playerStatSummaries:PlayerStatSummaries;
      
      public var broadcastNotification:BroadcastNotification;
      
      public var leaverBusterPenaltyTime:int;
      
      public var bingeIsPlayerInBingePreventionWindow:Boolean;
      
      public var bingeMinutesRemaining:Number;
      
      public var bingePreventionSystemEnabledForClient:Boolean;
      
      public var minorShutdownEnforced:Boolean;
      
      public var minor:Boolean;
      
      public var minutesUntilMidnight:Number;
      
      public var minutesUntilShutdownEnabled:Boolean;
      
      public var minutesUntilShutdown:Number;
      
      public var showEmailVerificationPopup:Boolean;
      
      public var pendingKudosDTO:PendingKudos;
      
      public var pendingBadges:int;
      
      public var leaverPenaltyLevel:int;
      
      public var celebrationMessages:ArrayCollection;
      
      private var _loginConfigurationComplete:Signal;
      
      public function LoginConfig(param1:SingletonEnforcer)
      {
         this._loginConfigurationComplete = new Signal();
         super();
      }
      
      public static function get instance() : LoginConfig
      {
         if(_instance == null)
         {
            _instance = new LoginConfig(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function getLoginConfigurationComplete() : ISignal
      {
         return this._loginConfigurationComplete;
      }
      
      public function setLoginConfigurationComplete() : void
      {
         this._loginConfigurationComplete.dispatch(this);
      }
   }
}

class SingletonEnforcer extends Object
{
   
   function SingletonEnforcer()
   {
      super();
   }
}
