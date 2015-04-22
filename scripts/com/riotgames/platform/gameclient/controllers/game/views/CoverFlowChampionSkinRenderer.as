package com.riotgames.platform.gameclient.controllers.game.views
{
   import mx.core.Container;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.IDataRenderer;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   import flash.filters.ColorMatrixFilter;
   import mx.controls.Image;
   import flash.events.Event;
   import com.riotgames.platform.gameclient.controllers.game.utils.ChampionImages;
   import com.riotgames.platform.common.ImagePackLookup;
   
   public class CoverFlowChampionSkinRenderer extends Container implements IListItemRenderer, IDataRenderer
   {
      
      private static const DEFAULT_HEIGHT:Number = 288;
      
      private static const DEFAULT_WIDTH:Number = 160;
      
      private var rewarded_img:Image;
      
      private var skinDisplayModel:ISkinDisplayModel;
      
      private var isSelected:Boolean = true;
      
      private var isFocused:Boolean = true;
      
      private var stylesChanged:Boolean = false;
      
      private var skinImage:Image;
      
      private var skinChanged:Boolean = false;
      
      public function CoverFlowChampionSkinRenderer()
      {
         super();
      }
      
      public static function adjustSaturation(param1:Number) : Array
      {
         var param1:Number = cleanValue(param1,100);
         if((param1 == 0) || (isNaN(param1)))
         {
            return [];
         }
         var _loc2_:Number = 1 + (param1 > 0?3 * param1 / 100:param1 / 100);
         var _loc3_:Number = 0.3086;
         var _loc4_:Number = 0.6094;
         var _loc5_:Number = 0.082;
         return [_loc3_ * (1 - _loc2_) + _loc2_,_loc4_ * (1 - _loc2_),_loc5_ * (1 - _loc2_),0,0,_loc3_ * (1 - _loc2_),_loc4_ * (1 - _loc2_) + _loc2_,_loc5_ * (1 - _loc2_),0,0,_loc3_ * (1 - _loc2_),_loc4_ * (1 - _loc2_),_loc5_ * (1 - _loc2_) + _loc2_,0,0,0,0,0,1,0,0,0,0,0,1];
      }
      
      private static function cleanValue(param1:Number, param2:Number) : Number
      {
         return Math.min(param2,Math.max(-param2,param1));
      }
      
      private function skinIsAvailable(param1:Number) : Boolean
      {
         return (!(this.skinDisplayModel == null)) && (this.skinDisplayModel.availableForTeamSkinRental(param1));
      }
      
      private function updateSelected() : void
      {
         var _loc1_:ChampionSkin = this.data as ChampionSkin;
         if(_loc1_ != null)
         {
            this.isSelected = SkinsConfig.instance.isSkinLastSelected(_loc1_);
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         var _loc3_:ChampionSkin = this.data as ChampionSkin;
         var _loc4_:Number = 3;
         if(_loc3_ != null)
         {
            if((this.isSelected) && (_loc3_.isAvailable()))
            {
               _loc4_ = 5;
            }
            else if((_loc3_.isAvailable()) || (this.skinIsAvailable(_loc3_.skinId)))
            {
               _loc4_ = 5;
            }
            
         }
         if(this.skinImage)
         {
            this.skinImage.setActualSize(param1 - _loc4_,param2 - _loc4_);
            this.skinImage.move(_loc4_ / 2 + 1,_loc4_ / 2 + 1);
         }
         if(this.rewarded_img)
         {
            this.rewarded_img.setActualSize(this.rewarded_img.getExplicitOrMeasuredWidth(),this.rewarded_img.getExplicitOrMeasuredHeight());
            this.rewarded_img.move((param1 - this.rewarded_img.getExplicitOrMeasuredWidth()) / 2,-12);
         }
         this.drawBackground(param1,param2);
      }
      
      private function updateVisualStyle() : void
      {
         var _loc2_:ColorMatrixFilter = null;
         var _loc3_:ColorMatrixFilter = null;
         var _loc1_:ChampionSkin = this.data as ChampionSkin;
         if(!_loc1_)
         {
            return;
         }
         if((this.isSelected) || (this.isFocused))
         {
            this.filters = [];
         }
         else if((_loc1_.isAvailable()) || (this.skinIsAvailable(_loc1_.skinId)))
         {
            _loc2_ = new ColorMatrixFilter(adjustSaturation(-40));
            this.filters = [_loc2_];
         }
         else
         {
            _loc3_ = new ColorMatrixFilter(adjustSaturation(-70));
            this.filters = [_loc3_];
         }
         
         this.invalidateDisplayList();
      }
      
      protected function createSkinImage() : void
      {
         this.skinImage = new Image();
         this.skinImage.useHandCursor = true;
         this.skinImage.buttonMode = true;
      }
      
      override protected function commitProperties() : void
      {
         if(this.stylesChanged)
         {
            this.updateSelected();
            this.updateVisualStyle();
         }
         super.commitProperties();
         if(this.skinChanged)
         {
            this.updateSkinImage();
         }
         if((this.stylesChanged) || (this.skinChanged))
         {
            this.stylesChanged = false;
            this.skinChanged = false;
            dispatchEvent(new Event(SkinFlow.SKIN_FLOW_FORCE_UPDATE_EVENT));
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         var _loc2_:ChampionSkin = this.data as ChampionSkin;
         if(_loc2_)
         {
            if((_loc2_.freeToPlayReward) && (!_loc2_.owned))
            {
               this.rewarded_img.visible = true;
            }
            else
            {
               this.rewarded_img.visible = false;
            }
         }
         this.stylesChanged = true;
         this.skinChanged = true;
         this.invalidateProperties();
      }
      
      private function updateSkinImage() : void
      {
         var _loc1_:String = "";
         if(data)
         {
            _loc1_ = ChampionImages.getImagePath(this.data.championSkinName,this.data.skinIndex);
         }
         if(this.skinImage)
         {
            this.skinImage.source = _loc1_;
         }
      }
      
      protected function createRewardedImage() : void
      {
         this.rewarded_img = new Image();
         this.rewarded_img.source = ImagePackLookup.instance.getClassFromSwfRef("e_rewards_notification_image");
         this.rewarded_img.visible = false;
         this.rewarded_img.mouseEnabled = false;
         this.rewarded_img.mouseChildren = false;
      }
      
      private function drawBackground(param1:Number, param2:Number) : void
      {
         this.graphics.clear();
         var _loc3_:ChampionSkin = this.data as ChampionSkin;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:Number = 2;
         var _loc5_:Number = 2;
         var _loc6_:Number = 10066329;
         if((this.isSelected) && ((_loc3_.isAvailable()) || (this.skinIsAvailable(_loc3_.skinId))))
         {
            _loc4_ = 3;
            _loc5_ = 2;
            _loc6_ = 16742172;
         }
         else if(_loc3_.isAvailable())
         {
            _loc4_ = 3;
            _loc5_ = 2;
            _loc6_ = 3170034;
         }
         else if(this.skinIsAvailable(_loc3_.skinId))
         {
            _loc4_ = 3;
            _loc5_ = 2;
            _loc6_ = 16172851;
         }
         
         
         this.graphics.lineStyle(_loc4_,_loc6_);
         this.graphics.drawRect(_loc5_,_loc5_,param1 - _loc5_,param2 - _loc5_);
      }
      
      override protected function measure() : void
      {
         measuredWidth = measuredMinWidth = DEFAULT_WIDTH;
         measuredHeight = measuredMinHeight = DEFAULT_HEIGHT;
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.skinImage)
         {
            this.createSkinImage();
            addChild(this.skinImage);
         }
         if(!this.rewarded_img)
         {
            this.createRewardedImage();
            addChild(this.rewarded_img);
         }
      }
      
      public function setSkinDisplayModel(param1:ISkinDisplayModel) : void
      {
         this.skinDisplayModel = param1;
      }
      
      public function setFocused(param1:Boolean) : void
      {
         this.isFocused = param1;
         this.stylesChanged = true;
         this.invalidateProperties();
      }
      
      private function onCreationComplete() : void
      {
         this.stylesChanged = false;
         this.skinChanged = false;
         this.updateSelected();
         this.updateVisualStyle();
         this.updateSkinImage();
         dispatchEvent(new Event(SkinFlow.SKIN_FLOW_FORCE_UPDATE_EVENT));
      }
   }
}
