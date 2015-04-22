package blix.logger
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class LoggingManager extends Object implements ILoggingManager
   {
      
      private var _messageLogged:Signal;
      
      public function LoggingManager()
      {
         this._messageLogged = new Signal();
         super();
      }
      
      public function getMessageLogged() : ISignal
      {
         return this._messageLogged;
      }
      
      public function log(param1:String, param2:String, param3:uint = 4) : void
      {
         this._messageLogged.dispatch(param1,param2,param3);
      }
   }
}
