package com.riotgames.platform.provider
{
   import blix.signals.OnceSignal;
   import blix.signals.IOnceSignal;
   
   public class ProviderLookupEntry extends Object
   {
      
      private var _requested:OnceSignal;
      
      private var _published:OnceSignal;
      
      private var _failed:OnceSignal;
      
      public function ProviderLookupEntry()
      {
         this._requested = new OnceSignal();
         this._published = new OnceSignal();
         this._failed = new OnceSignal();
         super();
      }
      
      public function getRequested() : IOnceSignal
      {
         return this._requested;
      }
      
      public function getPublished() : IOnceSignal
      {
         return this._published;
      }
      
      public function getFailed() : IOnceSignal
      {
         return this._failed;
      }
      
      public function request() : void
      {
         this._requested.dispatch();
      }
      
      public function publish(param1:IProvider) : void
      {
         if(this._failed.getHasDispatched())
         {
            throw new Error("Cannot publish after fail.");
         }
         else
         {
            this._failed.removeAll();
            this._published.dispatch(param1);
            return;
         }
      }
      
      public function fail(param1:Error) : void
      {
         if(this._published.getHasDispatched())
         {
            throw new Error("Cannot fail after publish.");
         }
         else
         {
            this._published.removeAll();
            this._failed.dispatch(param1);
            return;
         }
      }
   }
}
