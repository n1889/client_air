package com.riotgames.platform.gameclient.kudos
{
   import flash.events.IEventDispatcher;
   import com.riotgames.platform.gameclient.domain.kudos.PendingKudos;
   
   public interface IKudosService extends IEventDispatcher
   {
      
      function sendKudosAcknowledgement(param1:PendingKudos, param2:Function) : void;
      
      function getPendingKudos(param1:Function) : void;
      
      function getTotals(param1:Number, param2:Function) : void;
      
      function giveKudo(param1:Number, param2:Number, param3:Number, param4:Number) : void;
   }
}
