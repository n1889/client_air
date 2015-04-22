package com.riotgames.platform.gameclient.chat.domain
{
   public class ChatMessageType extends Object
   {
      
      public static const USER_ALERT:String = "userAlert";
      
      public static const PRIVATE:String = "private";
      
      public static const ERROR:String = "error";
      
      public static const PUBLIC:String = "public";
      
      public static const JOIN:String = "join";
      
      public static const DELEGATE:String = "delegation";
      
      public static const REVOKE:String = "revoke";
      
      public static const SYSTEM:String = "system";
      
      public static const ADMIN:String = "admin";
      
      public static const LEAVE:String = "leave";
      
      public function ChatMessageType()
      {
         super();
      }
   }
}
