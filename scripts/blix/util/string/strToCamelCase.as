package blix.util.string
{
   public function strToCamelCase(param1:String, param2:Boolean = true) : String
   {
      var param1:String = param1.replace(new RegExp("^[^a-zA-Z]+","g"),"");
      if(param2)
      {
         param1 = param1.charAt(0).toLowerCase() + param1.substr(1);
      }
      else
      {
         param1 = param1.charAt(0).toUpperCase() + param1.substr(1);
      }
      var _loc3_:RegExp = new RegExp("[^a-zA-Z0-9][a-z]","g");
      var _loc4_:Object = _loc3_.exec(param1);
      while(_loc4_ != null)
      {
         param1 = param1.substring(0,_loc4_.index) + param1.charAt(_loc4_.index + 1).toUpperCase() + param1.substring(_loc4_.index + 2,param1.length);
         _loc4_ = _loc3_.exec(param1);
      }
      param1 = param1.replace(new RegExp("[^a-zA-Z0-9]","g"),"");
      return param1;
   }
}
