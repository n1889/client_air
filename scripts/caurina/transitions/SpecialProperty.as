package caurina.transitions
{
   public class SpecialProperty extends Object
   {
      
      public var parameters:Array;
      
      public var getValue:Function;
      
      public var setValue:Function;
      
      public function SpecialProperty(p_getFunction:Function, p_setFunction:Function, p_parameters:Array = null)
      {
         super();
         getValue = p_getFunction;
         setValue = p_setFunction;
         parameters = p_parameters;
      }
      
      public function toString() : String
      {
         var value:String = null;
         value = "";
         value = value + "[SpecialProperty ";
         value = value + ("getValue:" + String(getValue));
         value = value + ", ";
         value = value + ("setValue:" + String(setValue));
         value = value + ", ";
         value = value + ("parameters:" + String(parameters));
         value = value + "]";
         return value;
      }
   }
}
