package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import mx.core.IUIComponent;
   import com.greensock.easing.*;
   import com.greensock.*;
   import flash.events.MouseEvent;
   
   public dynamic class ChampionSelect extends MyUIMovieClip
   {
      
      public static const STATE_LIGHT_GREY:String = "stateLightGrey";
      
      public static const STATE_LIGHT_GREY_ARROWS_RIGHT:String = "stateLightGreyArrowsRight";
      
      public static const STATE_LIGHT_GREY_ARROWS_LEFT:String = "stateLightGreyArrowsLeft";
      
      public static const STATE_DARK_GREY:String = "stateDarkGrey";
      
      public static const STATE_ORANGE_ARROWS_RIGHT:String = "stateOrangeArrowsRight";
      
      public static const STATE_ORANGE_ARROWS_LEFT:String = "stateOrangeArrowsLeft";
      
      public static const STATE_BLUE:String = "stateBlue";
      
      public static const STATE_BLUE_ARROWS_RIGHT:String = "stateBlueArrowsRight";
      
      public static const STATE_BLUE_ARROWS_LEFT:String = "stateBlueArrowsLeft";
      
      public static const STATE_FADE_NONE:String = "default";
      
      public static const STATE_FADE:String = "fade";
      
      public static const FADE_LEFT:String = "fadeLeft";
      
      public static const FADE_RIGHT:String = "fadeRight";
      
      public var bg_mc:MovieClip;
      
      public var slotName_mc:TextFieldMovieClip;
      
      public var slotRating_mc:TextFieldMovieClip;
      
      public var cs_slotItem0:SlotItem;
      
      public var boundingBox:MovieClip;
      
      private var _fadeDirection:String = "default";
      
      private var _championHighlighted:Boolean = false;
      
      private var _scaleRatio:Number;
      
      private var _slotName:String;
      
      private var _slotRating:String;
      
      private var _animateFlag:Boolean = true;
      
      private var _active:Boolean;
      
      private var _disableGlow:Boolean = false;
      
      public function ChampionSelect()
      {
         addFrameScript(0,this.frame1);
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(evt:Event) : void
      {
         this.init();
      }
      
      public function init() : void
      {
         this.gotoState(STATE_DARK_GREY);
      }
      
      public function setSlotItem(compIdx:uint, champImg:IUIComponent, img0:IUIComponent, img1:IUIComponent) : void
      {
         var compName:String = "cs_slotItem" + compIdx;
         this[compName].setSlotItem(champImg,img0,img1);
      }
      
      public function setText(slotRating:String, slotName:String) : void
      {
         this.slotRating_mc.labelName = slotRating;
         this.slotName_mc.labelName = slotName;
      }
      
      private function onTradeButtonOver(evt:MouseEvent) : void
      {
         this.dispatchEvent(new Event("tradeButtonOver"));
      }
      
      private function onTradeButtonOut(evt:MouseEvent) : void
      {
         this.dispatchEvent(new Event("tradeButtonOut"));
      }
      
      private function onTradeButtonClicked(evt:MouseEvent) : void
      {
         this.dispatchEvent(new Event("tradeButtonClicked"));
      }
      
      public function set championImg(value:IUIComponent) : void
      {
         this.cs_slotItem0.setComp(this.cs_slotItem0.championImg,value);
      }
      
      public function set spellImg0(value:IUIComponent) : void
      {
         this.cs_slotItem0.setComp(this.cs_slotItem0.spellImg0,value);
      }
      
      public function set spellImg1(value:IUIComponent) : void
      {
         this.cs_slotItem0.setComp(this.cs_slotItem0.spellImg1,value);
      }
      
      public function set slotName(value:String) : void
      {
         this._slotName = value;
         this.slotName_mc.labelName = value;
      }
      
      public function get slotName() : String
      {
         return this._slotName;
      }
      
      public function set slotRating(value:String) : void
      {
         this._slotRating = value;
         this.slotRating_mc.labelName = value;
      }
      
      public function get slotRating() : String
      {
         return this._slotRating;
      }
      
      public function set active(isTrue:Boolean) : void
      {
         this._active = isTrue;
      }
      
      public function get active() : Boolean
      {
         return this._active;
      }
      
      public function set animateFlag(value:Boolean) : void
      {
         this._animateFlag = value;
      }
      
      public function get animateFlag() : Boolean
      {
         return this._animateFlag;
      }
      
      public function set championHighlighted(value:Boolean) : void
      {
         this._championHighlighted = value;
      }
      
      public function get championHighlighted() : Boolean
      {
         return this._championHighlighted;
      }
      
      public function set fadeDirection(value:String) : void
      {
         if(value == null)
         {
            var value:String = STATE_FADE_NONE;
         }
         this._fadeDirection = value;
      }
      
      public function get fadeDirection() : String
      {
         return this._fadeDirection;
      }
      
      public function set disableGlow(value:Boolean) : void
      {
         this._disableGlow = value;
      }
      
      public function get disableGlow() : Boolean
      {
         return this._disableGlow;
      }
      
      override public function set currentState(value:String) : void
      {
         this.cs_slotItem0.currentState = value;
         this.gotoState(value,this._animateFlag);
      }
      
      public function gotoState(value:String, shouldAnimate:Boolean = false) : void
      {
         switch(value)
         {
            case STATE_BLUE:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.orange_bg]);
               this.fadeMoviesIn([this.bg_mc.blue_bg]);
               this.removeGlowTween();
               TweenLite.from(this,shouldAnimate?0.6:0,{
                  "scaleX":1.1,
                  "scaleY":1.1,
                  "alpha":1,
                  "ease":Bounce.easeOut
               });
               break;
            case STATE_BLUE_ARROWS_RIGHT:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(true,"loop");
               this.fadeMoviesOut([this.bg_mc.orange_bg]);
               this.fadeMoviesIn([this.bg_mc.blue_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
            case STATE_BLUE_ARROWS_LEFT:
               this.fadeLeftArrows(true,"loop");
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.orange_bg]);
               this.fadeMoviesIn([this.bg_mc.blue_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
            case STATE_DARK_GREY:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.orange_bg,this.bg_mc.blue_bg]);
               this.removeGlowTween();
               break;
            case STATE_ORANGE_ARROWS_RIGHT:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(true,"loop");
               this.fadeMoviesOut([this.bg_mc.blue_bg]);
               this.fadeMoviesIn([this.bg_mc.orange_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
            case STATE_ORANGE_ARROWS_LEFT:
               this.fadeLeftArrows(true,"loop");
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.blue_bg]);
               this.fadeMoviesIn([this.bg_mc.orange_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
            case STATE_LIGHT_GREY:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.orange_bg,this.bg_mc.blue_bg]);
               TweenMax.to(this.bg_mc,shouldAnimate?0.5:0,{"colorMatrixFilter":{
                  "colorize":16777215,
                  "amount":0.6,
                  "brightness":3
               }});
               TweenMax.delayedCall(0.3,this.decreaseGlow);
               break;
            case STATE_LIGHT_GREY_ARROWS_RIGHT:
               this.fadeLeftArrows(false);
               this.fadeRightArrows(true);
               this.fadeMoviesOut([this.bg_mc.orange_bg,this.bg_mc.blue_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
            case STATE_LIGHT_GREY_ARROWS_LEFT:
               this.fadeLeftArrows(true);
               this.fadeRightArrows(false);
               this.fadeMoviesOut([this.bg_mc.orange_bg,this.bg_mc.blue_bg]);
               this.temporaryFlashGlow(shouldAnimate);
               break;
         }
         this.fadeSheen();
         this.fadeBackgroundMask();
         if(this._scaleRatio != 1)
         {
            this.scaleMovie(this,1,shouldAnimate?0.6:0);
         }
      }
      
      private function fadeLeftArrows(show:Boolean, playState:String = null) : void
      {
         this.fadeArrows(show,this.bg_mc.arrows_left_start,this.bg_mc.arrows_left_finish,playState);
      }
      
      private function fadeRightArrows(show:Boolean, playState:String = null) : void
      {
         this.fadeArrows(show,this.bg_mc.arrows_right_start,this.bg_mc.arrows_right_finish,playState);
      }
      
      private function fadeArrows(show:Boolean, startArrow:MovieClip, finishArrow:MovieClip, playState:String) : void
      {
         var shownArrow:MovieClip = null;
         var notShownArrow:MovieClip = null;
         if(show)
         {
            shownArrow = (this.fadeDirection == FADE_LEFT) || (this.fadeDirection == FADE_RIGHT)?finishArrow:startArrow;
            notShownArrow = shownArrow == finishArrow?startArrow:finishArrow;
            this.fadeMoviesIn([shownArrow]);
            this.fadeMoviesOut([notShownArrow]);
            notShownArrow.gotoAndStop("static");
            if(playState != null)
            {
               shownArrow.gotoAndPlay(playState);
            }
            else
            {
               shownArrow.gotoAndStop("static");
            }
         }
         else
         {
            this.fadeMoviesOut([startArrow,finishArrow]);
            startArrow.gotoAndStop("static");
            finishArrow.gotoAndStop("static");
         }
      }
      
      private function fadeSheen() : void
      {
         var shownSheen:MovieClip = null;
         var notShownSheen:MovieClip = null;
         if((this.championHighlighted) && ((this.fadeDirection == FADE_LEFT) || (this.fadeDirection == FADE_RIGHT)))
         {
            shownSheen = this.fadeDirection == FADE_LEFT?this.cs_slotItem0.sheen_left_finish:this.cs_slotItem0.sheen_right_finish;
            notShownSheen = shownSheen == this.cs_slotItem0.sheen_left_finish?this.cs_slotItem0.sheen_right_finish:this.cs_slotItem0.sheen_left_finish;
            this.fadeMoviesIn([shownSheen]);
            this.fadeMoviesOut([notShownSheen]);
            shownSheen.gotoAndPlay("loop");
            notShownSheen.gotoAndStop("static");
         }
         else
         {
            this.fadeMoviesOut([this.cs_slotItem0.sheen_left_finish,this.cs_slotItem0.sheen_right_finish]);
         }
      }
      
      private function fadeBackgroundMask() : void
      {
         if((this.fadeDirection == FADE_LEFT) || (this.fadeDirection == FADE_RIGHT))
         {
            this.bg_mc.fade_bg.gotoAndStop(STATE_FADE);
         }
         else
         {
            this.bg_mc.fade_bg.gotoAndStop(STATE_FADE_NONE);
         }
      }
      
      private function temporaryFlashGlow(shouldAnimate:Boolean) : void
      {
         if(!this.disableGlow)
         {
            TweenMax.to(this.bg_mc,shouldAnimate?0.5:0,{"colorMatrixFilter":{
               "colorize":16777215,
               "amount":0.6,
               "brightness":3
            }});
            TweenMax.delayedCall(0.3,this.removeGlowTween);
         }
      }
      
      private function removeGlowTween() : void
      {
         TweenMax.to(this.bg_mc,0.5,{"colorMatrixFilter":{}});
      }
      
      private function decreaseGlow() : void
      {
         TweenMax.to(this.bg_mc,0.5,{"colorMatrixFilter":{
            "colorize":16777215,
            "amount":1,
            "brightness":1.35
         }});
      }
      
      private function fadeMoviesIn(movieClips:Array) : void
      {
         var movieClip:MovieClip = null;
         for each(movieClip in movieClips)
         {
            movieClip.alpha = 1;
         }
      }
      
      private function fadeMoviesOut(movieClips:Array) : void
      {
         var movieClip:MovieClip = null;
         for each(movieClip in movieClips)
         {
            movieClip.alpha = 0;
         }
      }
      
      private function scaleMovie(mc:MovieClip, targetValue:Number, duration:Number) : void
      {
         TweenLite.to(mc,duration,{
            "scaleX":targetValue,
            "scaleY":targetValue,
            "alpha":1,
            "ease":Elastic.easeOut
         });
         this._scaleRatio = targetValue;
      }
      
      override public function get measuredWidth() : Number
      {
         return this.boundingBox.width;
      }
      
      override public function get measuredHeight() : Number
      {
         return this.boundingBox.width;
      }
      
      override public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         if((!(newWidth == _width)) || (!(newHeight == _height)))
         {
            _width = newWidth;
            _height = newHeight;
         }
      }
      
      function frame1() : *
      {
      }
   }
}
