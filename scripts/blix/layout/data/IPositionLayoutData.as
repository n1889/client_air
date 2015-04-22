package blix.layout.data
{
   import blix.view.ILayoutData;
   import blix.layout.vo.Size;
   
   public interface IPositionLayoutData extends ILayoutData
   {
      
      function getXInfo(param1:Number) : Size;
      
      function getYInfo(param1:Number) : Size;
   }
}
