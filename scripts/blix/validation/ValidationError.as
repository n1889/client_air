package blix.validation
{
   import blix.model.ITextModel;
   
   public class ValidationError extends Object
   {
      
      public var target:IValidator;
      
      public var validationError:ITextModel;
      
      public function ValidationError(param1:IValidator, param2:ITextModel = null)
      {
         super();
         this.target = param1;
         this.validationError = param2;
      }
   }
}
