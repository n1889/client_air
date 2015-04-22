package com.blitzagency.xray.logger
{
   public class XrayLog extends Object
   {
      
      private var logger:XrayLogger;
      
      public function XrayLog()
      {
         super();
         logger = XrayLogger.getInstance();
      }
      
      public function debug(message:String, ... rest) : void
      {
         var i:* = NaN;
         if(rest.length == 0)
         {
            logger.debug(new Log(message,null,XrayLogger.DEBUG));
         }
         i = 0;
         while(i < rest.length)
         {
            if(i > 0)
            {
               var message:String = "";
            }
            logger.debug(new Log(message,rest[i],XrayLogger.DEBUG));
            i++;
         }
      }
      
      public function fatal(message:String, ... rest) : void
      {
         var i:* = NaN;
         if(rest.length == 0)
         {
            logger.fatal(new Log(message,null,XrayLogger.FATAL));
         }
         i = 0;
         while(i < rest.length)
         {
            if(i > 0)
            {
               var message:String = "";
            }
            logger.fatal(new Log(message,rest[i],XrayLogger.FATAL));
            i++;
         }
      }
      
      public function info(message:String, ... rest) : void
      {
         var i:* = NaN;
         if(rest.length == 0)
         {
            logger.info(new Log(message,null,XrayLogger.INFO));
         }
         i = 0;
         while(i < rest.length)
         {
            if(i > 0)
            {
               var message:String = "";
            }
            logger.info(new Log(message,rest[i],XrayLogger.INFO));
            i++;
         }
      }
      
      public function warn(message:String, ... rest) : void
      {
         var i:* = NaN;
         if(rest.length == 0)
         {
            logger.warn(new Log(message,null,XrayLogger.WARN));
         }
         i = 0;
         while(i < rest.length)
         {
            if(i > 0)
            {
               var message:String = "";
            }
            logger.warn(new Log(message,rest[i],XrayLogger.WARN));
            i++;
         }
      }
      
      public function error(message:String, ... rest) : void
      {
         var i:* = NaN;
         if(rest.length == 0)
         {
            logger.error(new Log(message,null,XrayLogger.ERROR));
         }
         i = 0;
         while(i < rest.length)
         {
            if(i > 0)
            {
               var message:String = "";
            }
            logger.error(new Log(message,rest[i],XrayLogger.ERROR));
            i++;
         }
      }
   }
}
