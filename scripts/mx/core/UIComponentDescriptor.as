package mx.core
{
   public class UIComponentDescriptor extends ComponentDescriptor
   {
      
      public var effects:Array;
      
      public var stylesFactory:Function;
      
      mx_internal var instanceIndices:Array;
      
      mx_internal var repeaters:Array;
      
      mx_internal var repeaterIndices:Array;
      
      public function UIComponentDescriptor(descriptorProperties:Object)
      {
         super(descriptorProperties);
      }
      
      override public function toString() : String
      {
         return "UIComponentDescriptor_" + id;
      }
   }
}
