package blix.layout
{
   import blix.view.ILayoutElement;
   import blix.view.ILayoutData;
   
   public class LayoutEntry extends Object
   {
      
      public var element:ILayoutElement;
      
      public var data:ILayoutData;
      
      public function LayoutEntry(param1:ILayoutElement, param2:ILayoutData)
      {
         super();
         this.element = param1;
         this.data = param2;
      }
   }
}
