package blix.util.string
{
   public function strTrim(param1:String) : String
   {
      if(!param1)
      {
         return param1;
      }
      return param1.replace(new RegExp("^\\s+|\\s+$","g"),"");
   }
}
