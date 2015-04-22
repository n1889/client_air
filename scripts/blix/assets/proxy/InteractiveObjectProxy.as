package blix.assets.proxy
{
   import blix.signals.Signal;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import blix.signals.ISignal;
   import flash.accessibility.AccessibilityImplementation;
   import flash.geom.Rectangle;
   import blix.context.IContext;
   
   public class InteractiveObjectProxy extends DisplayObjectProxy
   {
      
      private var _mouseIsOverChanged:Signal;
      
      private var _mouseIsDownChanged:Signal;
      
      protected var _interactiveAsset:InteractiveObject;
      
      protected var _mouseIsDown:Boolean;
      
      protected var _mouseIsOver:Boolean;
      
      protected var _ownerStage:Stage;
      
      public function InteractiveObjectProxy(param1:IContext, param2:InteractiveObject = null)
      {
         this._mouseIsOverChanged = new Signal();
         this._mouseIsDownChanged = new Signal();
         super(param1,param2);
         addEventListener(MouseEvent.ROLL_OVER,this.rollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
         getIsOnStageChanged().add(this._isOnStageChangedHandler);
      }
      
      private function _isOnStageChangedHandler() : void
      {
         if(!getIsOnStage())
         {
            this.setMouseIsOver(false);
            this.setMouseIsDown(false);
         }
      }
      
      override protected function configureAsset(param1:DisplayObject) : void
      {
         super.configureAsset(param1);
         this._interactiveAsset = param1 as InteractiveObject;
      }
      
      override protected function setIsOnStage(param1:Boolean) : void
      {
         if(_isOnStage == param1)
         {
            return;
         }
         super.setIsOnStage(param1);
         if(_stage != null)
         {
            this.removeStageMouseDownHandlers();
            this.removeStageRollOutHandlers();
            if(_stage.hasOwnProperty("nativeWindow"))
            {
               if((_stage["nativeWindow"].hasOwnProperty("owner")) && (!(_stage["nativeWindow"].owner == null)))
               {
                  this._ownerStage = _stage["nativeWindow"].owner.stage;
               }
            }
            if(this._ownerStage == null)
            {
               this._ownerStage = _stage;
            }
         }
         if((param1) && (this.getMouseIsDown()))
         {
            this.addStageMouseDownHandlers();
         }
      }
      
      public function getInteractiveAsset() : InteractiveObject
      {
         return this._interactiveAsset;
      }
      
      protected function rollOverHandler(param1:MouseEvent) : void
      {
         if(_stage != null)
         {
            this.setMouseIsOver(true);
            this.addStageRollOutHandlers();
         }
      }
      
      protected function rollOutHandler(param1:MouseEvent) : void
      {
         if(_stage != null)
         {
            this.removeStageRollOutHandlers();
            this.setMouseIsOver(false);
         }
      }
      
      protected function mouseDownHandler(param1:MouseEvent) : void
      {
         if(_stage != null)
         {
            this.setMouseIsDown(true);
            this.addStageMouseDownHandlers();
         }
      }
      
      private function addStageMouseDownHandlers() : void
      {
         if(this._ownerStage)
         {
            this._ownerStage.addEventListener(MouseEvent.MOUSE_UP,this.stageMouseUpHandler,false,0,true);
            this._ownerStage.addEventListener(Event.DEACTIVATE,this.stageMouseUpHandler,false,0,true);
         }
         _stage.addEventListener(MouseEvent.MOUSE_UP,this.stageMouseUpHandler,false,0,true);
         _stage.addEventListener(Event.DEACTIVATE,this.stageMouseUpHandler,false,0,true);
      }
      
      private function removeStageMouseDownHandlers() : void
      {
         if(this._ownerStage)
         {
            this._ownerStage.removeEventListener(MouseEvent.MOUSE_UP,this.stageMouseUpHandler);
            this._ownerStage.removeEventListener(Event.DEACTIVATE,this.stageMouseUpHandler);
         }
         if(_stage != null)
         {
            _stage.removeEventListener(MouseEvent.MOUSE_UP,this.stageMouseUpHandler);
            _stage.removeEventListener(Event.DEACTIVATE,this.stageMouseUpHandler);
         }
      }
      
      protected function stageMouseUpHandler(param1:Event) : void
      {
         this.removeStageMouseDownHandlers();
         this.setMouseIsDown(false);
      }
      
      private function addStageRollOutHandlers() : void
      {
         if(_stage != null)
         {
            _stage.addEventListener(Event.DEACTIVATE,this.stageRollOutHandler,false,0,true);
            _stage.addEventListener(Event.MOUSE_LEAVE,this.stageRollOutHandler,false,0,true);
         }
      }
      
      private function removeStageRollOutHandlers() : void
      {
         if(_stage != null)
         {
            _stage.removeEventListener(Event.DEACTIVATE,this.stageRollOutHandler);
            _stage.removeEventListener(Event.MOUSE_LEAVE,this.stageRollOutHandler);
         }
      }
      
      private function stageRollOutHandler(param1:Event) : void
      {
         this.removeStageMouseDownHandlers();
         this.setMouseIsOver(false);
         this.setMouseIsDown(false);
      }
      
      public function getMouseIsOverChanged() : ISignal
      {
         return this._mouseIsOverChanged;
      }
      
      public function getMouseIsOver() : Boolean
      {
         return this._mouseIsOver;
      }
      
      protected function setMouseIsOver(param1:Boolean) : void
      {
         if(this._mouseIsOver == param1)
         {
            return;
         }
         this._mouseIsOver = param1;
         this._mouseIsOverChanged.dispatch(this);
      }
      
      public function getMouseIsDownChanged() : ISignal
      {
         return this._mouseIsDownChanged;
      }
      
      public function getMouseIsDown() : Boolean
      {
         return this._mouseIsDown;
      }
      
      protected function setMouseIsDown(param1:Boolean) : void
      {
         if(this._mouseIsDown == param1)
         {
            return;
         }
         this._mouseIsDown = param1;
         this._mouseIsDownChanged.dispatch(this);
      }
      
      public function getAccessibilityImplementation() : AccessibilityImplementation
      {
         return assetProxy.accessibilityImplementation;
      }
      
      public function setAccessibilityImplementation(param1:AccessibilityImplementation) : void
      {
         assetProxy.accessibilityImplementation = param1;
      }
      
      public function getDoubleClickEnabled() : Boolean
      {
         return assetProxy.doubleClickEnabled;
      }
      
      public function setDoubleClickEnabled(param1:Boolean) : void
      {
         assetProxy.doubleClickEnabled = param1;
      }
      
      public function getFocusRect() : Object
      {
         return assetProxy.focusRect;
      }
      
      public function setFocusRect(param1:Object) : void
      {
         assetProxy.focusRect = param1;
      }
      
      public function getMouseEnabled() : Boolean
      {
         return assetProxy.mouseEnabled;
      }
      
      public function setMouseEnabled(param1:Boolean) : void
      {
         assetProxy.mouseEnabled = param1;
      }
      
      public function getNeedsSoftKeyboard() : Boolean
      {
         return assetProxy.needsSoftKeyboard;
      }
      
      public function setNeedsSoftKeyboard(param1:Boolean) : void
      {
         assetProxy.needsSoftKeyboard = param1;
      }
      
      public function getSoftKeyboardInputAreaOfInterest() : Rectangle
      {
         return assetProxy.softKeyboardInputAreaOfInterest;
      }
      
      public function setSoftKeyboardInputAreaOfInterest(param1:Rectangle) : void
      {
         assetProxy.softKeyboardInputAreaOfInterest = param1;
      }
      
      public function getTabEnabled() : Boolean
      {
         return assetProxy.tabEnabled;
      }
      
      public function setTabEnabled(param1:Boolean) : void
      {
         assetProxy.tabEnabled = param1;
      }
      
      public function getTabIndex() : int
      {
         return assetProxy.tabIndex;
      }
      
      public function setTabIndex(param1:int) : void
      {
         assetProxy.tabIndex = param1;
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this._mouseIsDownChanged.removeAll();
         this._mouseIsOverChanged.removeAll();
      }
   }
}
