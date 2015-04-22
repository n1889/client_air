package blix.logger
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class ArrayTarget extends LogTarget
   {
      
      public var maxMessages:uint = 100;
      
      private var _changed:Signal;
      
      private var messages:Vector.<String>;
      
      public function ArrayTarget(param1:ILoggingManager)
      {
         this._changed = new Signal();
         this.messages = new Vector.<String>();
         super(param1);
      }
      
      public function getMessages() : Vector.<String>
      {
         return this.messages;
      }
      
      override protected function logMessage(param1:String, param2:uint) : void
      {
         this.messages[this.messages.length] = LogLevelsEnum.levelToString(param2) + ": " + param1;
         if(this.messages.length > this.maxMessages)
         {
            this.messages.unshift();
         }
         this._changed.dispatch();
      }
      
      public function getChanged() : ISignal
      {
         return this._changed;
      }
   }
}
