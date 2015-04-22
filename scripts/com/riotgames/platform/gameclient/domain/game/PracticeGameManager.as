package com.riotgames.platform.gameclient.domain.game
{
   import flash.events.IEventDispatcher;
   import flash.events.Event;
   import mx.logging.ILogger;
   import mx.events.PropertyChangeEvent;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import flash.events.EventDispatcher;
   import mx.logging.Log;
   
   public class PracticeGameManager extends Object implements IEventDispatcher
   {
      
      private var logger:ILogger;
      
      private var _1587541845elapsedExpiryTimeStr:String = "";
      
      private var myTimer:Timer;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var elapsedExpiryTime:Date;
      
      private var _expiryTime:int;
      
      public function PracticeGameManager()
      {
         this.logger = Log.getLogger("com.riotgames.gameclient.domain.game.PracticeGameManager");
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function endExpiryCountDown() : void
      {
         if(this.myTimer == null)
         {
            return;
         }
         if(this.myTimer.running)
         {
            this.myTimer.stop();
         }
         this.myTimer.removeEventListener("timer",this.updateTime);
         this.myTimer = null;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get elapsedExpiryTimeStr() : String
      {
         return this._1587541845elapsedExpiryTimeStr;
      }
      
      private function formatTime(param1:Date) : String
      {
         var _loc2_:String = "";
         if(param1.getMinutes() < 10)
         {
            _loc2_ = _loc2_ + "0";
         }
         _loc2_ = _loc2_ + param1.getMinutes();
         _loc2_ = _loc2_ + ":";
         if(param1.getSeconds() < 10)
         {
            _loc2_ = _loc2_ + "0";
         }
         _loc2_ = _loc2_ + param1.getSeconds();
         return _loc2_;
      }
      
      public function get expiryTime() : int
      {
         return this._expiryTime;
      }
      
      public function set elapsedExpiryTimeStr(param1:String) : void
      {
         var _loc2_:Object = this._1587541845elapsedExpiryTimeStr;
         if(_loc2_ !== param1)
         {
            this._1587541845elapsedExpiryTimeStr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"elapsedExpiryTimeStr",_loc2_,param1));
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function beginExpiryCountDown(param1:Boolean, param2:GameDTO) : void
      {
         if((param1) || (this.elapsedExpiryTime == null))
         {
            this._expiryTime = param2.expiryTime;
            this.elapsedExpiryTime = new Date();
            this.elapsedExpiryTime.hours = 0;
            this.elapsedExpiryTime.minutes = 0;
            this.elapsedExpiryTime.seconds = param2.expiryTime / 1000;
         }
         if(this.myTimer == null)
         {
            this.myTimer = new Timer(1000);
            this.myTimer.addEventListener("timer",this.updateTime);
         }
         this.myTimer.start();
      }
      
      private function updateTime(param1:TimerEvent) : void
      {
         this.elapsedExpiryTime.time = this.elapsedExpiryTime.time - 1000;
         this._expiryTime = this._expiryTime - 1000;
         if(this._expiryTime > 0)
         {
            this.elapsedExpiryTimeStr = this.formatTime(this.elapsedExpiryTime);
         }
         this.dispatchEvent(param1);
      }
   }
}
