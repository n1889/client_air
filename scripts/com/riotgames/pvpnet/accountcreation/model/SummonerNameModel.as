package com.riotgames.pvpnet.accountcreation.model
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class SummonerNameModel extends Object
   {
      
      public var createSummonerMode:Boolean;
      
      public var numberOfTries:int = 0;
      
      public var errorAlertShown:Boolean = false;
      
      private var _newSummonerName:String;
      
      private var _newSummonerNameChanged:Signal;
      
      private var _summonerRenamed:Signal;
      
      public function SummonerNameModel()
      {
         this._newSummonerNameChanged = new Signal();
         this._summonerRenamed = new Signal();
         super();
      }
      
      public function get newSummonerName() : String
      {
         return this._newSummonerName;
      }
      
      public function set newSummonerName(param1:String) : void
      {
         this._newSummonerName = param1;
         this._newSummonerNameChanged.dispatch(this._newSummonerNameChanged,this._newSummonerName);
      }
      
      public function getNewSummonerNameChanged() : ISignal
      {
         return this._newSummonerNameChanged;
      }
      
      public function getSummonerRenamed() : ISignal
      {
         return this._summonerRenamed;
      }
      
      public function setSummonerRenamed() : void
      {
         this._newSummonerName = null;
         this._summonerRenamed.dispatch();
      }
   }
}
