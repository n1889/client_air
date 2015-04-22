package com.riotgames.platform.gameclient.components.button
{
   import mx.core.UIComponent;
   import blix.signals.Signal;
   import flash.events.MouseEvent;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import flash.display.Bitmap;
   import blix.signals.ISignal;
   import mx.controls.Image;
   import com.riotgames.platform.common.provider.ISoundProvider;
   import com.riotgames.platform.common.audio.AudioKeys;
   import com.riotgames.platform.common.provider.SoundProviderProxy;
   
   public class ChromaSwatchButton extends UIComponent
   {
      
      public static const BORDER_SIZE:int = 2;
      
      public static const PADDING:int = 3;
      
      public static const DISABLED_BORDER_COLOR:int = 8421504;
      
      public static const UP_BORDER_COLOR:int = 3429877;
      
      public static const SELECTED_BORDER_COLOR:int = 16748544;
      
      public static const CORNER_RADIUS:int = 6;
      
      private var _selectionIndicator:UIComponent;
      
      private var _onSelectedChange:Signal;
      
      private var _mouseOverSoundKey:String = "";
      
      private var _isSelected:Boolean;
      
      private var _currentBorderColor:int;
      
      private var _mouseDownSoundKey:String = "";
      
      private var _dataProvider:ChampionSkin;
      
      private var _buttonSkin:Image;
      
      private var _soundManager:ISoundProvider;
      
      public function ChromaSwatchButton()
      {
         this._mouseDownSoundKey = AudioKeys.NEW_SOUND_SKIN_SCROLL;
         this._mouseOverSoundKey = AudioKeys.SOUND_MOUSE_OVER;
         this._buttonSkin = new Image();
         this._selectionIndicator = new UIComponent();
         this._onSelectedChange = new Signal();
         this._currentBorderColor = UP_BORDER_COLOR;
         this._isSelected = false;
         this._soundManager = SoundProviderProxy.instance;
         super();
         setStyle("paddingLeft",PADDING);
         setStyle("paddingRight",PADDING);
      }
      
      private function setDisabledColor() : void
      {
         this._currentBorderColor = DISABLED_BORDER_COLOR;
      }
      
      private function drawBorderRect() : void
      {
         with(this._selectionIndicator.graphics)
         {
            
            clear();
            beginFill(16711680,0);
            lineStyle(BORDER_SIZE,_currentBorderColor);
            drawRoundRect(0,0,_buttonSkin.width,_buttonSkin.height,CORNER_RADIUS);
            endFill();
         }
      }
      
      private function onButtonClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(!this._isSelected)
         {
            this._soundManager.playMouseDownButton(this._mouseDownSoundKey);
            this._onSelectedChange.dispatch(this);
            this.setOverRectColor();
            this.drawBorderRect();
         }
      }
      
      public function set mouseOverSoundKey(param1:String) : void
      {
         this._mouseOverSoundKey = param1;
      }
      
      public function set data(param1:Object) : void
      {
         this._dataProvider = ChampionSkin(param1);
      }
      
      private function onButtonOut(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if((enabled) && (!this._isSelected))
         {
            this.setUpRectColor();
            this.drawBorderRect();
         }
      }
      
      override protected function measure() : void
      {
         measuredWidth = this._buttonSkin.getExplicitOrMeasuredWidth();
         measuredHeight = this._buttonSkin.getExplicitOrMeasuredHeight();
      }
      
      public function onSwatchLoaded(param1:Bitmap) : void
      {
         this._buttonSkin.smoothBitmapContent = true;
         this._buttonSkin.source = param1;
         this._selectionIndicator.width = param1.bitmapData.width;
         this._selectionIndicator.height = param1.bitmapData.height;
         addChild(this._buttonSkin);
         addChild(this._selectionIndicator);
         invalidateSize();
         invalidateDisplayList();
      }
      
      private function onSelected() : void
      {
         this.setOverRectColor();
         this.disableInteractivity();
      }
      
      private function onEnabled() : void
      {
         this.setUpRectColor();
         this.enableInteractivity();
      }
      
      private function disableInteractivity() : void
      {
         mouseEnabled = false;
         buttonMode = false;
         removeEventListener(MouseEvent.CLICK,this.onButtonClick);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onButtonOut);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1)
         {
            this.onEnabled();
         }
         else
         {
            this.onDisabled();
         }
         super.enabled = param1;
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      private function enableInteractivity() : void
      {
         mouseEnabled = true;
         buttonMode = true;
         addEventListener(MouseEvent.CLICK,this.onButtonClick,false,0,true);
         addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onButtonOut,false,0,true);
      }
      
      private function setOverRectColor() : void
      {
         this._currentBorderColor = SELECTED_BORDER_COLOR;
      }
      
      public function get data() : Object
      {
         return this._dataProvider;
      }
      
      public function get selectedChange() : ISignal
      {
         return this._onSelectedChange;
      }
      
      private function onButtonOver(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if((enabled) && (!this._isSelected))
         {
            this._soundManager.playMouseOverButton(this._mouseOverSoundKey);
            this.setOverRectColor();
            this.drawBorderRect();
         }
      }
      
      private function setUpRectColor() : void
      {
         this._currentBorderColor = UP_BORDER_COLOR;
      }
      
      public function set mouseDownSoundKey(param1:String) : void
      {
         this._mouseDownSoundKey = param1;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1 != this._isSelected)
         {
            this._isSelected = param1;
            if(this._isSelected)
            {
               this.onSelected();
               this.drawBorderRect();
            }
            else
            {
               this.onEnabled();
               this.drawBorderRect();
            }
         }
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         this._buttonSkin.setActualSize(this._buttonSkin.getExplicitOrMeasuredWidth(),this._buttonSkin.getExplicitOrMeasuredHeight());
         this._buttonSkin.move(0,0);
         this.drawBorderRect();
         this._selectionIndicator.setActualSize(this._buttonSkin.getExplicitOrMeasuredWidth(),this._buttonSkin.getExplicitOrMeasuredHeight());
         this._selectionIndicator.move(0,0);
         super.updateDisplayList(param1,param2);
      }
      
      private function onDisabled() : void
      {
         this.setDisabledColor();
         this.disableInteractivity();
      }
   }
}
