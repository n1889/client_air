package com.riotgames.platform.gameclient.services.watch
{
   import mx.events.FileEvent;
   import flash.filesystem.File;
   import flash.events.Event;
   
   public class ReplayFileEvent extends FileEvent
   {
      
      public static const EXTERNAL_REPLAY_FILE:String = "ReplayFileEvent.ExternalReplayFile";
      
      public static const NEW_REPLAY_FILE:String = "ReplayFileEvent.NewReplayFile";
      
      public static const REPLAY_FILE_DELETE:String = "ReplayFileEvent.ReplayFileDelete";
      
      public static const REPLAY_FILE_RENAME:String = "ReplayFileEvent.ReplayFileRename";
      
      public var oldFile:File;
      
      public var isExternal:Boolean;
      
      public var metaData:Object;
      
      public function ReplayFileEvent(param1:String, param2:File = null, param3:File = null, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5,param2);
         this.oldFile = param3;
      }
      
      override public function clone() : Event
      {
         var _loc1_:ReplayFileEvent = new ReplayFileEvent(type,file,this.oldFile,bubbles,cancelable);
         return _loc1_;
      }
   }
}
