package com.riotgames.platform.common.xmpp.data.privacy
{
   public class PrivacyListItemType extends Object
   {
      
      public static const JID:String = "jid";
      
      public static const SUBSCRIPTION:String = "subscription";
      
      public static const GROUP:String = "group";
      
      public function PrivacyListItemType()
      {
         super();
         throw new Error("Cannot instantiate this class.");
      }
   }
}
