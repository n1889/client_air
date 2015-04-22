package caurina.transitions
{
   public class SpecialPropertySplitter extends Object
   {
      
      public var parameters:Array;
      
      public var splitValues:Function;
      
      public function SpecialPropertySplitter(p_splitFunction:Function, p_parameters:Array)
      {
         super();
         splitValues = p_splitFunction;
      }
      
      public function toString() : String
      {
         var value:String = null;
         value = "";
         value = value + "[SpecialPropertySplitter ";
         value = value + ("splitValues:" + String(splitValues));
         value = value + ", ";
         value = value + ("parameters:" + String(parameters));
         value = value + "]";
         return value;
      }
   }
}
