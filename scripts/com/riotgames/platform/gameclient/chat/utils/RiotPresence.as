package com.riotgames.platform.gameclient.chat.utils
{
   import org.igniterealtime.xiff.data.Presence;
   import com.riotgames.platform.gameclient.chat.domain.PresenceStatusData;
   import com.riotgames.platform.common.xmpp.data.invite.PresenceStatusXML;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.platform.gameclient.domain.game.QueueType;
   import com.riotgames.platform.gameclient.domain.Champion;
   
   public class RiotPresence extends Object
   {
      
      private static const BLUE:uint = 1737193;
      
      public static const MOBILE:RiotPresence = new RiotPresence(Presence.SHOW_CHAT_MOBILE,"m",BLUE);
      
      public static const OFFLINE:RiotPresence = new RiotPresence(Presence.SHOW_OFFLINE,"offline",GREY);
      
      private static const GREEN:uint = 4502840;
      
      public static const AWAY:RiotPresence = new RiotPresence(Presence.SHOW_AWAY,"away",RED);
      
      private static const RED:uint = 12980992;
      
      public static const CHAT:RiotPresence = new RiotPresence(Presence.SHOW_CHAT,"available",GREEN);
      
      public static const DND:RiotPresence = new RiotPresence(Presence.SHOW_DND,"busy",YELLOW);
      
      private static const YELLOW:uint = 15914309;
      
      private static const GREY:uint = 8684676;
      
      private var _color:uint;
      
      private var _name:String;
      
      private var _assetKey:String;
      
      public function RiotPresence(param1:String, param2:String, param3:uint)
      {
         super();
         this._name = param1;
         this._assetKey = param2;
         this._color = param3;
      }
      
      private static function overrideMobilePresence(param1:String, param2:Boolean) : String
      {
         if((!param2) && (param1 == Presence.SHOW_CHAT_MOBILE))
         {
            return Presence.SHOW_AWAY;
         }
         return param1;
      }
      
      public static function fromXiffPresence(param1:String, param2:Boolean = false) : RiotPresence
      {
         var param1:String = overrideMobilePresence(param1,param2);
         switch(param1)
         {
            case Presence.SHOW_DND:
               return DND;
            case Presence.SHOW_CHAT_MOBILE:
               return MOBILE;
            case Presence.SHOW_AWAY:
               return AWAY;
            case Presence.SHOW_OFFLINE:
               return OFFLINE;
            case Presence.SHOW_CHAT:
               return CHAT;
         }
      }
      
      public function isInGame(param1:PresenceStatusData) : Boolean
      {
         if(param1)
         {
            return param1.gameType == PresenceStatusXML.GAME_STATUS_IN_GAME;
         }
         return false;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function getBuddyGameDetailsText(param1:Buddy) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this.isInGame(param1.getPresence()))
         {
            _loc2_ = this.getChampionNameFromBuddy(param1);
            _loc3_ = RiotResourceLoader.getString("BuddyListTooltip_inGameInfo",null,[_loc2_]);
            if(_loc3_ == null)
            {
               _loc3_ = RiotResourceLoader.getString("BuddyListTreeRenderer_gameStatus_playingAs") + _loc2_;
            }
            return _loc3_;
         }
         return "";
      }
      
      public function get assetKey() : String
      {
         return this._assetKey;
      }
      
      public function getGameModeFromPresence(param1:PresenceStatusData) : String
      {
         var _loc2_:String = null;
         if(this.isInGame(param1))
         {
            _loc2_ = QueueType.getGameMode(param1.queueType);
            if((_loc2_ == QueueType.NORMAL) || (_loc2_ == QueueType.RANKED))
            {
               _loc2_ = RiotResourceLoader.getString("game_flow_mm_common_" + _loc2_.toLowerCase() + "_queue_title","*" + _loc2_);
            }
            else if(_loc2_ == QueueType.FEATURED)
            {
               _loc2_ = RiotResourceLoader.getString("game_flow_mm_pvp_normal_featured_ofa_title","*" + _loc2_);
            }
            else if(_loc2_ == QueueType.VS_AI)
            {
               _loc2_ = RiotResourceLoader.getString("game_flow_mm_pve_name","*" + _loc2_);
            }
            else
            {
               _loc2_ = "";
            }
            
            
            return _loc2_;
         }
         return "";
      }
      
      public function getChampionNameFromBuddy(param1:Buddy) : String
      {
         var _loc2_:String = null;
         if(this.isInGame(param1.getPresence()))
         {
            if(param1.getPresence().skinname == Champion.RANDOM_SKIN_NAME)
            {
               _loc2_ = RiotResourceLoader.getString("championSelection_randomChampion_displayName");
            }
            else
            {
               _loc2_ = RiotResourceLoader.getChampionResourceString("name",param1.getPresence().skinname,"");
            }
            return _loc2_;
         }
         return "";
      }
      
      public function get colorHex() : String
      {
         return "#" + this._color.toString(16);
      }
      
      public function getGameMapFromPresence(param1:PresenceStatusData) : String
      {
         var _loc2_:String = null;
         if(this.isInGame(param1))
         {
            _loc2_ = QueueType.getGameMap(param1.queueType);
            if((_loc2_ == QueueType.SUMMONERS_RIFT) || (_loc2_ == QueueType.TWISTED_TREELINE) || (_loc2_ == QueueType.CRYSTAL_SCAR))
            {
               _loc2_ = RiotResourceLoader.getString("game_flow_common_" + _loc2_.toLowerCase() + "_title","*" + _loc2_);
            }
            else if(_loc2_ == QueueType.HOWLING_ABYSS)
            {
               _loc2_ = RiotResourceLoader.getString("game_flow_common_" + _loc2_.toLowerCase() + "_5v5_title","*" + _loc2_);
            }
            else
            {
               _loc2_ = "";
            }
            
            return _loc2_;
         }
         return "";
      }
      
      public function getGameStatusFromPresence(param1:PresenceStatusData) : String
      {
         var _loc2_:String = null;
         if((param1) && (this.name == Presence.SHOW_DND))
         {
            _loc2_ = param1.gameType;
         }
         else if((this.name == Presence.SHOW_AWAY) || (this.name == Presence.SHOW_CHAT_MOBILE))
         {
            _loc2_ = Presence.SHOW_AWAY;
         }
         else if((param1) && (PresenceStatusXML.isGameLobbyStatus(param1.gameType)))
         {
            _loc2_ = param1.gameType;
         }
         else
         {
            _loc2_ = "outOfGame";
         }
         
         
         return RiotResourceLoader.getString("BuddyListTreeRenderer_gameStatus_" + _loc2_,"*" + _loc2_);
      }
   }
}
