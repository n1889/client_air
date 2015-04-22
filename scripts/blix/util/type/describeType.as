package blix.util.type
{
   public function describeType(param1:Object, param2:Boolean = false) : XML
   {
      if(!(param1 is Class))
      {
         var param1:Object = getType(param1);
      }
      if((param2) || (typeCache[param1] == null))
      {
         typeCache[param1] = describeType(param1);
      }
      return typeCache[param1];
   }
}
