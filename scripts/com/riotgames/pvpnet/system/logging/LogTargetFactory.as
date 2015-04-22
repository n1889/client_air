package com.riotgames.pvpnet.system.logging
{
   import mx.logging.targets.TraceTarget;
   import flash.filesystem.File;
   
   public class LogTargetFactory extends Object
   {
      
      public function LogTargetFactory()
      {
         super();
      }
      
      public function getTraceTarget() : TraceTarget
      {
         return new TraceTarget();
      }
      
      public function getFileTarget(param1:File, param2:String) : FileTarget
      {
         return new FileTarget(param1,param2);
      }
   }
}
