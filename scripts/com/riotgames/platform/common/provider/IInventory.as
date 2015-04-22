package com.riotgames.platform.common.provider
{
   import flash.events.IEventDispatcher;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.SpellBookDTO;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.platform.gameclient.domain.SummonerRuneInventory;
   import flash.utils.Dictionary;
   import com.riotgames.platform.gameclient.domain.inventory.ActiveBoosts;
   import blix.signals.ISignal;
   
   public interface IInventory extends IEventDispatcher
   {
      
      function get runeStats() : ArrayCollection;
      
      function set runeBook(param1:SpellBookDTO) : void;
      
      function set runeStats(param1:ArrayCollection) : void;
      
      function set championRegistry(param1:Array) : void;
      
      function set isChampionsLoaded(param1:Boolean) : void;
      
      function set championIdMapping(param1:Array) : void;
      
      function getChromaForChampSkinId(param1:int) : Vector.<ChampionSkin>;
      
      function get summonerRuneInventory() : SummonerRuneInventory;
      
      function get lastIpPoints() : Number;
      
      function set championSkinIdMapping(param1:Object) : void;
      
      function get championCount() : int;
      
      function set summonerRuneInventory(param1:SummonerRuneInventory) : void;
      
      function get championDataDictionary() : Dictionary;
      
      function get champions() : ArrayCollection;
      
      function get gameModeToInactiveSpellIds() : Dictionary;
      
      function set activeBoosts(param1:ActiveBoosts) : void;
      
      function set unobtainableChampionSkinIDList(param1:ArrayCollection) : void;
      
      function set knownGameModesForSpells(param1:ArrayCollection) : void;
      
      function get influencePoints() : Number;
      
      function get skinSkinIdMapping() : Object;
      
      function set spellDictionary(param1:Dictionary) : void;
      
      function set riotPoints(param1:Number) : void;
      
      function set lastIpPoints(param1:Number) : void;
      
      function set freeToPlayChampionForNewPlayersIds(param1:ArrayCollection) : void;
      
      function get runeBook() : SpellBookDTO;
      
      function get isChampionsLoaded() : Boolean;
      
      function get championRegistry() : Array;
      
      function get championIdMapping() : Array;
      
      function get championDataDictionaryChanged() : ISignal;
      
      function set championCount(param1:int) : void;
      
      function get championSkinIdMapping() : Object;
      
      function set championDataDictionary(param1:Dictionary) : void;
      
      function set champions(param1:ArrayCollection) : void;
      
      function set gameModeToInactiveSpellIds(param1:Dictionary) : void;
      
      function get unobtainableChampionSkinIDList() : ArrayCollection;
      
      function get knownGameModesForSpells() : ArrayCollection;
      
      function set inactiveChampionIdList(param1:ArrayCollection) : void;
      
      function get activeBoosts() : ActiveBoosts;
      
      function set gameItemData(param1:Object) : void;
      
      function get riotPoints() : Number;
      
      function set runeDictionary(param1:Dictionary) : void;
      
      function get spellDictionary() : Dictionary;
      
      function getFreeToPlayChampionIdsForLevel(param1:Number) : ArrayCollection;
      
      function get inactiveChampionIdList() : ArrayCollection;
      
      function get gameItemData() : Object;
      
      function set influencePoints(param1:Number) : void;
      
      function set skinSkinIdMapping(param1:Object) : void;
      
      function set knownMaps(param1:ArrayCollection) : void;
      
      function set championsPrecached(param1:Boolean) : void;
      
      function set freeToPlayChampionIds(param1:ArrayCollection) : void;
      
      function set freeToPlayChampionForNewPlayerMaxLevel(param1:Number) : void;
      
      function get knownMaps() : ArrayCollection;
      
      function get championsPrecached() : Boolean;
      
      function get freeToPlayChampionForNewPlayerMaxLevel() : Number;
      
      function get runeDictionary() : Dictionary;
   }
}
