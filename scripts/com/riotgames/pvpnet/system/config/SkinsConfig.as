package com.riotgames.pvpnet.system.config
{
   import flash.utils.Dictionary;
   import blix.signals.Signal;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.domain.Champion;
   import mx.collections.ArrayCollection;
   
   public class SkinsConfig extends Object
   {
      
      private static var _instance:SkinsConfig;
      
      private var _champToLastSelectedSkinMapping:Dictionary;
      
      private var _lastSelectedSkinChanged:Signal;
      
      public function SkinsConfig(param1:SingletonEnforcer)
      {
         this._champToLastSelectedSkinMapping = new Dictionary();
         this._lastSelectedSkinChanged = new Signal();
         super();
      }
      
      public static function get instance() : SkinsConfig
      {
         if(_instance == null)
         {
            _instance = new SkinsConfig(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function isSkinLastSelected(param1:ChampionSkin) : Boolean
      {
         var _loc2_:ChampionSkin = null;
         if(param1 != null)
         {
            _loc2_ = this._champToLastSelectedSkinMapping[param1.championId];
            if(_loc2_ != null)
            {
               return param1.skinId == _loc2_.skinId;
            }
            if(param1.skinIndex == 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setLastSelectedSkin(param1:ChampionSkin) : void
      {
         var _loc2_:ChampionSkin = null;
         if(param1 != null)
         {
            _loc2_ = this._champToLastSelectedSkinMapping[param1.championId];
            if((_loc2_ == null) && (param1.skinIndex == 0))
            {
               return;
            }
            if((_loc2_ == null) || (!(_loc2_.skinId == param1.skinId)))
            {
               this._champToLastSelectedSkinMapping[param1.championId] = param1;
               this._lastSelectedSkinChanged.dispatch(this._lastSelectedSkinChanged,param1);
            }
         }
      }
      
      public function getLastSelectedSkinChanged() : ISignal
      {
         return this._lastSelectedSkinChanged;
      }
      
      public function getLastSelectedSkinForChampion(param1:Champion) : ChampionSkin
      {
         var _loc2_:ChampionSkin = this._champToLastSelectedSkinMapping[param1.championId];
         return !(_loc2_ == null)?_loc2_:param1.defaultSkin;
      }
      
      public function initializeLastSelectedSkinMapping(param1:ArrayCollection) : void
      {
         var _loc2_:Champion = null;
         var _loc3_:ChampionSkin = null;
         for each(_loc2_ in param1)
         {
            for each(_loc3_ in _loc2_.championSkins)
            {
               if(_loc3_.lastSelected)
               {
                  this._champToLastSelectedSkinMapping[_loc2_.championId] = _loc3_;
                  break;
               }
            }
         }
      }
   }
}

class SingletonEnforcer extends Object
{
   
   function SingletonEnforcer()
   {
      super();
   }
}
