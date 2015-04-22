package org.papervision3d.core.geom.renderables
{
   import flash.display.Sprite;
   import org.papervision3d.core.Number3D;
   import org.papervision3d.objects.DisplayObject3D;
   
   public class Triangle3DInstance extends Object
   {
      
      public var container:Sprite;
      
      public var faceNormal:Number3D;
      
      public var screenZ:Number;
      
      public var visible:Boolean = false;
      
      public var instance:DisplayObject3D;
      
      public function Triangle3DInstance(face:Triangle3D, instance:DisplayObject3D)
      {
         visible = false;
         super();
         this.instance = instance;
         faceNormal = new Number3D();
      }
   }
}
