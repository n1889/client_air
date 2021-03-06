package com.riotgames.platform.common.validators
{
   import mx.validators.RegExpValidator;
   import mx.validators.ValidationResult;
   
   public class RegExpInputValidator extends RegExpValidator
   {
      
      public function RegExpInputValidator()
      {
         super();
      }
      
      override protected function doValidation(param1:Object) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = super.doValidation(param1);
         if(_loc2_.length > 0)
         {
            if(param1 == null)
            {
               var param1:Object = getValueFromSource();
            }
            if(param1 == "")
            {
               _loc3_ = requiredFieldError.length?requiredFieldError:resourceManager.getString("resources","validator_requiredErrorMessage");
               _loc2_.push(new ValidationResult(true,null,"invalid",_loc3_));
            }
         }
         return _loc2_;
      }
   }
}
