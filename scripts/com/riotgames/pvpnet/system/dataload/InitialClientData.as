package com.riotgames.pvpnet.system.dataload
{
   import com.riotgames.platform.gameclient.domain.LoginDataPacket;
   import com.riotgames.platform.common.provider.IInventory;
   import com.riotgames.platform.common.provider.IRuneBookController;
   import com.riotgames.platform.gameclient.domain.inventory.ActiveBoosts;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.common.provider.IInventoryController;
   
   public class InitialClientData extends Object
   {
      
      public var loginDataPacket:LoginDataPacket;
      
      public var inventory:IInventory;
      
      public var runeBookController:IRuneBookController;
      
      public var activeBoosts:ActiveBoosts;
      
      public var availableGameQueues:ArrayCollection;
      
      public var inventoryController:IInventoryController;
      
      public function InitialClientData()
      {
         super();
      }
   }
}
