package org.papervision3d.core.render.command
{
   import org.papervision3d.core.render.draw.ITriangleDrawer;
   import org.papervision3d.core.render.hit.RenderHitData;
   import flash.geom.Point;
   import org.papervision3d.core.geom.renderables.Vertex3DInstance;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import org.papervision3d.core.Number3D;
   import org.papervision3d.core.proto.MaterialObject3D;
   import flash.display.Sprite;
   import flash.display.BitmapData;
   import org.papervision3d.materials.BitmapMaterial;
   import org.papervision3d.core.Matrix3D;
   import org.papervision3d.core.render.data.RenderSessionData;
   
   public class RenderTriangle extends RenderableListItem implements IRenderListItem
   {
      
      public var renderer:ITriangleDrawer;
      
      public var triangle:Triangle3D;
      
      private var position:Number3D;
      
      public var renderMat:MaterialObject3D;
      
      public var container:Sprite;
      
      public function RenderTriangle(triangle:Triangle3D)
      {
         position = new Number3D();
         super();
         this.triangle = triangle;
         renderableInstance = triangle;
         renderable = Triangle3D;
      }
      
      override public function hitTestPoint2D(point:Point, renderhitData:RenderHitData) : RenderHitData
      {
         var vPoint:Vertex3DInstance = null;
         var vx0:Vertex3DInstance = null;
         var vx1:Vertex3DInstance = null;
         var vx2:Vertex3DInstance = null;
         renderMat = triangle.material;
         if(!renderMat)
         {
            renderMat = triangle.instance.material;
         }
         if(renderMat.interactive)
         {
            vPoint = new Vertex3DInstance(point.x,point.y);
            vx0 = triangle.v0.vertex3DInstance;
            vx1 = triangle.v1.vertex3DInstance;
            vx2 = triangle.v2.vertex3DInstance;
            if(sameSide(vPoint,vx0,vx1,vx2))
            {
               if(sameSide(vPoint,vx1,vx0,vx2))
               {
                  if(sameSide(vPoint,vx2,vx0,vx1))
                  {
                     return deepHitTest(triangle,vPoint,renderhitData);
                  }
               }
            }
         }
         return renderhitData;
      }
      
      public function sameSide(point:Vertex3DInstance, ref:Vertex3DInstance, a:Vertex3DInstance, b:Vertex3DInstance) : Boolean
      {
         var n:* = NaN;
         n = Vertex3DInstance.cross(Vertex3DInstance.sub(b,a),Vertex3DInstance.sub(point,a)) * Vertex3DInstance.cross(Vertex3DInstance.sub(b,a),Vertex3DInstance.sub(ref,a));
         return n > 0;
      }
      
      private function deepHitTest(face:Triangle3D, vPoint:Vertex3DInstance, rhd:RenderHitData) : RenderHitData
      {
         var v0:Vertex3DInstance = null;
         var v1:Vertex3DInstance = null;
         var v2:Vertex3DInstance = null;
         var v0_x:* = NaN;
         var v0_y:* = NaN;
         var v1_x:* = NaN;
         var v1_y:* = NaN;
         var v2_x:* = NaN;
         var v2_y:* = NaN;
         var dot00:* = NaN;
         var dot01:* = NaN;
         var dot02:* = NaN;
         var dot11:* = NaN;
         var dot12:* = NaN;
         var invDenom:* = NaN;
         var u:* = NaN;
         var v:* = NaN;
         var rv0_x:* = NaN;
         var rv0_y:* = NaN;
         var rv0_z:* = NaN;
         var rv1_x:* = NaN;
         var rv1_y:* = NaN;
         var rv1_z:* = NaN;
         var hx:* = NaN;
         var hy:* = NaN;
         var hz:* = NaN;
         var uv:Array = null;
         var uu0:* = NaN;
         var uu1:* = NaN;
         var uu2:* = NaN;
         var uv0:* = NaN;
         var uv1:* = NaN;
         var uv2:* = NaN;
         var v_x:* = NaN;
         var v_y:* = NaN;
         var bitmap:BitmapData = null;
         var width:* = NaN;
         var height:* = NaN;
         v0 = face.v0.vertex3DInstance;
         v1 = face.v1.vertex3DInstance;
         v2 = face.v2.vertex3DInstance;
         v0_x = v2.x - v0.x;
         v0_y = v2.y - v0.y;
         v1_x = v1.x - v0.x;
         v1_y = v1.y - v0.y;
         v2_x = vPoint.x - v0.x;
         v2_y = vPoint.y - v0.y;
         dot00 = v0_x * v0_x + v0_y * v0_y;
         dot01 = v0_x * v1_x + v0_y * v1_y;
         dot02 = v0_x * v2_x + v0_y * v2_y;
         dot11 = v1_x * v1_x + v1_y * v1_y;
         dot12 = v1_x * v2_x + v1_y * v2_y;
         invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
         u = (dot11 * dot02 - dot01 * dot12) * invDenom;
         v = (dot00 * dot12 - dot01 * dot02) * invDenom;
         rv0_x = face.v2.x - face.v0.x;
         rv0_y = face.v2.y - face.v0.y;
         rv0_z = face.v2.z - face.v0.z;
         rv1_x = face.v1.x - face.v0.x;
         rv1_y = face.v1.y - face.v0.y;
         rv1_z = face.v1.z - face.v0.z;
         hx = face.v0.x + rv0_x * u + rv1_x * v;
         hy = face.v0.y + rv0_y * u + rv1_y * v;
         hz = face.v0.z + rv0_z * u + rv1_z * v;
         uv = face.uv;
         uu0 = uv[0].u;
         uu1 = uv[1].u;
         uu2 = uv[2].u;
         uv0 = uv[0].v;
         uv1 = uv[1].v;
         uv2 = uv[2].v;
         v_x = (uu1 - uu0) * v + (uu2 - uu0) * u + uu0;
         v_y = (uv1 - uv0) * v + (uv2 - uv0) * u + uv0;
         if(triangle.material)
         {
            renderMat = face.material;
         }
         else
         {
            renderMat = face.instance.material;
         }
         bitmap = renderMat.bitmap;
         width = 1;
         height = 1;
         if(bitmap)
         {
            width = BitmapMaterial.AUTO_MIP_MAPPING?renderMat.widthOffset:bitmap.width;
            height = BitmapMaterial.AUTO_MIP_MAPPING?renderMat.heightOffset:bitmap.height;
         }
         rhd.displayObject3D = face.instance;
         rhd.material = renderMat;
         rhd.renderable = face;
         rhd.hasHit = true;
         position.x = hx;
         position.y = hy;
         position.z = hz;
         Matrix3D.multiplyVector(face.instance.world,position);
         rhd.x = position.x;
         rhd.y = position.y;
         rhd.z = position.z;
         rhd.u = v_x * width;
         rhd.v = height - v_y * height;
         return rhd;
      }
      
      override public function render(renderSessionData:RenderSessionData) : void
      {
         container = triangle.instance.container;
         if(!container)
         {
            container = renderSessionData.container;
         }
         renderer.drawTriangle(triangle,container.graphics,renderSessionData);
      }
   }
}
