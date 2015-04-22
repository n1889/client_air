package blix.layout.data
{
   import blix.view.ILayoutData;
   import blix.layout.vo.Size;
   
   public interface ISizeLayoutData extends ILayoutData
   {
      
      function getVerticalAlign() : uint;
      
      function getHorizontalAlign() : uint;
      
      function getWidthInfo(param1:Number) : Size;
      
      function getHeightInfo(param1:Number) : Size;
   }
}
