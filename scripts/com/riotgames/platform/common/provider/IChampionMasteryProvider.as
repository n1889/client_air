package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.championmastery.ChampionMasteryDTO;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IChampionMasteryProvider extends IProvider
   {
      
      function getChampionMasteryData(param1:Number) : ChampionMasteryDTO;
      
      function hideProfileScreen() : void;
      
      function hideInventoryScreen() : void;
      
      function showProfileScreen(param1:DisplayAdapter) : void;
      
      function loadProfileDataForSummoner(param1:Number) : void;
      
      function showInventoryScreen(param1:DisplayAdapter) : void;
   }
}
