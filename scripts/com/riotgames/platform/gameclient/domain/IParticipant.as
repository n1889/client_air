package com.riotgames.platform.gameclient.domain
{
   public interface IParticipant
   {
      
      function getPickTurn() : int;
      
      function getBadges() : int;
      
      function getPickMode() : int;
      
      function getSummonerInternalName() : String;
      
      function getSummonerName() : String;
   }
}
