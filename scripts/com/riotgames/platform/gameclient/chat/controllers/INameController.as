package com.riotgames.platform.gameclient.chat.controllers
{
   import com.riotgames.platform.gameclient.domain.social.SocialNetworkContact;
   import com.riotgames.platform.gameclient.domain.SummonerSummary;
   
   public interface INameController
   {
      
      function attemptToConnectSummoner(param1:SummonerSummary) : SocialNetworkContact;
   }
}
