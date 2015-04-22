package com.riotgames.platform.gameclient.domain.game
{
   import com.riotgames.util.string.RiotStringUtil;
   
   public class QueueType extends Object
   {
      
      public static const VS_AI:String = "VS_AI";
      
      public static const CUSTOM:String = "CUSTOM";
      
      public static const CRYSTAL_SCAR:String = "CRYSTAL_SCAR";
      
      public static const QUEUE_TYPES:Array = [NONE,NORMAL,NORMAL_3x3,BOT,BOT_3x3,ARAM_UNRANKED_1x1,ARAM_UNRANKED_2x2,ARAM_UNRANKED_3x3,ARAM_UNRANKED_5x5,ARAM_UNRANKED_6x6,RANKED_SOLO_1x1,RANKED_SOLO_3x3,RANKED_SOLO_5x5,RANKED_PREMADE_3x3,RANKED_PREMADE_5x5,RANKED_TEAM_3x3,RANKED_TEAM_5x5,DOMINION_RANKED_PREMADE,DOMINION_RANKED_SOLO,DOMINION_UNRANKED,CAP1x1,CAP5x5,FEATURED];
      
      public static const QUEUE_GAME_MODES:Object = new Object();
      
      public static const RANKED_PREMADE_3x3:String = "RANKED_PREMADE_3x3";
      
      public static const BOT_3x3:String = "BOT_3x3";
      
      public static const RANKED_PREMADE_5x5:String = "RANKED_PREMADE_5x5";
      
      public static const BOT:String = "BOT";
      
      public static const FEATURED:String = "FEATURED";
      
      public static const QUEUE_MAPS:Object = new Object();
      
      public static const NONE:String = "NONE";
      
      public static const ARAM_UNRANKED_2x2:String = "ARAM_UNRANKED_2x2";
      
      public static const ARAM_UNRANKED_6x6:String = "ARAM_UNRANKED_6x6";
      
      public static const RANKED_SOLO_1x1:String = "RANKED_SOLO_1x1";
      
      public static const CAP1x1:String = "CAP1x1";
      
      public static const RANKED_TEAM_3x3:String = "RANKED_TEAM_3x3";
      
      public static const RANKED_SOLO_3x3:String = "RANKED_SOLO_3x3";
      
      public static const RANKED_SOLO_5x5:String = "RANKED_SOLO_5x5";
      
      public static const CAP5x5:String = "CAP5x5";
      
      public static const TWISTED_TREELINE:String = "TWISTED_TREELINE";
      
      public static const RANKED_TEAM_5x5:String = "RANKED_TEAM_5x5";
      
      public static const NORMAL_3x3:String = "NORMAL_3x3";
      
      public static const RANKED:String = "RANKED";
      
      public static const DOMINION_RANKED_SOLO:String = "ODIN_RANKED_SOLO";
      
      public static const HOWLING_ABYSS:String = "HOWLING_ABYSS";
      
      public static const DOMINION_UNRANKED:String = "ODIN_UNRANKED";
      
      public static const NORMAL:String = "NORMAL";
      
      public static const DOMINION_RANKED_PREMADE:String = "ODIN_RANKED_PREMADE";
      
      public static const ARAM_UNRANKED_3x3:String = "ARAM_UNRANKED_3x3";
      
      public static const ARAM_UNRANKED_1x1:String = "ARAM_UNRANKED_1x1";
      
      public static const ARAM_UNRANKED_5x5:String = "ARAM_UNRANKED_5x5";
      
      public static const SUMMONERS_RIFT:String = "SUMMONERS_RIFT";
      
      {
         QUEUE_MAPS["CUSTOM"] = CUSTOM;
         QUEUE_MAPS["NONE"] = NONE;
         QUEUE_MAPS["NORMAL"] = SUMMONERS_RIFT;
         QUEUE_MAPS["BOT"] = SUMMONERS_RIFT;
         QUEUE_MAPS["RANKED_SOLO_3x3"] = TWISTED_TREELINE;
         QUEUE_MAPS["RANKED_SOLO_5x5"] = SUMMONERS_RIFT;
         QUEUE_MAPS["RANKED_PREMADE_3x3"] = TWISTED_TREELINE;
         QUEUE_MAPS["RANKED_PREMADE_5x5"] = SUMMONERS_RIFT;
         QUEUE_MAPS["RANKED_SOLO_1x1"] = SUMMONERS_RIFT;
         QUEUE_MAPS["ODIN_UNRANKED"] = CRYSTAL_SCAR;
         QUEUE_MAPS["ODIN_RANKED_SOLO"] = CRYSTAL_SCAR;
         QUEUE_MAPS["ODIN_RANKED_TEAM"] = CRYSTAL_SCAR;
         QUEUE_MAPS["RANKED_TEAM_3x3"] = TWISTED_TREELINE;
         QUEUE_MAPS["RANKED_TEAM_5x5"] = SUMMONERS_RIFT;
         QUEUE_MAPS["NORMAL_3x3"] = TWISTED_TREELINE;
         QUEUE_MAPS["BOT_3x3"] = TWISTED_TREELINE;
         QUEUE_MAPS["CAP_1x1"] = SUMMONERS_RIFT;
         QUEUE_MAPS["CAP_5x5"] = SUMMONERS_RIFT;
         QUEUE_MAPS["ARAM_UNRANKED_1x1"] = HOWLING_ABYSS;
         QUEUE_MAPS["ARAM_UNRANKED_2x2"] = HOWLING_ABYSS;
         QUEUE_MAPS["ARAM_UNRANKED_3x3"] = HOWLING_ABYSS;
         QUEUE_MAPS["ARAM_UNRANKED_5x5"] = HOWLING_ABYSS;
         QUEUE_MAPS["ARAM_UNRANKED_6x6"] = HOWLING_ABYSS;
         QUEUE_MAPS["ARAM_BOT"] = HOWLING_ABYSS;
         QUEUE_GAME_MODES["CUSTOM"] = CUSTOM;
         QUEUE_GAME_MODES["NONE"] = CUSTOM;
         QUEUE_GAME_MODES["NORMAL"] = NORMAL;
         QUEUE_GAME_MODES["BOT"] = VS_AI;
         QUEUE_GAME_MODES["RANKED_SOLO_3x3"] = RANKED;
         QUEUE_GAME_MODES["RANKED_SOLO_5x5"] = RANKED;
         QUEUE_GAME_MODES["RANKED_PREMADE_3x3"] = RANKED;
         QUEUE_GAME_MODES["RANKED_PREMADE_5x5"] = RANKED;
         QUEUE_GAME_MODES["RANKED_SOLO_1x1"] = RANKED;
         QUEUE_GAME_MODES["ODIN_UNRANKED"] = NORMAL;
         QUEUE_GAME_MODES["ODIN_RANKED_SOLO"] = RANKED;
         QUEUE_GAME_MODES["ODIN_RANKED_TEAM"] = RANKED;
         QUEUE_GAME_MODES["RANKED_TEAM_3x3"] = RANKED;
         QUEUE_GAME_MODES["RANKED_TEAM_5x5"] = RANKED;
         QUEUE_GAME_MODES["NORMAL_3x3"] = NORMAL;
         QUEUE_GAME_MODES["BOT_3x3"] = VS_AI;
         QUEUE_GAME_MODES["CAP_1x1"] = NORMAL;
         QUEUE_GAME_MODES["CAP_5x5"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_UNRANKED_1x1"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_UNRANKED_2x2"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_UNRANKED_3x3"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_UNRANKED_5x5"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_UNRANKED_6x6"] = NORMAL;
         QUEUE_GAME_MODES["ARAM_BOT"] = VS_AI;
         QUEUE_GAME_MODES["ONEFORALL_5x5"] = FEATURED;
         QUEUE_GAME_MODES["ONEFORALL_1x1"] = FEATURED;
         QUEUE_GAME_MODES["FIRSTBLOOD_1x1"] = FEATURED;
         QUEUE_GAME_MODES["FIRSTBLOOD_2x2"] = FEATURED;
         QUEUE_GAME_MODES["SR_6x6"] = FEATURED;
         QUEUE_GAME_MODES["TT_5x5"] = FEATURED;
         QUEUE_GAME_MODES["URF"] = FEATURED;
         QUEUE_GAME_MODES["URF_BOT"] = FEATURED;
         QUEUE_GAME_MODES["FEATURED"] = FEATURED;
         QUEUE_GAME_MODES["FEATURED_BOT"] = FEATURED;
         QUEUE_GAME_MODES["NIGHTMARE_BOT"] = FEATURED;
         QUEUE_GAME_MODES["ASCENSION"] = FEATURED;
         QUEUE_GAME_MODES["HEXAKILL"] = FEATURED;
         QUEUE_GAME_MODES["KING_PORO"] = FEATURED;
         QUEUE_GAME_MODES["COUNTER_PICK"] = FEATURED;
      }
      
      public function QueueType()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
      
      public static function getGameMode(param1:String) : String
      {
         if(param1 in QUEUE_GAME_MODES)
         {
            return QUEUE_GAME_MODES[param1];
         }
         return param1;
      }
      
      public static function isAspirationalQueue(param1:String) : Boolean
      {
         var _loc2_:Boolean = true;
         if((param1 == "RANKED_TEAM_3x3") || (param1 == "RANKED_TEAM_5x5"))
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public static function getGameMap(param1:String) : String
      {
         if(param1 in QUEUE_MAPS)
         {
            return QUEUE_MAPS[param1];
         }
         return param1;
      }
      
      public static function isCoopVsAI(param1:String) : Boolean
      {
         return param1 == null?false:(param1 == BOT) || (param1 == BOT_3x3) || (RiotStringUtil.endsWith(param1,"_BOT"));
      }
   }
}
