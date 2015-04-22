package org.papervision3d.materials
{
   import org.papervision3d.core.render.draw.ITriangleDrawer;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import org.papervision3d.Papervision3D;
   import flash.display.BitmapData;
   import org.papervision3d.core.proto.MaterialObject3D;
   import flash.display.Graphics;
   import org.papervision3d.core.render.data.RenderSessionData;
   import flash.geom.Rectangle;
   import flash.geom.Point;
   
   public class BitmapMaterial extends TriangleMaterial implements ITriangleDrawer
   {
      
      public static var AUTO_MIP_MAPPING:Boolean = false;
      
      protected static var _localMatrix:Matrix = new Matrix();
      
      public static var MIP_MAP_DEPTH:Number = 8;
      
      protected static var _triMatrix:Matrix = new Matrix();
      
      public var uvMatrices:Dictionary;
      
      protected var _texture:Object;
      
      public function BitmapMaterial(asset:BitmapData = null)
      {
         uvMatrices = new Dictionary();
         super();
         if(asset)
         {
            texture = asset;
         }
      }
      
      override public function toString() : String
      {
         return "Texture:" + this.texture + " lineColor:" + this.lineColor + " lineAlpha:" + this.lineAlpha;
      }
      
      public function resetMapping() : void
      {
         uvMatrices = new Dictionary();
      }
      
      public function transformUV(face3D:Triangle3D) : Matrix
      {
         var uv:Array = null;
         var w:* = NaN;
         var h:* = NaN;
         var u0:* = NaN;
         var v0:* = NaN;
         var u1:* = NaN;
         var v1:* = NaN;
         var u2:* = NaN;
         var v2:* = NaN;
         var at:* = NaN;
         var bt:* = NaN;
         var ct:* = NaN;
         var dt:* = NaN;
         var m:Matrix = null;
         var mapping:Matrix = null;
         if(!face3D.uv)
         {
            Papervision3D.log("MaterialObject3D: transformUV() uv not found!");
         }
         else if(bitmap)
         {
            uv = face3D.uv;
            w = bitmap.width * maxU;
            h = bitmap.height * maxV;
            u0 = w * uv[0].u;
            v0 = h * (1 - uv[0].v);
            u1 = w * uv[1].u;
            v1 = h * (1 - uv[1].v);
            u2 = w * uv[2].u;
            v2 = h * (1 - uv[2].v);
            if((u0 == u1) && (v0 == v1) || (u0 == u2) && (v0 == v2))
            {
               u0 = u0 - (u0 > 0.05?0.05:-0.05);
               v0 = v0 - (v0 > 0.07?0.07:-0.07);
            }
            if((u2 == u1) && (v2 == v1))
            {
               u2 = u2 - (u2 > 0.05?0.04:-0.04);
               v2 = v2 - (v2 > 0.06?0.06:-0.06);
            }
            at = u1 - u0;
            bt = v1 - v0;
            ct = u2 - u0;
            dt = v2 - v0;
            m = new Matrix(at,bt,ct,dt,u0,v0);
            m.invert();
            mapping = uvMatrices[face3D] || (uvMatrices[face3D] = m.clone());
            mapping.a = m.a;
            mapping.b = m.b;
            mapping.c = m.c;
            mapping.d = m.d;
            mapping.tx = m.tx;
            mapping.ty = m.ty;
         }
         else
         {
            Papervision3D.log("MaterialObject3D: transformUV() material.bitmap not found!");
         }
         
         return mapping;
      }
      
      public function get texture() : Object
      {
         return this._texture;
      }
      
      protected function correctBitmap(bitmap:BitmapData) : BitmapData
      {
         var okBitmap:BitmapData = null;
         var levels:* = NaN;
         var bWidth:* = NaN;
         var bHeight:* = NaN;
         var width:* = NaN;
         var height:* = NaN;
         var ok:* = false;
         levels = 1 << MIP_MAP_DEPTH;
         bWidth = bitmap.width / levels;
         bWidth = bWidth == uint(bWidth)?bWidth:uint(bWidth) + 1;
         bHeight = bitmap.height / levels;
         bHeight = bHeight == uint(bHeight)?bHeight:uint(bHeight) + 1;
         width = levels * bWidth;
         height = levels * bHeight;
         ok = true;
         if(width > 2880)
         {
            width = bitmap.width;
            ok = false;
         }
         if(height > 2880)
         {
            height = bitmap.height;
            ok = false;
         }
         if(!ok)
         {
            Papervision3D.log("Material " + this.name + ": Texture too big for mip mapping. Resizing recommended for better performance and quality.");
         }
         if((bitmap) && ((!(bitmap.width % levels == 0)) || (!(bitmap.height % levels == 0))))
         {
            okBitmap = new BitmapData(width,height,bitmap.transparent,0);
            widthOffset = bitmap.width;
            heightOffset = bitmap.height;
            this.maxU = bitmap.width / width;
            this.maxV = bitmap.height / height;
            okBitmap.draw(bitmap);
            extendBitmapEdges(okBitmap,bitmap.width,bitmap.height);
         }
         else
         {
            this.maxU = this.maxV = 1;
            okBitmap = bitmap;
         }
         return okBitmap;
      }
      
      public function set texture(asset:Object) : void
      {
         if(asset is BitmapData == false)
         {
            Papervision3D.log("Error: BitmapMaterial.texture requires a BitmapData object for the texture");
            return;
         }
         bitmap = createBitmap(BitmapData(asset));
         _texture = asset;
      }
      
      protected function createBitmap(asset:BitmapData) : BitmapData
      {
         resetMapping();
         if(AUTO_MIP_MAPPING)
         {
            return correctBitmap(asset);
         }
         this.maxU = this.maxV = 1;
         return asset;
      }
      
      override public function copy(material:MaterialObject3D) : void
      {
         super.copy(material);
         this.maxU = material.maxU;
         this.maxV = material.maxV;
      }
      
      override public function drawTriangle(face3D:Triangle3D, graphics:Graphics, renderSessionData:RenderSessionData) : void
      {
         var map:Matrix = null;
         var x0:* = NaN;
         var y0:* = NaN;
         var x1:* = NaN;
         var y1:* = NaN;
         var x2:* = NaN;
         var y2:* = NaN;
         if(lineAlpha)
         {
            graphics.lineStyle(0,lineColor,lineAlpha);
         }
         if(bitmap)
         {
            map = uvMatrices[face3D] || transformUV(face3D);
            x0 = face3D.v0.vertex3DInstance.x;
            y0 = face3D.v0.vertex3DInstance.y;
            x1 = face3D.v1.vertex3DInstance.x;
            y1 = face3D.v1.vertex3DInstance.y;
            x2 = face3D.v2.vertex3DInstance.x;
            y2 = face3D.v2.vertex3DInstance.y;
            _triMatrix.a = x1 - x0;
            _triMatrix.b = y1 - y0;
            _triMatrix.c = x2 - x0;
            _triMatrix.d = y2 - y0;
            _triMatrix.tx = x0;
            _triMatrix.ty = y0;
            _localMatrix.a = map.a;
            _localMatrix.b = map.b;
            _localMatrix.c = map.c;
            _localMatrix.d = map.d;
            _localMatrix.tx = map.tx;
            _localMatrix.ty = map.ty;
            _localMatrix.concat(_triMatrix);
            graphics.beginBitmapFill(bitmap,_localMatrix,tiled,smooth);
         }
         graphics.moveTo(x0,y0);
         graphics.lineTo(x1,y1);
         graphics.lineTo(x2,y2);
         graphics.lineTo(x0,y0);
         if(bitmap)
         {
            graphics.endFill();
         }
         if(lineAlpha)
         {
            graphics.lineStyle();
         }
         renderSessionData.renderStatistics.triangles++;
      }
      
      protected function extendBitmapEdges(bmp:BitmapData, originalWidth:Number, originalHeight:Number) : void
      {
         var srcRect:Rectangle = null;
         var dstPoint:Point = null;
         var i:* = 0;
         srcRect = new Rectangle();
         dstPoint = new Point();
         if(bmp.width > originalWidth)
         {
            srcRect.x = originalWidth - 1;
            srcRect.y = 0;
            srcRect.width = 1;
            srcRect.height = originalHeight;
            dstPoint.y = 0;
            i = originalWidth;
            while(i < bmp.width)
            {
               dstPoint.x = i;
               bmp.copyPixels(bmp,srcRect,dstPoint);
               i++;
            }
         }
         if(bmp.height > originalHeight)
         {
            srcRect.x = 0;
            srcRect.y = originalHeight - 1;
            srcRect.width = bmp.width;
            srcRect.height = 1;
            dstPoint.x = 0;
            i = originalHeight;
            while(i < bmp.height)
            {
               dstPoint.y = i;
               bmp.copyPixels(bmp,srcRect,dstPoint);
               i++;
            }
         }
      }
      
      override public function clone() : MaterialObject3D
      {
         var cloned:MaterialObject3D = null;
         cloned = super.clone();
         cloned.maxU = this.maxU;
         cloned.maxV = this.maxV;
         return cloned;
      }
   }
}
