package blix.components.tooltip
{
   import blix.IDestructible;
   import flash.utils.Dictionary;
   import blix.assets.proxy.DisplayObjectContainerProxy;
   import blix.assets.proxy.InteractiveObjectProxy;
   import blix.frame.getEnterFrame;
   import flash.system.Capabilities;
   import flash.desktop.NativeDragManager;
   
   public class ToolTipManager extends Object implements IToolTipManager, IDestructible
   {
      
      protected var watched:Dictionary;
      
      protected var root:DisplayObjectContainerProxy;
      
      protected var currentToolTipInfo:ToolTipInfo;
      
      protected var currentToolTipHandler:IToolTipHandler;
      
      protected var currentTarget:InteractiveObjectProxy;
      
      protected var isShowingToolTip:Boolean;
      
      private var _defaultToolTipHandler:IToolTipHandler;
      
      protected var timeInc:Number = 41.0;
      
      protected var showCounter:Number = -1.0;
      
      protected var hideCounter:Number = -1.0;
      
      public function ToolTipManager(param1:DisplayObjectContainerProxy, param2:IToolTipHandler)
      {
         this.watched = new Dictionary(true);
         super();
         this.root = param1;
         this.setDefaultToolTipHandler(param2);
      }
      
      public function getDefaultToolTipHandler() : IToolTipHandler
      {
         return this._defaultToolTipHandler;
      }
      
      public function setDefaultToolTipHandler(param1:IToolTipHandler) : void
      {
         if(param1 == null)
         {
            throw new Error("default tool tip handler may not be null.");
         }
         else
         {
            this._defaultToolTipHandler = param1;
            return;
         }
      }
      
      public function assignToolTip(param1:InteractiveObjectProxy, param2:*, param3:IToolTipHandler = null) : void
      {
         this.unassignToolTip(param1);
         this.watched[param1] = new ToolTipInfo(param2,param3);
         param1.getMouseIsOverChanged().add(this.mouseIsOverChangedHandler);
         this.mouseIsOverChangedHandler(param1);
      }
      
      public function unassignToolTip(param1:InteractiveObjectProxy) : Boolean
      {
         if(!(param1 in this.watched))
         {
            return false;
         }
         delete this.watched[param1];
         true;
         param1.getMouseIsOverChanged().remove(this.mouseIsOverChangedHandler);
         if(this.currentTarget == param1)
         {
            this.setCurrentTarget(null);
         }
         return true;
      }
      
      private function mouseIsOverChangedHandler(param1:InteractiveObjectProxy) : void
      {
         if((param1.getMouseIsOver()) || (this.getPreserveToolTip()))
         {
            this.setCurrentTarget(param1);
         }
      }
      
      protected function setCurrentTarget(param1:InteractiveObjectProxy) : void
      {
         if(param1 == this.currentTarget)
         {
            return;
         }
         if(this.currentTarget != null)
         {
            if(this.isShowingToolTip)
            {
               this.currentToolTipHandler.destroyToolTip();
               this.isShowingToolTip = false;
            }
            this.currentToolTipInfo = null;
            getEnterFrame().remove(this.enterFrameHandler);
         }
         this.currentTarget = param1 as InteractiveObjectProxy;
         if(this.currentTarget != null)
         {
            if(this.currentTarget.getStage() == null)
            {
               return;
            }
            this.hideCounter = -1;
            this.timeInc = 1000 / this.currentTarget.getStage().frameRate;
            this.currentToolTipInfo = this.watched[this.currentTarget] as ToolTipManager;
            this.currentToolTipHandler = this.currentToolTipInfo.handler || this._defaultToolTipHandler;
            getEnterFrame().add(this.enterFrameHandler);
            this.enterFrameHandler();
         }
         else
         {
            this.showCounter = -1;
         }
      }
      
      private function enterFrameHandler() : void
      {
         if((this.currentTarget == null) || (this.currentToolTipInfo == null))
         {
            return;
         }
         var _loc1_:Number = this.currentToolTipHandler.getShowDelay();
         var _loc2_:Number = this.currentToolTipHandler.getHideDelay();
         if((this.currentTarget.getMouseIsOver()) || (this.getPreserveToolTip()))
         {
            if(this.hideCounter > -1)
            {
               this.hideCounter = this.hideCounter - this.timeInc;
            }
            if(this.showCounter < _loc1_)
            {
               this.showCounter = this.showCounter + this.timeInc;
            }
         }
         else
         {
            if(this.showCounter > -1)
            {
               this.showCounter = this.showCounter - this.timeInc;
            }
            if(this.hideCounter < _loc2_)
            {
               this.hideCounter = this.hideCounter + this.timeInc;
            }
         }
         if(this.hideCounter >= _loc2_)
         {
            this.setCurrentTarget(null);
         }
         else if(this.showCounter >= _loc1_)
         {
            if(!this.isShowingToolTip)
            {
               if((!(Capabilities.playerType == "Desktop")) || (!NativeDragManager.isDragging))
               {
                  this.currentToolTipHandler.createToolTip(this.root,this.currentToolTipInfo.data,this.currentTarget);
                  this.isShowingToolTip = true;
               }
            }
         }
         
      }
      
      private function getPreserveToolTip() : Boolean
      {
         return (this.isShowingToolTip) && (!(this.currentToolTipHandler == null)) && (this.currentToolTipHandler.getPreserveToolTip());
      }
      
      public function destroy() : void
      {
         var _loc1_:* = undefined;
         this.setCurrentTarget(null);
         for(_loc1_ in this.watched)
         {
            this.unassignToolTip(_loc1_);
         }
      }
   }
}

import blix.components.tooltip.IToolTipHandler;

class ToolTipInfo extends Object
{
   
   public var data;
   
   public var handler:IToolTipHandler;
   
   function ToolTipInfo(param1:*, param2:IToolTipHandler)
   {
      super();
      this.handler = param2;
      this.data = param1;
   }
}
