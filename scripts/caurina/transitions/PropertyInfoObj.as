package caurina.transitions
{
   public class PropertyInfoObj extends Object
   {
      
      public var modifierParameters:Array;
      
      public var valueComplete:Number;
      
      public var modifierFunction:Function;
      
      public var hasModifier:Boolean;
      
      public var valueStart:Number;
      
      public function PropertyInfoObj(p_valueStart:Number, p_valueComplete:Number, p_modifierFunction:Function, p_modifierParameters:Array)
      {
         super();
         valueStart = p_valueStart;
         valueComplete = p_valueComplete;
         hasModifier = Boolean(p_modifierFunction);
         modifierFunction = p_modifierFunction;
         modifierParameters = p_modifierParameters;
      }
      
      public function toString() : String
      {
         var returnStr:String = null;
         returnStr = "\n[PropertyInfoObj ";
         returnStr = returnStr + ("valueStart:" + String(valueStart));
         returnStr = returnStr + ", ";
         returnStr = returnStr + ("valueComplete:" + String(valueComplete));
         returnStr = returnStr + ", ";
         returnStr = returnStr + ("modifierFunction:" + String(modifierFunction));
         returnStr = returnStr + ", ";
         returnStr = returnStr + ("modifierParameters:" + String(modifierParameters));
         returnStr = returnStr + "]\n";
         return returnStr;
      }
      
      public function clone() : PropertyInfoObj
      {
         var nProperty:PropertyInfoObj = null;
         nProperty = new PropertyInfoObj(valueStart,valueComplete,modifierFunction,modifierParameters);
         return nProperty;
      }
   }
}
