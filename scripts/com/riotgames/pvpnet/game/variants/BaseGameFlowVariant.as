package com.riotgames.pvpnet.game.variants
{
   import mx.collections.ArrayCollection;
   
   class BaseGameFlowVariant extends Object
   {
      
      protected var _key:String;
      
      protected var _gameMutators:ArrayCollection;
      
      protected var _gameMode:String;
      
      function BaseGameFlowVariant()
      {
         super();
      }
      
      public function initializeContext(param1:ArrayCollection, param2:String) : void
      {
         this._gameMutators = param1;
         this._gameMode = param2;
      }
      
      function get key() : String
      {
         return this._key;
      }
   }
}
