package com.riotgames.platform.gameclient.controllers.game.views
{
   import blix.IDestructible;
   import blix.signals.ISignal;
   
   public interface ISkinDisplayModel extends IDestructible
   {
      
      function get teamSkinRentalChanged() : ISignal;
      
      function get isGameQueuedToStart() : Boolean;
      
      function get skinFulfillmentNotified() : ISignal;
      
      function canSelectSkins() : Boolean;
      
      function get isGameQueuedToStartChanged() : ISignal;
      
      function get allSkinsRentalUnlock() : Boolean;
      
      function availableForTeamSkinRental(param1:Number) : Boolean;
   }
}
