package com.riotgames.pvpnet.rankedteams
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.rankedTeams.TeamId;
   
   public interface ILegacyTeamProfileNavigationProvider extends IProvider
   {
      
      function goToTeam(param1:TeamId) : void;
   }
}
