package blix.components.timeline
{
   import blix.action.BasicAction;
   import blix.signals.Signal;
   import blix.assets.proxy.ITimelineObject;
   import blix.signals.ISignal;
   import blix.util.math.clamp;
   import blix.frame.getEnterFrame;
   import blix.util.UIDUtil;
   
   public class TimelineAnimation extends BasicAction
   {
      
      public var fromFrame:uint = 0;
      
      public var toFrame:uint = 0;
      
      protected var _transitionProgressed:Signal;
      
      protected var _currentFrameProgress:int = 0;
      
      protected var _totalFrames:int = 0;
      
      protected var _currentRepetition:uint = 0;
      
      protected var _totalRepetitions:uint = 1;
      
      protected var _target:ITimelineObject;
      
      protected var _name:String;
      
      protected var _isPlaying:Boolean;
      
      public function TimelineAnimation(param1:ITimelineObject, param2:String = null)
      {
         this._transitionProgressed = new Signal();
         super(false);
         this._target = param1;
         this._name = param2 || "TimelineAnimation" + UIDUtil.getNextId();
         singleInvocation = false;
      }
      
      public function getCurrentFrame() : uint
      {
         if(this._currentFrameProgress >= this._totalFrames)
         {
            return this.toFrame;
         }
         if(this.fromFrame < this.toFrame)
         {
            return this.fromFrame + this._currentFrameProgress;
         }
         if(this.fromFrame > this.toFrame)
         {
            return this.fromFrame - this._currentFrameProgress;
         }
         return this.fromFrame;
      }
      
      public function getCurrentRepetition() : uint
      {
         return this._currentRepetition;
      }
      
      public function getTransitionProgressed() : ISignal
      {
         return this._transitionProgressed;
      }
      
      public function getTransitionProgress() : Number
      {
         if(!getHasBeenInvoked())
         {
            return 0.0;
         }
         if(getHasCompleted())
         {
            return 1;
         }
         var _loc1_:Number = this._currentFrameProgress / this._totalFrames;
         if((_loc1_ < 0.0) || (_loc1_ > 1))
         {
            return 0.0;
         }
         return _loc1_;
      }
      
      public function setTransitionProgress(param1:Number) : void
      {
         if(this.getRequiresInvocation())
         {
            invoke();
         }
         var param1:Number = clamp(param1,0.0,1);
         this._currentFrameProgress = param1 * this._totalFrames;
         this.updatePlayHead();
         this._transitionProgressed.dispatch(this,param1);
      }
      
      public function resume() : void
      {
         if((this._isPlaying) || (!((_isInvoking) || (getHasBeenInvoked()))) || (getIsFinished()))
         {
            return;
         }
         this._isPlaying = true;
         getEnterFrame().add(this.enterFrameHandler);
         this.updatePlayHead();
         if(this._transitionProgressed.getHasListeners())
         {
            this._transitionProgressed.dispatch(this,this.getTransitionProgress());
         }
      }
      
      public function pause() : void
      {
         if(!this._isPlaying)
         {
            return;
         }
         this._isPlaying = false;
         getEnterFrame().remove(this.enterFrameHandler);
         this.updatePlayHead();
         this._target.stop();
      }
      
      override protected function doInvocation() : void
      {
         this._currentRepetition = 0;
         this._currentFrameProgress = 0;
         this._totalFrames = Math.abs(this.toFrame - this.fromFrame) + 1;
         if((!this.toFrame) || (!this.fromFrame))
         {
            complete();
            return;
         }
         this.resume();
      }
      
      private function enterFrameHandler() : void
      {
         var _loc1_:Boolean = false;
         if(++this._currentFrameProgress >= this._totalFrames)
         {
            if(++this._currentRepetition < this._totalRepetitions)
            {
               this._currentFrameProgress = 0;
            }
            else
            {
               _loc1_ = true;
            }
         }
         this.updatePlayHead();
         if(this._transitionProgressed.getHasListeners())
         {
            this._transitionProgressed.dispatch(this,this.getTransitionProgress());
         }
         if(_loc1_)
         {
            complete();
         }
      }
      
      protected function updatePlayHead() : void
      {
         this._target.gotoAndStop(this.getCurrentFrame());
      }
      
      override protected function onCompleted() : void
      {
         this._currentFrameProgress = this._totalFrames;
         this.pause();
      }
      
      override protected function onAborted() : void
      {
         this.pause();
      }
      
      override protected function onErred(param1:Error) : void
      {
         this.pause();
      }
      
      public function setRepeatCount(param1:int) : void
      {
         if(param1 < 0)
         {
            var param1:int = 9999999;
         }
         this._currentRepetition = 0;
         this._totalRepetitions = Math.max(param1,1);
      }
      
      protected function getRequiresInvocation() : Boolean
      {
         return (!getIsInvoking()) && ((!getHasBeenInvoked()) || (getIsFinished()));
      }
      
      override public function destroy() : void
      {
         super.destroy();
         getEnterFrame().remove(this.enterFrameHandler);
         this._transitionProgressed.removeAll();
      }
      
      public function toString() : String
      {
         return "[TimelineAnimation name=" + this._name + " fromFrame=" + this.fromFrame + " toFrame=" + this.toFrame + "]";
      }
   }
}
