package org.papervision3d.core.render
{
   import org.papervision3d.core.render.command.IRenderListItem;
   import org.papervision3d.core.stat.RenderStatistics;
   import org.papervision3d.core.proto.SceneObject3D;
   import flash.display.Sprite;
   import org.papervision3d.core.proto.CameraObject3D;
   import org.papervision3d.core.render.hit.RenderHitData;
   import flash.geom.Point;
   
   public interface IRenderEngine
   {
      
      function addToRenderList(param1:IRenderListItem) : int;
      
      function removeFromRenderList(param1:IRenderListItem) : int;
      
      function render(param1:SceneObject3D, param2:Sprite, param3:CameraObject3D) : RenderStatistics;
      
      function hitTestPoint2D(param1:Point) : RenderHitData;
   }
}
