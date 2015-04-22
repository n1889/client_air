package com.riotgames.platform.gameclient.Models
{
   import com.riotgames.platform.gameclient.domain.Champion;
   import blix.signals.ISignal;
   
   public interface IPlayerSelectionModel
   {
      
      function get champion() : Champion;
      
      function set champion(param1:Champion) : void;
      
      function get championChanged() : ISignal;
   }
}
