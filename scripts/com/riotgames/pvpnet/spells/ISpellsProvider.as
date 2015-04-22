package com.riotgames.pvpnet.spells
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   import com.riotgames.platform.gameclient.domain.SummonerLevel;
   
   public interface ISpellsProvider extends IProvider
   {
      
      function show(param1:DisplayAdapter, param2:SummonerLevel) : void;
      
      function hide() : void;
   }
}
