package com.riotgames.pvpnet.game.alerts
{
   import mx.collections.ArrayCollection;
   import blix.signals.ISignal;
   
   public interface ILeaverBusterAlertAction
   {
      
      function showDialogueForLeavers(param1:ArrayCollection, param2:Boolean) : void;
      
      function showDialogueForTeamBuilderLeavers(param1:Array, param2:Number, param3:Boolean) : void;
      
      function getDialogueAborted() : ISignal;
      
      function getDialogueWaitCompleted() : ISignal;
      
      function removeDialogue() : void;
   }
}
