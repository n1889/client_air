package com.riotgames.platform.gameclient.chat
{
   import flash.events.IEventDispatcher;
   import mx.collections.ListCollectionView;
   import blix.signals.ISignal;
   import org.igniterealtime.xiff.data.im.RosterItemVO;
   
   public interface IChatRosterProvider extends IEventDispatcher
   {
      
      function getBuddyGroups() : ListCollectionView;
      
      function addBuddy(param1:String, param2:String = null) : void;
      
      function getRosterPresenceUpdatedSignal() : ISignal;
      
      function getAllRosterItems() : Array;
      
      function getSubscriptionRequestSignal() : ISignal;
      
      function findBuddyRosterItemByName(param1:String) : RosterItemVO;
      
      function getAllRosterBuddies() : Array;
      
      function getBuddyBySummonerId(param1:Number) : RosterItemVO;
      
      function isSummonerBuddy(param1:String, param2:Boolean = false) : Boolean;
      
      function hasSubscriptionRequest(param1:String) : Boolean;
      
      function getBuddyRemovedSignal() : ISignal;
      
      function getBuddyAddedSignal() : ISignal;
   }
}
