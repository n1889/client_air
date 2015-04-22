package com.riotgames.platform.common.commands
{
   import com.riotgames.platform.common.responder.Responder;
   import blix.IDestructible;
   import blix.signals.OnceSignal;
   import blix.signals.ISignal;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class CommandBase extends Responder implements ICommand, IDestructible
   {
      
      private var erredSignal:OnceSignal;
      
      protected var logger:ILogger;
      
      private var isOptional:Boolean = false;
      
      private var invokedSignal:OnceSignal;
      
      private var invokingSignal:OnceSignal;
      
      private var completedSignal:OnceSignal;
      
      private var abortedSignal:OnceSignal;
      
      private var isInvoking:Boolean = false;
      
      public function CommandBase(param1:Boolean = false)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this.completedSignal = new OnceSignal();
         this.invokingSignal = new OnceSignal();
         this.invokedSignal = new OnceSignal();
         this.erredSignal = new OnceSignal();
         this.abortedSignal = new OnceSignal();
         super();
         this.isOptional = param1;
      }
      
      protected function logResult(param1:Object) : void
      {
      }
      
      public function execute() : void
      {
         this.isInvoking = true;
         this.invokedSignal.dispatch(this);
         this.logExecute();
      }
      
      public function destroy() : void
      {
         this.completedSignal.removeAll();
         this.invokingSignal.removeAll();
         this.invokedSignal.removeAll();
         this.erredSignal.removeAll();
         this.abortedSignal.removeAll();
      }
      
      public function getErred() : ISignal
      {
         return this.erredSignal;
      }
      
      protected function logExecute() : void
      {
      }
      
      public function getAborted() : ISignal
      {
         return this.abortedSignal;
      }
      
      protected function logComplete(param1:Object) : void
      {
      }
      
      public function getHasBeenInvoked() : Boolean
      {
         return this.invokedSignal.getHasDispatched();
      }
      
      protected function logError(param1:Object) : void
      {
      }
      
      public function getIsOptional() : Boolean
      {
         return this.isOptional;
      }
      
      public function getCompleted() : ISignal
      {
         return this.completedSignal;
      }
      
      public function abort() : void
      {
         throw new Error("Unimplemented");
      }
      
      public function getInvoking() : ISignal
      {
         return this.invokingSignal;
      }
      
      override protected function onComplete(param1:Object = null) : void
      {
         this.logComplete(param1);
         this.isInvoking = false;
         super.onComplete(param1);
      }
      
      public function getIsFinished() : Boolean
      {
         return (this.getHasCompleted()) || (this.getHasErred()) || (this.getHasAborted());
      }
      
      public function getInvoked() : ISignal
      {
         return this.invokedSignal;
      }
      
      public function getHasErred() : Boolean
      {
         return this.erredSignal.getHasDispatched();
      }
      
      public function getHasAborted() : Boolean
      {
         return this.abortedSignal.getHasDispatched();
      }
      
      public function getHasCompleted() : Boolean
      {
         return this.completedSignal.getHasDispatched();
      }
      
      public function reset() : void
      {
         throw new Error("Unimplemented");
      }
      
      public function getError() : Error
      {
         throw new Error("Unimplemented.");
      }
      
      override protected function onResult(param1:Object = null) : void
      {
         this.logResult(param1);
         this.completedSignal.dispatch(this);
         super.onResult(param1);
      }
      
      override public function addResponder(param1:Function, param2:Function = null, param3:Function = null) : void
      {
         super.addResponder(param1,param2,param3);
      }
      
      override protected function onError(param1:Object = null) : void
      {
         this.logError(param1);
         this.erredSignal.dispatch(this);
         super.onError(param1);
      }
      
      public function getIsInvoking() : Boolean
      {
         return this.isInvoking;
      }
      
      public function invoke() : void
      {
         this.execute();
      }
   }
}
