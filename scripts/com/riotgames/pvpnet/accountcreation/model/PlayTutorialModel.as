package com.riotgames.pvpnet.accountcreation.model
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class PlayTutorialModel extends Object
   {
      
      private var _tutorialTypeRequested:Signal;
      
      private var _tutorialTypeChanged:Signal;
      
      private var _playTutorialAnswered:Signal;
      
      public function PlayTutorialModel()
      {
         this._tutorialTypeRequested = new Signal();
         this._tutorialTypeChanged = new Signal();
         this._playTutorialAnswered = new Signal();
         super();
      }
      
      public function requestTutorialType() : void
      {
         this._tutorialTypeRequested.dispatch();
      }
      
      public function getTutorialTypeRequested() : ISignal
      {
         return this._tutorialTypeRequested;
      }
      
      public function set basicTutorialType(param1:Boolean) : void
      {
         this._tutorialTypeChanged.dispatch(param1);
      }
      
      public function getTutorialTypeChanged() : ISignal
      {
         return this._tutorialTypeChanged;
      }
      
      public function set playTutorial(param1:Boolean) : void
      {
         this._playTutorialAnswered.dispatch(param1);
      }
      
      public function getPlayTutorialAnswered() : ISignal
      {
         return this._playTutorialAnswered;
      }
   }
}
