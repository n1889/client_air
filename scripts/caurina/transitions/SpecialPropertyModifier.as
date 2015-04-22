package caurina.transitions
{
   public class SpecialPropertyModifier extends Object
   {
      
      public var getValue:Function;
      
      public var modifyValues:Function;
      
      public function SpecialPropertyModifier(p_modifyFunction:Function, p_getFunction:Function)
      {
         super();
         modifyValues = p_modifyFunction;
         getValue = p_getFunction;
      }
      
      public function toString() : String
      {
         var value:String = null;
         value = "";
         value = value + "[SpecialPropertyModifier ";
         value = value + ("modifyValues:" + String(modifyValues));
         value = value + ", ";
         value = value + ("getValue:" + String(getValue));
         value = value + "]";
         return value;
      }
   }
}
