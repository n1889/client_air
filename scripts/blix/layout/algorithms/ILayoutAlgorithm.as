package blix.layout.algorithms
{
   import blix.signals.ISignal;
   import blix.layout.vo.SizeConstraints;
   import blix.layout.LayoutEntry;
   import flash.geom.Rectangle;
   
   public interface ILayoutAlgorithm
   {
      
      function getLayoutInvalidated() : ISignal;
      
      function getSizeConstraints(param1:Number, param2:Number, param3:Vector.<LayoutEntry>) : SizeConstraints;
      
      function updateLayout(param1:Number, param2:Number, param3:Vector.<LayoutEntry>) : Rectangle;
   }
}
