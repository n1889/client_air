package com.riotgames.pvpnet.accountcreation.model
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class EloQuestionnaireModel extends Object
   {
      
      private var _pendingSkillLevelValueChanged:Signal;
      
      private var _skillLevelValueConfirmed:Signal;
      
      public function EloQuestionnaireModel()
      {
         this._pendingSkillLevelValueChanged = new Signal();
         this._skillLevelValueConfirmed = new Signal();
         super();
      }
      
      public function getPendingSkillLevelValueChanged() : ISignal
      {
         return this._pendingSkillLevelValueChanged;
      }
      
      public function set pendingSkillLevelValue(param1:String) : void
      {
         this._pendingSkillLevelValueChanged.dispatch(param1);
      }
      
      public function getSkillLevelValueConfirmed() : ISignal
      {
         return this._skillLevelValueConfirmed;
      }
      
      public function set skillLevelValue(param1:String) : void
      {
         this._skillLevelValueConfirmed.dispatch(param1);
      }
   }
}
