package com.riotgames.platform.masteries
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   import mx.collections.ArrayCollection;
   import blix.signals.ISignal;
   
   public interface IMasteriesProvider extends IProvider
   {
      
      function showMasteries(param1:Number, param2:DisplayAdapter, param3:Boolean = false) : void;
      
      function getPagesInfo() : ArrayCollection;
      
      function getPagesInfoUpdated() : ISignal;
      
      function getSelectedPageID() : int;
      
      function setSelectedPageByID(param1:int) : void;
      
      function closeMasteries() : void;
   }
}
