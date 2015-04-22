package com.riotgames.platform.gameclient.domain.game.trade
{
   public class TradeContractDTO extends Object
   {
      
      public var state:String;
      
      public var requesterInternalSummonerName:String;
      
      public var responderChampionId:int;
      
      public var requesterChampionId:int;
      
      public var responderInternalSummonerName:String;
      
      public function TradeContractDTO()
      {
         super();
      }
   }
}
