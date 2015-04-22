package org.papervision3d.core.render.hit
{
   import org.papervision3d.objects.DisplayObject3D;
   import org.papervision3d.core.geom.renderables.IRenderable;
   import org.papervision3d.core.proto.MaterialObject3D;
   
   public class RenderHitData extends Object
   {
      
      public var y:Number;
      
      public var displayObject3D:DisplayObject3D;
      
      public var renderable:IRenderable;
      
      public var u:Number;
      
      public var material:MaterialObject3D;
      
      public var x:Number;
      
      public var hasHit:Boolean = false;
      
      public var z:Number;
      
      public var v:Number;
      
      public function RenderHitData()
      {
         hasHit = false;
         super();
      }
      
      public function toString() : String
      {
         return displayObject3D + " " + renderable;
      }
   }
}
