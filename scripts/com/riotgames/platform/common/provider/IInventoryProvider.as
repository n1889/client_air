package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import blix.signals.ISignal;
   
   public interface IInventoryProvider extends IProvider
   {
      
      function getInventoryController() : IInventoryController;
      
      function getInventoryInitialized() : ISignal;
      
      function getInventory() : IInventory;
   }
}
