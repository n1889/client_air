package org.papervision3d.objects
{
   import org.papervision3d.core.geom.TriangleMesh3D;
   import org.papervision3d.core.NumberUV;
   import org.papervision3d.core.geom.renderables.Vertex3D;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import org.papervision3d.core.proto.MaterialObject3D;
   
   public class Plane extends TriangleMesh3D
   {
      
      public static var DEFAULT_SCALE:Number = 1;
      
      public static var DEFAULT_SEGMENTS:Number = 1;
      
      public static var DEFAULT_SIZE:Number = 500;
      
      public var segmentsH:Number;
      
      public var segmentsW:Number;
      
      public function Plane(material:MaterialObject3D = null, width:Number = 0, height:Number = 0, segmentsW:Number = 0, segmentsH:Number = 0, initObject:Object = null)
      {
         var scale:* = NaN;
         super(material,new Array(),new Array(),null,initObject);
         this.segmentsW = (segmentsW) || (DEFAULT_SEGMENTS);
         this.segmentsH = (segmentsH) || (this.segmentsW);
         scale = DEFAULT_SCALE;
         if(!height)
         {
            if(width)
            {
               scale = width;
            }
            if((material) && (material.bitmap))
            {
               var width:Number = material.bitmap.width * scale;
               var height:Number = material.bitmap.height * scale;
            }
            else
            {
               width = DEFAULT_SIZE * scale;
               height = DEFAULT_SIZE * scale;
            }
         }
         buildPlane(width,height);
      }
      
      private function buildPlane(width:Number, height:Number) : void
      {
         var gridX:* = NaN;
         var gridY:* = NaN;
         var gridX1:* = NaN;
         var gridY1:* = NaN;
         var vertices:Array = null;
         var faces:Array = null;
         var textureX:* = NaN;
         var textureY:* = NaN;
         var iW:* = NaN;
         var iH:* = NaN;
         var ix:* = 0;
         var uvA:NumberUV = null;
         var uvC:NumberUV = null;
         var uvB:NumberUV = null;
         var iy:* = 0;
         var x:* = NaN;
         var y:* = NaN;
         var a:Vertex3D = null;
         var c:Vertex3D = null;
         var b:Vertex3D = null;
         gridX = this.segmentsW;
         gridY = this.segmentsH;
         gridX1 = gridX + 1;
         gridY1 = gridY + 1;
         vertices = this.geometry.vertices;
         faces = this.geometry.faces;
         textureX = width / 2;
         textureY = height / 2;
         iW = width / gridX;
         iH = height / gridY;
         ix = 0;
         while(ix < gridX + 1)
         {
            iy = 0;
            while(iy < gridY1)
            {
               x = ix * iW - textureX;
               y = iy * iH - textureY;
               vertices.push(new Vertex3D(x,y,0));
               iy++;
            }
            ix++;
         }
         ix = 0;
         while(ix < gridX)
         {
            iy = 0;
            while(iy < gridY)
            {
               a = vertices[ix * gridY1 + iy];
               c = vertices[ix * gridY1 + (iy + 1)];
               b = vertices[(ix + 1) * gridY1 + iy];
               uvA = new NumberUV(ix / gridX,iy / gridY);
               uvC = new NumberUV(ix / gridX,(iy + 1) / gridY);
               uvB = new NumberUV((ix + 1) / gridX,iy / gridY);
               faces.push(new Triangle3D(this,[a,b,c],null,[uvA,uvB,uvC]));
               a = vertices[(ix + 1) * gridY1 + (iy + 1)];
               c = vertices[(ix + 1) * gridY1 + iy];
               b = vertices[ix * gridY1 + (iy + 1)];
               uvA = new NumberUV((ix + 1) / gridX,(iy + 1) / gridY);
               uvC = new NumberUV((ix + 1) / gridX,iy / gridY);
               uvB = new NumberUV(ix / gridX,(iy + 1) / gridY);
               faces.push(new Triangle3D(this,[a,b,c],null,[uvA,uvB,uvC]));
               iy++;
            }
            ix++;
         }
         this.geometry.ready = true;
      }
   }
}
