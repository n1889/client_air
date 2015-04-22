package com.riotgames.pvpnet.championselection.views
{
   import mx.core.UIComponent;
   import mx.core.IDataRenderer;
   import mx.controls.Image;
   import flash.events.MouseEvent;
   import com.riotgames.platform.gameclient.controllers.game.event.ItemSelectEvent;
   import com.riotgames.platform.common.ImagePackLookup;
   import com.riotgames.platform.gameclient.domain.game.ParticipantChampionSelection;
   import flash.filters.ColorMatrixFilter;
   import com.riotgames.platform.gameclient.domain.Champion;
   import flash.display.Bitmap;
   import mx.controls.Label;
   import com.riotgames.platform.gameclient.controllers.game.utils.ChampionImagesCache;
   import com.riotgames.platform.gameclient.championselection.enum.ChampionSelectState;
   
   public class ChampionSelectRenderer extends UIComponent implements IDataRenderer
   {
      
      public static const BANNED_STATE_OFF:String = "off";
      
      protected static const CHAMPION_IMAGE_HEIGHT:int = 60;
      
      protected static const BORDER_COMPONENT_HEIGTH:int = 62;
      
      public static const BANNED_STATE_ON:String = "on";
      
      public static const BUTTON_STATE_OVER:String = "over";
      
      protected static const BORDER_COMPONENT_WIDTH:int = 62;
      
      public static const FREE_TO_PLAY_ICON:Class = ChampionSelectRenderer_FREE_TO_PLAY_ICON;
      
      public static const BUTTON_STATE_UP:String = "up";
      
      protected static const AWARD_IMAGE_PADDING_RIGHT:int = -4;
      
      protected static const GRAYSCALE_MATRIX:Array = [0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0];
      
      protected static const CHAMPION_IMAGE_WIDTH:int = 60;
      
      protected static const AWARD_IMAGE_PADDING_BOTTOM:int = -6;
      
      protected var freeToPlayImage:Image;
      
      protected var _borderOverlay:cs_championItem;
      
      protected var _data:Object;
      
      protected var awardBorder:Image;
      
      protected var championImage:Image;
      
      protected var labelComponent:LabelComponent;
      
      protected var dataChanged:Boolean = false;
      
      protected var awardImage:Image;
      
      public function ChampionSelectRenderer()
      {
         super();
      }
      
      override protected function childrenCreated() : void
      {
         addEventListener(MouseEvent.CLICK,this.handleRendererClick,false,0,true);
         addEventListener(MouseEvent.ROLL_OVER,this.handleRendererRollOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.handleRendererRollOut,false,0,true);
         if(this.labelComponent)
         {
            this.labelComponent.visible = false;
         }
         if(this.freeToPlayImage)
         {
            this.freeToPlayImage.visible = false;
         }
         if(this.awardImage)
         {
            this.awardImage.visible = false;
         }
         if(this.awardBorder)
         {
            this.awardBorder.visible = false;
         }
         if(this.data)
         {
            this.updateRenderer(this.data);
         }
      }
      
      public function get borderOverlay() : cs_championItem
      {
         return this._borderOverlay;
      }
      
      protected function handleRendererRollOut(param1:MouseEvent) : void
      {
         if(this._borderOverlay)
         {
            this._borderOverlay.currentState = BUTTON_STATE_UP;
         }
         if(this.labelComponent)
         {
            this.labelComponent.visible = false;
         }
         dispatchEvent(new ItemSelectEvent(ItemSelectEvent.ROLL_OUT,true,false,this.data));
      }
      
      protected function createLabelComponent() : LabelComponent
      {
         var _loc1_:LabelComponent = new LabelComponent();
         return _loc1_;
      }
      
      protected function createAwardBorder() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.source = ImagePackLookup.instance.getClassFromSwfRef("e_rewards_gold_border");
         return _loc1_;
      }
      
      private function allowDuplicateChampionsOnSameTeam(param1:ParticipantChampionSelection) : Boolean
      {
         return (!(param1 == null)) && (!(param1.gameTypeConfig == null)) && (param1.gameTypeConfig.duplicatePick);
      }
      
      protected function updateSaturationFilter(param1:ParticipantChampionSelection) : void
      {
         var _loc3_:ColorMatrixFilter = null;
         if(!this.championImage)
         {
            return;
         }
         var _loc2_:Boolean = (param1 && (!param1.participant || this.allowDuplicateChampionsOnSameTeam(param1)) && !param1.banned && !param1.disabledForGame) && (param1.champion) && (param1.champion.active);
         if((_loc2_) && (this.championImage.filters.length > 0))
         {
            this.championImage.filters = [];
         }
         else if((!_loc2_) && (filters.length == 0))
         {
            _loc3_ = new ColorMatrixFilter();
            _loc3_.matrix = GRAYSCALE_MATRIX;
            this.championImage.filters = [_loc3_];
         }
         
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
         this.dataChanged = true;
         invalidateProperties();
      }
      
      protected function createChampionImage() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.width = CHAMPION_IMAGE_WIDTH;
         _loc1_.height = CHAMPION_IMAGE_HEIGHT;
         _loc1_.cacheAsBitmap = true;
         return _loc1_;
      }
      
      protected function createAwardImage() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.source = ImagePackLookup.instance.getClassFromSwfRef("e_rewards_char_select_notification");
         return _loc1_;
      }
      
      protected function handleRendererRollOver(param1:MouseEvent) : void
      {
         var _loc2_:ParticipantChampionSelection = this.data as ParticipantChampionSelection;
         var _loc3_:Champion = _loc2_.champion;
         if(parent)
         {
            parent.setChildIndex(this,parent.numChildren - 1);
         }
         if(!_loc2_.disabledForGame)
         {
            if((!_loc2_.participant) && (!_loc2_.banned) || (this.allowDuplicateChampionsOnSameTeam(_loc2_)))
            {
               if(this._borderOverlay)
               {
                  this._borderOverlay.currentState = BUTTON_STATE_OVER;
               }
            }
         }
         if(this.labelComponent)
         {
            this.labelComponent.visible = true;
         }
         dispatchEvent(new ItemSelectEvent(ItemSelectEvent.ROLL_OVER,true,false,this.data));
      }
      
      override protected function commitProperties() : void
      {
         super.commitProperties();
         if(this.dataChanged)
         {
            this.updateRenderer(this.data);
            this.dataChanged = false;
         }
      }
      
      private function gotIcon(param1:Bitmap) : void
      {
         param1.width = CHAMPION_IMAGE_WIDTH;
         param1.height = CHAMPION_IMAGE_HEIGHT;
         param1.smoothing = false;
         this.championImage.source = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      protected function createFreeToPlayImage() : Image
      {
         var _loc1_:Image = new Image();
         _loc1_.source = ChampionSelectRenderer.FREE_TO_PLAY_ICON;
         return _loc1_;
      }
      
      protected function updateRenderer(param1:Object) : void
      {
         var _loc3_:Champion = null;
         var _loc2_:ParticipantChampionSelection = param1 as ParticipantChampionSelection;
         if(_loc2_)
         {
            _loc3_ = _loc2_.champion;
         }
         var _loc4_:Boolean = _loc3_?_loc3_.isRandomChampion():false;
         var _loc5_:Boolean = _loc3_?_loc3_.isWildCardChampion():false;
         var _loc6_:Boolean = _loc3_?(!_loc3_.owned) && (_loc3_.freeToPlayReward) && (!_loc4_):false;
         if(this.labelComponent)
         {
            this.labelComponent.text = _loc3_?_loc3_.displayName:"";
         }
         if(this._borderOverlay)
         {
            this._borderOverlay.banned.currentState = (_loc2_) && (_loc2_.banned)?BANNED_STATE_ON:BANNED_STATE_OFF;
         }
         if(this.freeToPlayImage)
         {
            this.freeToPlayImage.visible = (_loc3_ && _loc3_.freeToPlay) && (!_loc4_) && (!_loc5_);
         }
         if(this.awardImage)
         {
            this.awardImage.visible = _loc6_;
         }
         if(this.awardBorder)
         {
            this.awardBorder.visible = _loc6_;
         }
         this.updateChampionImage();
         this.updateSaturationFilter(_loc2_);
      }
      
      protected function createChampionLabel() : Label
      {
         var _loc1_:Label = new Label();
         _loc1_.setStyle("styleName","championNameText");
         _loc1_.opaqueBackground = 0;
         return _loc1_;
      }
      
      protected function updateChampionImage() : void
      {
         if((this.championImage) && (this.data) && (this.data.champion))
         {
            ChampionImagesCache.instance.getIcon(this.data.champion.skinName,0,this.gotIcon);
         }
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         if(!this.championImage)
         {
            this.championImage = this.createChampionImage();
            if(this.championImage)
            {
               addChild(this.championImage);
            }
         }
         if(!this._borderOverlay)
         {
            this._borderOverlay = this.createChampionBorderOverlay();
            if(this.borderOverlay)
            {
               addChild(this._borderOverlay);
            }
         }
         if(!this.freeToPlayImage)
         {
            this.freeToPlayImage = this.createFreeToPlayImage();
            if(this.freeToPlayImage)
            {
               addChild(this.freeToPlayImage);
            }
         }
         if(!this.awardBorder)
         {
            this.awardBorder = this.createAwardBorder();
            if(this.awardBorder)
            {
               addChild(this.awardBorder);
            }
         }
         if(!this.awardImage)
         {
            this.awardImage = this.createAwardImage();
            if(this.awardImage)
            {
               addChild(this.awardImage);
            }
         }
         if(!this.labelComponent)
         {
            this.labelComponent = this.createLabelComponent();
            if(this.labelComponent)
            {
               addChild(this.labelComponent);
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         super.updateDisplayList(param1,param2);
         if(this._borderOverlay)
         {
            _loc3_ = this._borderOverlay.getExplicitOrMeasuredWidth();
            _loc4_ = this._borderOverlay.getExplicitOrMeasuredHeight();
            this._borderOverlay.setActualSize(_loc3_,_loc4_);
            this._borderOverlay.move((param1 - _loc3_) / 2,(param2 - _loc4_) / 2);
         }
         if(this.championImage)
         {
            _loc5_ = this.championImage.getExplicitOrMeasuredWidth();
            _loc6_ = this.championImage.getExplicitOrMeasuredHeight();
            this.championImage.setActualSize(_loc5_,_loc6_);
            this.championImage.move((param1 - _loc5_) / 2,(param2 - _loc6_) / 2);
         }
         if(this.freeToPlayImage)
         {
            _loc7_ = this.freeToPlayImage.getExplicitOrMeasuredWidth();
            _loc8_ = this.freeToPlayImage.getExplicitOrMeasuredHeight();
            this.freeToPlayImage.setActualSize(_loc7_,_loc8_);
            this.freeToPlayImage.move(0,0);
         }
         if(this.awardBorder)
         {
            _loc9_ = this.awardBorder.getExplicitOrMeasuredWidth();
            _loc10_ = this.awardBorder.getExplicitOrMeasuredHeight();
            this.awardBorder.setActualSize(_loc9_,_loc10_);
            this.awardBorder.move((param1 - _loc9_) / 2,(param2 - _loc10_) / 2);
         }
         if(this.awardImage)
         {
            _loc11_ = this.awardImage.getExplicitOrMeasuredWidth();
            _loc12_ = this.awardImage.getExplicitOrMeasuredHeight();
            this.awardImage.setActualSize(_loc11_,_loc12_);
            this.awardImage.move(param1 - _loc11_ - AWARD_IMAGE_PADDING_RIGHT,param2 - _loc12_ - AWARD_IMAGE_PADDING_BOTTOM);
         }
         if(this.labelComponent)
         {
            _loc13_ = this.labelComponent.getExplicitOrMeasuredWidth();
            _loc14_ = this.labelComponent.getExplicitOrMeasuredHeight();
            this.labelComponent.setActualSize(_loc13_,_loc14_);
            this.labelComponent.move((param1 - _loc13_) / 2,param2 - _loc14_);
         }
      }
      
      protected function handleRendererClick(param1:MouseEvent) : void
      {
         var _loc2_:ParticipantChampionSelection = this.data as ParticipantChampionSelection;
         if(!_loc2_.disabledForGame)
         {
            if((ChampionSelectState.tutorialPickOverride) || (_loc2_ && _loc2_.participant == null) || (this.allowDuplicateChampionsOnSameTeam(_loc2_)))
            {
               dispatchEvent(new ItemSelectEvent(ItemSelectEvent.SELECT,true,false,this.data));
            }
         }
      }
      
      protected function createChampionBorderOverlay() : cs_championItem
      {
         var _loc1_:cs_championItem = new cs_championItem();
         return _loc1_;
      }
   }
}

import mx.core.UIComponent;
import mx.controls.Label;

class LabelComponent extends UIComponent
{
   
   protected static const BACKGROUND_ALPHA:Number = 0.7;
   
   protected static const LABEL_PADDING_TOP_BOTTOM:int = -4;
   
   protected static const BORDER_COLOR:uint = 3355443;
   
   protected static const BACKGROUND_COLOR:uint = 0;
   
   protected static const CORNER_RADIUS:int = 5;
   
   protected static const LABEL_PADDING_LEFT_RIGHT:int = 10;
   
   protected var textChanged:Boolean = true;
   
   protected var _text:String;
   
   protected var label:Label;
   
   function LabelComponent()
   {
      super();
   }
   
   override protected function commitProperties() : void
   {
      super.commitProperties();
      if(this.textChanged)
      {
         this.updateLabel(this.label);
         this.textChanged = false;
      }
   }
   
   protected function updateLabel(param1:Label) : void
   {
      if(param1)
      {
         param1.text = this.text;
      }
   }
   
   public function get text() : String
   {
      return this._text;
   }
   
   protected function drawBackground(param1:Number, param2:Number) : void
   {
      graphics.clear();
      graphics.beginFill(BORDER_COLOR,BACKGROUND_ALPHA);
      graphics.drawRoundRect(0,0,param1,param2,CORNER_RADIUS);
      graphics.beginFill(BACKGROUND_COLOR,BACKGROUND_ALPHA);
      graphics.drawRoundRect(1,1,param1 - 2,param2 - 2,CORNER_RADIUS);
      graphics.endFill();
   }
   
   override protected function updateDisplayList(param1:Number, param2:Number) : void
   {
      var _loc3_:* = NaN;
      var _loc4_:* = NaN;
      super.updateDisplayList(param1,param2);
      this.drawBackground(param1,param2);
      if(this.label)
      {
         _loc3_ = this.label.getExplicitOrMeasuredWidth();
         _loc4_ = this.label.getExplicitOrMeasuredHeight();
         this.label.setActualSize(_loc3_,_loc4_);
         this.label.move((param1 - _loc3_) / 2,(param2 - _loc4_) / 2);
      }
   }
   
   public function set text(param1:String) : void
   {
      this._text = param1;
      this.textChanged = true;
      invalidateProperties();
   }
   
   override protected function createChildren() : void
   {
      super.createChildren();
      this.label = this.createLabel();
      if(this.label)
      {
         addChild(this.label);
      }
   }
   
   override protected function measure() : void
   {
      super.measure();
      if(this.label)
      {
         measuredWidth = measuredMinWidth = this.label.getExplicitOrMeasuredWidth() + LABEL_PADDING_LEFT_RIGHT;
         measuredHeight = measuredMinHeight = this.label.getExplicitOrMeasuredHeight() + LABEL_PADDING_TOP_BOTTOM;
      }
   }
   
   protected function createLabel() : Label
   {
      var _loc1_:Label = new Label();
      _loc1_.setStyle("styleName","championNameText");
      _loc1_.setStyle("paddingTop",2);
      return _loc1_;
   }
}
