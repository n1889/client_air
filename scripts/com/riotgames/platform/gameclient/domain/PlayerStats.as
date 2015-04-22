package com.riotgames.platform.gameclient.domain
{
   public class PlayerStats extends AbstractDomainObject
   {
      
      public var promoGamesPlayedLastUpdated:Date;
      
      public var promoGamesPlayed:int;
      
      public function PlayerStats()
      {
         super();
      }
   }
}
