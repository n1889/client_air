package org.igniterealtime.xiff.events
{
   import flash.events.Event;
   
   public class BookmarkRetrievedEvent extends Event
   {
      
      public static var BOOKMARK_RETRIEVED:String = "bookmark retrieved";
      
      public function BookmarkRetrievedEvent()
      {
         super(BOOKMARK_RETRIEVED);
      }
   }
}
