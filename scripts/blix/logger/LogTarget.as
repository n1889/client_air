package blix.logger
{
   import blix.util.string.StringFilter;
   import blix.IDestructible;
   
   public class LogTarget extends StringFilter implements IDestructible
   {
      
      protected var loggingManager:ILoggingManager;
      
      public function LogTarget(param1:ILoggingManager)
      {
         super();
         this.loggingManager = param1;
         param1.getMessageLogged().add(this.messageLoggedHandler);
      }
      
      private function messageLoggedHandler(param1:String, param2:String, param3:uint) : void
      {
         if(!filter(param2))
         {
            return;
         }
         this.logMessage(param1,param3);
      }
      
      protected function logMessage(param1:String, param2:uint) : void
      {
      }
      
      public function destroy() : void
      {
         this.loggingManager.getMessageLogged().remove(this.messageLoggedHandler);
      }
   }
}
