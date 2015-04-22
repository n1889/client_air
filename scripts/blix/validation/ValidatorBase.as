package blix.validation
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import blix.model.ITextModel;
   
   public class ValidatorBase extends Object implements IValidator
   {
      
      private var _validated:Signal;
      
      private var _errors:Vector.<ValidationError>;
      
      public function ValidatorBase()
      {
         this._validated = new Signal();
         this._errors = new Vector.<ValidationError>();
         super();
      }
      
      public function getValidated() : ISignal
      {
         return this._validated;
      }
      
      public function getErrors() : Vector.<ValidationError>
      {
         return this._errors.slice();
      }
      
      public function validate() : Vector.<ValidationError>
      {
         this._errors.length = 0;
         this.doValidation();
         this._validated.dispatch(this,this._errors);
         return this._errors.slice();
      }
      
      protected function addError(param1:ITextModel) : void
      {
         this._errors[this._errors.length] = new ValidationError(this,param1);
      }
      
      protected function doValidation() : void
      {
      }
   }
}
