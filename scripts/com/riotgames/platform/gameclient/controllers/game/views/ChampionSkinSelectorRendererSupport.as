package com.riotgames.platform.gameclient.controllers.game.views
{
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import mx.utils.ObjectUtil;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import com.riotgames.platform.gameclient.domain.Champion;
   import mx.collections.Sort;
   import flash.display.DisplayObject;
   import mx.core.IDataRenderer;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   
   public class ChampionSkinSelectorRendererSupport extends Object
   {
      
      public function ChampionSkinSelectorRendererSupport()
      {
         super();
      }
      
      private static function compareSkins(param1:ChampionSkin, param2:ChampionSkin, param3:Array = null) : int
      {
         if(param1.skinId == param2.skinId)
         {
            return 0;
         }
         if(param1.skinIndex == 0)
         {
            return -1;
         }
         if(param2.skinIndex == 0)
         {
            return 1;
         }
         if((param1.owned) && (!param2.owned))
         {
            return -1;
         }
         if((!param1.owned) && (param2.owned))
         {
            return 1;
         }
         return ObjectUtil.numericCompare(param1.skinIndex,param2.skinIndex);
      }
      
      public static function createSkinsData(param1:PlayerSelection) : ArrayCollection
      {
         var _loc4_:Champion = null;
         var _loc5_:ChampionSkin = null;
         var _loc2_:ArrayCollection = new ArrayCollection();
         if((param1) && (!(param1.champion == null)))
         {
            _loc4_ = param1.champion;
            _loc2_.addItem(_loc4_.defaultSkin);
            for each(_loc5_ in _loc4_.championSkins)
            {
               if(((_loc5_.stillObtainable) || (_loc5_.isAvailable())) && (!(_loc5_.skinId == _loc4_.defaultSkin.skinId)))
               {
                  _loc2_.addItem(_loc5_);
               }
            }
         }
         var _loc3_:Sort = new Sort();
         _loc3_.compareFunction = compareSkins;
         _loc2_.sort = _loc3_;
         _loc2_.refresh();
         return _loc2_;
      }
      
      public static function initializeForSkin(param1:SkinFlow, param2:ChampionSkin) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:* = 0;
         var _loc5_:ChampionSkin = null;
         var _loc6_:ChampionSkin = null;
         if(param1 == null)
         {
            return;
         }
         if((!(param1.selectedSkin == null)) && (param1.selectedSkin.skinId == param2.skinId))
         {
            return;
         }
         if(param2.isChroma)
         {
            _loc4_ = param2.chromaParent % 1000;
            _loc5_ = param2.getChampion().getChampionSkinForIndex(_loc4_);
            var param2:ChampionSkin = _loc5_;
         }
         for each(_loc3_ in param1.getChildren())
         {
            if((_loc3_ is IDataRenderer) && (IDataRenderer(_loc3_).data is ChampionSkin))
            {
               _loc6_ = IDataRenderer(_loc3_).data as ChampionSkin;
               if(_loc6_.skinId == param2.skinId)
               {
                  if(param1.selectedChild != _loc3_)
                  {
                     param1.initializeSelectedIndex(param1.getChildIndex(_loc3_));
                  }
                  break;
               }
            }
         }
      }
      
      public static function createSkinRenderers(param1:Array, param2:ArrayCollection, param3:SkinFlow, param4:ISkinDisplayModel) : void
      {
         var _loc6_:CoverFlowChampionSkinRenderer = null;
         if(param2 == null)
         {
            return;
         }
         var _loc5_:int = 0;
         _loc5_ = param1.length;
         while(_loc5_ < param2.length)
         {
            _loc6_ = new CoverFlowChampionSkinRenderer();
            _loc6_.width = 160;
            _loc6_.height = 288;
            param1.push(_loc6_);
            param3.addChild(_loc6_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc6_ = param1[_loc5_] as CoverFlowChampionSkinRenderer;
            _loc6_.data = param2.getItemAt(_loc5_);
            _loc6_.setSkinDisplayModel(param4);
            if((_loc6_) && (!(_loc6_.parent == param3)))
            {
               param3.addChild(param1[_loc5_]);
            }
            _loc5_++;
         }
         if(param2.length > 0)
         {
            _loc5_ = param2.length;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_] as CoverFlowChampionSkinRenderer;
               if((_loc6_) && (_loc6_.parent == param3))
               {
                  param3.removeChild(param1[_loc5_]);
               }
               _loc5_++;
            }
         }
      }
      
      public static function initializeSelectedSkin(param1:SkinFlow, param2:PlayerSelection) : void
      {
         var _loc3_:ChampionSkin = null;
         if((!(param2 == null)) && (!(param2.champion == null)))
         {
            _loc3_ = SkinsConfig.instance.getLastSelectedSkinForChampion(param2.champion);
            initializeForSkin(param1,_loc3_);
         }
      }
      
      public static function updateFocusedSkin(param1:SkinFlow) : void
      {
         var _loc3_:CoverFlowChampionSkinRenderer = null;
         if((param1 == null) || (param1.selectedChild == null))
         {
            return;
         }
         var _loc2_:uint = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as CoverFlowChampionSkinRenderer;
            if(_loc3_)
            {
               _loc3_.setFocused(_loc3_ == param1.selectedChild);
            }
            _loc2_++;
         }
         param1.validateProperties();
      }
      
      public static function isNavigating(param1:SkinFlow, param2:PlayerSelection) : Boolean
      {
         if((param1 == null) || (param1.selectedSkin == null) || (param2 == null) || (param2.champion == null))
         {
            return false;
         }
         var _loc3_:ChampionSkin = SkinsConfig.instance.getLastSelectedSkinForChampion(param2.champion);
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc4_:Boolean = param1.isAnimating;
         var _loc5_:Boolean = !(param1.selectedSkin.skinId == _loc3_.skinId);
         var _loc6_:Boolean = param1.isInitialState;
         return (!_loc6_) && (_loc4_) && (_loc5_);
      }
   }
}
