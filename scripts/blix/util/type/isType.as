package blix.util.type
{
   public function isType(param1:Object, param2:Class) : Boolean
   {
      var value:Object = param1;
      var type:Class = param2;
      if(!(value is Class))
      {
         return value is type;
      }
      if(value == type)
      {
         return true;
      }
      var inheritance:XMLList = describeType(value).factory.*.((localName() == "extendsClass") || (localName() == "implementsInterface"));
      return Boolean(inheritance.(@type == getQualifiedClassName(type)).length() > 0);
   }
}
