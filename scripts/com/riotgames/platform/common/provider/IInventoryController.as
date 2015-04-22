package com.riotgames.platform.common.provider
{
   import flash.events.IEventDispatcher;
   import com.riotgames.platform.gameclient.domain.Champion;
   import com.riotgames.platform.gameclient.domain.GameItem;
   import com.riotgames.platform.gameclient.domain.store.StoreAccountBalanceNotification;
   import mx.collections.ArrayCollection;
   import flash.utils.Dictionary;
   import com.riotgames.platform.gameclient.domain.store.StoreFulfillmentNotification;
   import com.riotgames.platform.gameclient.domain.IChampionFilter;
   import com.riotgames.platform.gameclient.domain.Spell;
   import com.riotgames.platform.gameclient.domain.store.RentalUpdateNotification;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import blix.signals.ISignal;
   
   public interface IInventoryController extends IEventDispatcher
   {
      
      function findChampionBySkinName(param1:String) : Champion;
      
      function findGameItemDefinitionbyId(param1:Number) : GameItem;
      
      function processAccountBalanceNotification(param1:StoreAccountBalanceNotification) : void;
      
      function loadUserInventory() : void;
      
      function updateChampionsRoster(param1:ArrayCollection, param2:ArrayCollection, param3:ArrayCollection, param4:Number) : void;
      
      function setBalanceFromLoginPacket(param1:Number, param2:Number) : void;
      
      function getChampionById(param1:int) : Champion;
      
      function refreshChampionsRoster(param1:Number) : void;
      
      function getAvailableChampionCount(param1:Boolean) : int;
      
      function updateSpellDictionary(param1:Dictionary) : void;
      
      function processStoreFulfillmentNotification(param1:StoreFulfillmentNotification) : void;
      
      function checkDisabledSkins() : void;
      
      function get inventory() : IInventory;
      
      function createChampionFilter(param1:Array) : IChampionFilter;
      
      function getChromaListFromLocal(param1:Function, param2:Function) : void;
      
      function getSpellById(param1:int) : Spell;
      
      function processRawFulfillment(param1:Object) : void;
      
      function processRentalUpdateNotification(param1:RentalUpdateNotification) : void;
      
      function hasAnyRentalItems() : Boolean;
      
      function populateSecondarySearchTags(param1:Array) : void;
      
      function getSkinById(param1:Number, param2:Champion) : ChampionSkin;
      
      function getActiveSpells() : ArrayCollection;
      
      function getStoreFulfillmentNotified() : ISignal;
      
      function updateChampionSkins(param1:ArrayCollection) : void;
      
      function findChampionById(param1:Number) : Champion;
      
      function isSpellDisabledForMode(param1:int, param2:String) : Boolean;
      
      function populateSearchTags(param1:Array) : void;
      
      function createSearchTags() : Array;
      
      function getRuneCount(param1:int) : uint;
   }
}
