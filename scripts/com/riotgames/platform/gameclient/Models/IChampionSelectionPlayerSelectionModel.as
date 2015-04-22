package com.riotgames.platform.gameclient.Models
{
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import blix.signals.ISignal;
   
   public interface IChampionSelectionPlayerSelectionModel extends IPlayerSelectionModel
   {
      
      function get participant() : GameParticipant;
      
      function get selectionState() : String;
      
      function set emphasis(param1:PlayerSelectionEmphasis) : void;
      
      function set selectionState(param1:String) : void;
      
      function get emphasis() : PlayerSelectionEmphasis;
      
      function get emphasisChanged() : ISignal;
   }
}
