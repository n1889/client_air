package org.papervision3d.materials
{
   import org.papervision3d.core.proto.MaterialObject3D;
   import org.papervision3d.core.render.draw.ITriangleDrawer;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import flash.display.Graphics;
   import org.papervision3d.core.render.data.RenderSessionData;
   
   public class TriangleMaterial extends MaterialObject3D implements ITriangleDrawer
   {
      
      public function TriangleMaterial()
      {
         super();
      }
      
      override public function drawTriangle(face3D:Triangle3D, graphics:Graphics, renderSessionData:RenderSessionData) : void
      {
      }
   }
}
