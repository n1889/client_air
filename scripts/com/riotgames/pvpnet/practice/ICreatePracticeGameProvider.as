package com.riotgames.pvpnet.practice
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.platform.gameclient.domain.game.practice.PracticeGameConfig;
   
   public interface ICreatePracticeGameProvider extends IProvider
   {
      
      function joinOrCreateGame() : void;
      
      function setGameConfig(param1:PracticeGameConfig) : void;
   }
}
