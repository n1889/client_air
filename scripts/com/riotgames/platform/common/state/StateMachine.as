package com.riotgames.platform.common.state
{
   import blix.signals.Signal;
   import flash.utils.Dictionary;
   import blix.signals.ISignal;
   
   public class StateMachine extends Object implements IStateMachine
   {
      
      private var _stateChanged:Signal;
      
      private var _states:Dictionary;
      
      private var _currentState:IState = null;
      
      public function StateMachine()
      {
         this._states = new Dictionary();
         this._stateChanged = new Signal();
         super();
      }
      
      public function changeState(param1:String) : void
      {
         var _loc2_:IState = this.getState(param1);
         if(_loc2_ == null)
         {
            return;
         }
         this.currentState = _loc2_;
      }
      
      public function onUpdate() : void
      {
         if(this._currentState)
         {
            this._currentState.onUpdate();
         }
      }
      
      protected function get states() : Dictionary
      {
         return this._states;
      }
      
      public function getStateChanged() : ISignal
      {
         return this._stateChanged;
      }
      
      protected function getState(param1:String) : IState
      {
         return this._states[param1];
      }
      
      public function hasState(param1:IState) : Boolean
      {
         return !(param1 == null)?!(this.getState(param1.name) == null):false;
      }
      
      public function get currentState() : IState
      {
         return this._currentState;
      }
      
      public function removeState(param1:String) : IState
      {
         var _loc2_:IState = null;
         if(this._states[param1] != null)
         {
            _loc2_ = this._states[param1];
            delete this._states[param1];
            true;
         }
         return _loc2_;
      }
      
      public function set currentState(param1:IState) : void
      {
         if(!this.hasState(param1))
         {
            throw new Error("Cannot set state. The supplied state is undefined.");
         }
         else
         {
            this.transitionState(this.currentState,param1);
            return;
         }
      }
      
      public function addState(param1:IState) : void
      {
         if((!param1) || (!param1.name))
         {
            return;
         }
         if(this._states[param1.name] == null)
         {
            this._states[param1.name] = param1;
            return;
         }
         throw new Error("State already exists for name: " + param1.name);
      }
      
      public function destroy() : void
      {
         var _loc1_:IState = null;
         for each(_loc1_ in this._states)
         {
            _loc1_.destroy();
         }
      }
      
      protected function transitionState(param1:IState, param2:IState) : void
      {
         if(param1 != null)
         {
            param1.onExit();
         }
         this._currentState = param2;
         if(this._currentState != null)
         {
            this._currentState.onEnter();
         }
         this._stateChanged.dispatch(param1,param2);
      }
   }
}
