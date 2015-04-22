package com.dougmccune.containers.materials
{
   import org.papervision3d.materials.MovieMaterial;
   import flash.events.Event;
   import flash.geom.Matrix;
   import mx.core.UIComponent;
   import flash.display.DisplayObject;
   import mx.events.FlexEvent;
   import mx.core.Container;
   
   public class FlexMaterial extends MovieMaterial
   {
      
      public function FlexMaterial(movieAsset:DisplayObject = null, transparent:Boolean = true)
      {
         if(movieAsset is UIComponent)
         {
            addUpdateListeners(UIComponent(movieAsset));
         }
         super(movieAsset,transparent,false);
      }
      
      private function handleUpdateComplete(event:Event) : void
      {
         if(bitmap)
         {
            updateBitmap();
         }
      }
      
      override public function drawBitmap() : void
      {
         bitmap.fillRect(bitmap.rect,this.fillColor);
         var mtx:Matrix = new Matrix();
         mtx.scale(movie.scaleX,movie.scaleY);
         bitmap.draw(movie,mtx,movie.transform.colorTransform);
      }
      
      private function addUpdateListeners(component:UIComponent) : void
      {
         var n:* = 0;
         var i:* = 0;
         var child:DisplayObject = null;
         component.addEventListener(FlexEvent.UPDATE_COMPLETE,handleUpdateComplete,false,10,true);
         if(component is Container)
         {
            n = Container(component).numChildren;
            i = 0;
            while(i < n)
            {
               child = component.getChildAt(i);
               if(child is UIComponent)
               {
                  addUpdateListeners(UIComponent(child));
               }
               i++;
            }
         }
      }
   }
}
