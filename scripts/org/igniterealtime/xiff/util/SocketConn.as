package org.igniterealtime.xiff.util
{
   import flash.net.Socket;
   import mx.logging.ILogger;
   import flash.events.ProgressEvent;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SocketConn extends Socket
   {
      
      private var input:String;
      
      private var logger:ILogger;
      
      public function SocketConn(param1:String = null, param2:int = 0.0)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super(param1,param2);
         addEventListener(ProgressEvent.SOCKET_DATA,this.onRead);
         this.input = "";
      }
      
      protected function onRead(param1:ProgressEvent) : void
      {
         var _loc2_:String = readUTFBytes(bytesAvailable);
         this.onSockRead(_loc2_);
      }
      
      public function sendString(param1:String) : void
      {
         var isConnected:Boolean = false;
         var output:String = param1;
         isConnected = connected;
         try
         {
            writeUTFBytes(output);
            flush();
         }
         catch(error:Error)
         {
            logger.debug("SocketConn.sendString: error: " + error.toString());
            logger.debug("SocketConn.sendString: connected=" + isConnected);
         }
      }
      
      private function onSockRead(param1:String) : void
      {
         var _loc2_:SocketDataEvent = new SocketDataEvent();
         _loc2_.data = param1;
         dispatchEvent(_loc2_);
      }
   }
}
