package com.riotgames.platform.common.state
{
   public class State extends Object implements IState
   {
      
      private var _name:String = null;
      
      public function State(param1:String = null)
      {
         super();
         this._name = param1;
      }
      
      public function onEnter() : void
      {
      }
      
      public function onExit() : void
      {
      }
      
      public function onUpdate() : void
      {
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function destroy() : void
      {
         this.onExit();
      }
   }
}
