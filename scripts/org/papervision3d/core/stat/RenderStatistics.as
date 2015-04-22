package org.papervision3d.core.stat
{
   public class RenderStatistics extends Object
   {
      
      public var points:int = 0;
      
      public var polys:int = 0;
      
      public var triangles:int = 0;
      
      public var particles:Number;
      
      public var performance:int = 0;
      
      public var rendered:int = 0;
      
      public var culledTriangles:int = 0;
      
      public var lines:Number;
      
      public function RenderStatistics()
      {
         performance = 0;
         points = 0;
         polys = 0;
         rendered = 0;
         triangles = 0;
         culledTriangles = 0;
         super();
      }
      
      public function toString() : String
      {
         return new String("Performance:" + performance + ", Points:" + points + " Polys:" + polys + " Rendered:" + rendered + " Culled:" + culledTriangles);
      }
      
      public function clear() : void
      {
         performance = 0;
         points = 0;
         polys = 0;
         rendered = 0;
         triangles = 0;
         particles = 0;
         culledTriangles = 0;
         lines = 0;
      }
   }
}
