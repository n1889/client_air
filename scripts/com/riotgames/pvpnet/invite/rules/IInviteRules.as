package com.riotgames.pvpnet.invite.rules
{
   import mx.collections.ListCollectionView;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   
   public interface IInviteRules
   {
      
      function getInviteListMembers() : ListCollectionView;
      
      function getInviteListMembersChanged() : ISignal;
      
      function getAllowNonFriends() : Boolean;
      
      function getAllowSuggestions() : Boolean;
      
      function filter(param1:Buddy) : uint;
   }
}
