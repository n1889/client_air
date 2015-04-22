package com.riotgames.pvpnet.game.controllers
{
   import com.riotgames.platform.gameclient.domain.TeamSkinRentalDTO;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.domain.featuredgame.FeaturedGameMetadataDTO;
   
   public class GameConfig extends Object
   {
      
      private static var _instance:GameConfig;
      
      private var _currentTeamSkinRental:TeamSkinRentalDTO;
      
      private var _currentTeamSkinRentalChanged:Signal;
      
      public var featuredGameMetadataQueried:Boolean = false;
      
      private var _featuredGameMetadataDTO:FeaturedGameMetadataDTO;
      
      public function GameConfig()
      {
         this._currentTeamSkinRentalChanged = new Signal();
         super();
      }
      
      public static function get instance() : GameConfig
      {
         if(_instance == null)
         {
            _instance = new GameConfig();
         }
         return _instance;
      }
      
      public function get currentTeamSkinRental() : TeamSkinRentalDTO
      {
         return this._currentTeamSkinRental;
      }
      
      public function set currentTeamSkinRental(param1:TeamSkinRentalDTO) : void
      {
         if(this._currentTeamSkinRental != param1)
         {
            this._currentTeamSkinRental = param1;
            this._currentTeamSkinRentalChanged.dispatch(this._currentTeamSkinRentalChanged,param1);
         }
      }
      
      public function get currentTeamSkinRentalChanged() : ISignal
      {
         return this._currentTeamSkinRentalChanged;
      }
      
      public function get featuredGameMetadataDTO() : FeaturedGameMetadataDTO
      {
         return this._featuredGameMetadataDTO;
      }
      
      public function set featuredGameMetadataDTO(param1:FeaturedGameMetadataDTO) : void
      {
         this._featuredGameMetadataDTO = param1;
      }
   }
}
