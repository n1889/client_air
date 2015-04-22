package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.Champion;
   
   public interface IChampionDetailProvider extends IProvider
   {
      
      function close() : void;
      
      function displayChampionDetailView(param1:String, param2:Champion, param3:int = 0, param4:Boolean = false) : void;
   }
}
