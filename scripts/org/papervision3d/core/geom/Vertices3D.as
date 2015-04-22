package org.papervision3d.core.geom
{
   import org.papervision3d.objects.DisplayObject3D;
   import org.papervision3d.core.proto.CameraObject3D;
   import org.papervision3d.core.Matrix3D;
   import org.papervision3d.core.geom.renderables.Vertex3D;
   import org.papervision3d.core.geom.renderables.Vertex3DInstance;
   import org.papervision3d.core.Number3D;
   import org.papervision3d.core.proto.GeometryObject3D;
   
   public class Vertices3D extends DisplayObject3D
   {
      
      public function Vertices3D(vertices:Array, name:String = null, initObject:Object = null)
      {
         super(name,new GeometryObject3D(),initObject);
         this.geometry.vertices = vertices || new Array();
      }
      
      override public function project(parent:DisplayObject3D, camera:CameraObject3D, sorted:Array = null) : Number
      {
         var view:Matrix3D = null;
         var m11:* = NaN;
         var m12:* = NaN;
         var m13:* = NaN;
         var m21:* = NaN;
         var m22:* = NaN;
         var m23:* = NaN;
         var m31:* = NaN;
         var m32:* = NaN;
         var m33:* = NaN;
         var vx:* = NaN;
         var vy:* = NaN;
         var vz:* = NaN;
         var s_x:* = NaN;
         var s_y:* = NaN;
         var s_z:* = NaN;
         var vertex:Vertex3D = null;
         var screen:Vertex3DInstance = null;
         var persp:* = NaN;
         var vertices:Array = null;
         var i:* = 0;
         var focus:* = NaN;
         var fz:* = NaN;
         super.project(parent,camera,sorted);
         view = this.view;
         m11 = view.n11;
         m12 = view.n12;
         m13 = view.n13;
         m21 = view.n21;
         m22 = view.n22;
         m23 = view.n23;
         m31 = view.n31;
         m32 = view.n32;
         m33 = view.n33;
         vertices = this.geometry.vertices;
         i = vertices.length;
         focus = camera.focus;
         fz = focus * camera.zoom;
         while(vertex = vertices[--i])
         {
            vx = vertex.x;
            vy = vertex.y;
            vz = vertex.z;
            s_z = vx * m31 + vy * m32 + vz * m33 + view.n34;
            screen = vertex.vertex3DInstance;
            if(screen.visible = s_z > 0)
            {
               s_x = vx * m11 + vy * m12 + vz * m13 + view.n14;
               s_y = vx * m21 + vy * m22 + vz * m23 + view.n24;
               persp = fz / (focus + s_z);
               screen.x = s_x * persp;
               screen.y = s_y * persp;
               screen.z = s_z;
            }
         }
         return 0;
      }
      
      public function transformVertices(transformation:Matrix3D) : void
      {
         var m11:* = NaN;
         var m12:* = NaN;
         var m13:* = NaN;
         var m21:* = NaN;
         var m22:* = NaN;
         var m23:* = NaN;
         var m31:* = NaN;
         var m32:* = NaN;
         var m33:* = NaN;
         var m14:* = NaN;
         var m24:* = NaN;
         var m34:* = NaN;
         var vertices:Array = null;
         var i:* = 0;
         var vertex:Vertex3D = null;
         var vx:* = NaN;
         var vy:* = NaN;
         var vz:* = NaN;
         var tx:* = NaN;
         var ty:* = NaN;
         var tz:* = NaN;
         m11 = transformation.n11;
         m12 = transformation.n12;
         m13 = transformation.n13;
         m21 = transformation.n21;
         m22 = transformation.n22;
         m23 = transformation.n23;
         m31 = transformation.n31;
         m32 = transformation.n32;
         m33 = transformation.n33;
         m14 = transformation.n14;
         m24 = transformation.n24;
         m34 = transformation.n34;
         vertices = this.geometry.vertices;
         i = vertices.length;
         while(vertex = vertices[--i])
         {
            vx = vertex.x;
            vy = vertex.y;
            vz = vertex.z;
            tx = vx * m11 + vy * m12 + vz * m13 + m14;
            ty = vx * m21 + vy * m22 + vz * m23 + m24;
            tz = vx * m31 + vy * m32 + vz * m33 + m34;
            vertex.x = tx;
            vertex.y = ty;
            vertex.z = tz;
         }
      }
      
      public function boundingBox() : Object
      {
         var vertices:Object = null;
         var bBox:Object = null;
         var i:String = null;
         var v:Vertex3D = null;
         vertices = this.geometry.vertices;
         bBox = new Object();
         bBox.min = new Number3D();
         bBox.max = new Number3D();
         bBox.size = new Number3D();
         for(i in vertices)
         {
            v = vertices[Number(i)];
            bBox.min.x = bBox.min.x == undefined?v.x:Math.min(v.x,bBox.min.x);
            bBox.max.x = bBox.max.x == undefined?v.x:Math.max(v.x,bBox.max.x);
            bBox.min.y = bBox.min.y == undefined?v.y:Math.min(v.y,bBox.min.y);
            bBox.max.y = bBox.max.y == undefined?v.y:Math.max(v.y,bBox.max.y);
            bBox.min.z = bBox.min.z == undefined?v.z:Math.min(v.z,bBox.min.z);
            bBox.max.z = bBox.max.z == undefined?v.z:Math.max(v.z,bBox.max.z);
         }
         bBox.size.x = bBox.max.x - bBox.min.x;
         bBox.size.y = bBox.max.y - bBox.min.y;
         bBox.size.z = bBox.max.z - bBox.min.z;
         return bBox;
      }
   }
}
