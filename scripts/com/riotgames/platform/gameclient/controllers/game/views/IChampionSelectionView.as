package com.riotgames.platform.gameclient.controllers.game.views
{
   import flash.events.IEventDispatcher;
   import blix.context.IContext;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import com.riotgames.platform.gameclient.controllers.game.GlowComponentController;
   import flash.display.DisplayObjectContainer;
   
   public interface IChampionSelectionView extends IEventDispatcher
   {
      
      function set rootContext(param1:IContext) : void;
      
      function set championSelectionModel(param1:ChampionSelectionModel) : void;
      
      function get championSelectionModel() : ChampionSelectionModel;
      
      function set glowComponentController(param1:GlowComponentController) : void;
      
      function cleanupView() : void;
      
      function get parent() : DisplayObjectContainer;
      
      function updateRerollButton() : void;
      
      function get glowComponentController() : GlowComponentController;
      
      function get rootContext() : IContext;
   }
}
