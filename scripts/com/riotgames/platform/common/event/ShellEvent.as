package com.riotgames.platform.common.event
{
   import flash.events.Event;
   import flash.filesystem.File;
   
   public class ShellEvent extends Event
   {
      
      public static const SMALL_TITLE:String = "SHELL_EVENT_SMALL_TITLE";
      
      public static const NOTIFY:String = "SHELL_EVENT_NOTIFY";
      
      public static const RESTORE:String = "SHELL_EVENT_RESTORE";
      
      public static const ACTIVATE:String = "SHELL_EVENT_ACTIVATE";
      
      public static const LARGE_TITLE:String = "SHELL_EVENT_LARGE_TITLE";
      
      public static const MINIMIZE_TO_TRAY:String = "SHELL_EVENT_MINIMIZE_TO_TRAY";
      
      public static const DEACTIVATE:String = "SHELL_EVENT_DEACTIVATE";
      
      public static const FILE_DROPPED:String = "SHELL_EVENT_FILE_DROPPED";
      
      public static const EXIT:String = "SHELL_EVENT_EXIT";
      
      public var files:Vector.<File>;
      
      public function ShellEvent(param1:String)
      {
         this.files = new Vector.<File>();
         super(param1,false,false);
      }
   }
}
