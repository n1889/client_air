package org.papervision3d.scenes
{
   import flash.utils.Dictionary;
   import org.papervision3d.objects.DisplayObject3D;
   import flash.display.Sprite;
   import org.papervision3d.core.proto.CameraObject3D;
   import flash.utils.getTimer;
   
   public class MovieScene3D extends Scene3D
   {
      
      private var spriteList:Dictionary;
      
      private var containerList:Array;
      
      public function MovieScene3D(container:Sprite, interactive:Boolean = false)
      {
         super(container,interactive);
         this.containerList = new Array();
         spriteList = new Dictionary();
      }
      
      override public function addChild(child:DisplayObject3D, name:String = null) : DisplayObject3D
      {
         var child:DisplayObject3D = super.addChild(child,name);
         child.container = new Sprite();
         container.addChild(child.container);
         this.containerList.push(child.container);
         spriteList[child] = child.container;
         return child;
      }
      
      override protected function renderObjects(camera:CameraObject3D) : void
      {
         var objectsLength:* = NaN;
         var gfx:Sprite = null;
         var containerList:Array = null;
         var i:* = NaN;
         var p:DisplayObject3D = null;
         var objects:Array = null;
         objectsLength = this.objects.length;
         containerList = this.containerList;
         i = 0;
         while(gfx = containerList[i++])
         {
            gfx.graphics.clear();
         }
         this.stats = renderer.render(this,container,camera);
         stats.performance = getTimer() - stats.performance;
         objects = this.objects;
         i = objects.length;
         if(camera.sort)
         {
            while(p = objects[--i])
            {
               if(p.visible)
               {
                  container.addChild(p.container);
               }
            }
         }
      }
      
      public function getSprite(child:DisplayObject3D) : Sprite
      {
         return spriteList[child];
      }
      
      override public function removeChild(child:DisplayObject3D) : DisplayObject3D
      {
         var removed:DisplayObject3D = null;
         var i:* = 0;
         removed = super.removeChild(child);
         i = 0;
         while(i < containerList.length)
         {
            if(removed.container == containerList[i])
            {
               this.containerList.splice(i,1);
            }
            i++;
         }
         container.removeChild(removed.container);
         delete spriteList[removed];
         true;
         return removed;
      }
   }
}
