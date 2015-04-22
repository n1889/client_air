package com.riotgames.platform.gameclient.chat.domain
{
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   
   public class RecentPlayerItem extends Object
   {
      
      public var timeStamp:Date;
      
      public var playerStats:PlayerParticipantStatsSummary;
      
      public function RecentPlayerItem()
      {
         super();
      }
   }
}
