package com.riotgames.platform.gameclient.chat.config
{
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   
   public class FriendRecommendationsConfig extends Object
   {
      
      public static const UNLINK_URL_CONFIG:String = "UnlinkUrlTemplate";
      
      public static const STATUS_EXPIRY_CONFIG:String = "StatusExpiryMillis";
      
      public static const UNLINK_URL_DEFAULT:String = "";
      
      public static const DISPLAY_VIEW_ALL_DEFAULT:Boolean = false;
      
      public static const STATUS_EXPIRY_DEFAULT:Number = 0;
      
      public static const FAQ_LINK_CONFIG:String = "FaqLink";
      
      public static const CONTACT_DETAILS_URL_CONFIG:String = "ContactDetailsUrlTemplate";
      
      public static const CONTACT_DETAILS_URL_DEFAULT:String = "";
      
      public static const REGISTER_POLL_DURATION_DEFAULT:Number = 0;
      
      public static const REGISTER_URL_CONFIG:String = "AssociationUrlTemplate";
      
      public static const GET_CONTACTS_DEFAULT:String = "";
      
      public static const REGISTER_POLL_RATE_CONFIG:String = "RegistrationPollRateMillis";
      
      public static const GET_CONTACTS_CONFIG:String = "ContactsUrlTemplate";
      
      public static const REGISTER_POLL_RATE_DEFAULT:Number = 0;
      
      public static const ENABLED_PERCENT_CONFIG:String = "EnabledPercent";
      
      public static const REGISTER_POLL_DURATION_CONFIG:String = "RegistrationPollDurationMillis";
      
      public static const DISPLAY_ADD_FRIEND_UI_DEFAULT:Boolean = false;
      
      public static const REGISTER_URL_DEFAULT:String = "";
      
      public static const DISPLAY_ADD_FRIEND_UI_CONFIG:String = "EnableAddFriendButton";
      
      public static const ENABLED_PERCENT_DEFAULT:Number = 0;
      
      public static const FAQ_LINK_DEFAULT:String = "https://support.riotgames.com/hc/en-us/articles/204167164";
      
      public static const NAMESPACE:String = "FriendRecommendations";
      
      public static const DISPLAY_VIEW_ALL_CONFIG:String = "EnableViewAllPanel";
      
      public function FriendRecommendationsConfig()
      {
         super();
      }
      
      public static function getConfigModel(param1:String, param2:*, param3:Function = null) : ConfigurationModel
      {
         return DynamicClientConfigManager.getConfiguration(FriendRecommendationsConfig.NAMESPACE,param1,param2,param3);
      }
   }
}
