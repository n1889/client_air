package com.riotgames.pvpnet.seasonrewards
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.IDisplayChild;
   
   public interface ISeasonRewardsProvider extends IProvider
   {
      
      function showInformationPopup() : void;
      
      function updateRewards() : void;
      
      function getTeamRewardsView() : IDisplayChild;
      
      function getTierRewardsView() : IDisplayChild;
   }
}
