package com.dougmccune.containers
{
   import flash.display.DisplayObject;
   import mx.core.UIComponent;
   import org.papervision3d.objects.DisplayObject3D;
   import flash.geom.ColorTransform;
   import mx.core.EdgeMetrics;
   import caurina.transitions.Tweener;
   
   public class CoverFlowContainer extends BasePV3DContainer
   {
      
      protected var maxChildWidth:Number;
      
      public var rotationAngle:Number = 70;
      
      public var fadeEdges:Boolean = false;
      
      protected var maxChildHeight:Number;
      
      public function CoverFlowContainer()
      {
         super();
      }
      
      override protected function layoutChildren(unscaledWidth:Number, unscaledHeight:Number) : void
      {
         super.layoutChildren(unscaledWidth,unscaledHeight);
         layoutCoverflow(unscaledWidth,unscaledHeight);
      }
      
      override public function addChild(child:DisplayObject) : DisplayObject
      {
         super.addChild(child);
         var childHeight:Number = child is UIComponent?UIComponent(child).getExplicitOrMeasuredHeight():child.height;
         if((isNaN(maxChildHeight)) || (childHeight > maxChildHeight))
         {
            maxChildHeight = childHeight;
         }
         return child;
      }
      
      override public function removeChild(child:DisplayObject) : DisplayObject
      {
         return super.removeChild(child);
      }
      
      protected function layoutCoverflow(uncaledWidth:Number, unscaledHeight:Number) : void
      {
         var child:DisplayObject = null;
         var plane:DisplayObject3D = null;
         var abs:* = NaN;
         var horizontalGap:* = NaN;
         var verticalGap:* = NaN;
         var xPosition:* = NaN;
         var yPosition:* = NaN;
         var zPosition:* = NaN;
         var yRotation:* = NaN;
         var alpha:* = NaN;
         var colorTransform:ColorTransform = null;
         var reflection:DisplayObject3D = null;
         var bm:EdgeMetrics = null;
         var n:int = numChildren;
         var i:int = 0;
         while(i < n)
         {
            child = getChildAt(i);
            plane = lookupPlane(child);
            if(plane != null)
            {
               plane.container.visible = true;
               abs = Math.abs(selectedIndex - i);
               horizontalGap = getStyle("horizontalSpacing");
               if(isNaN(horizontalGap))
               {
                  horizontalGap = maxChildHeight / 3;
               }
               verticalGap = getStyle("verticalSpacing");
               if(isNaN(verticalGap))
               {
                  verticalGap = 10;
               }
               xPosition = selectedChild.width + (abs - 1) * horizontalGap;
               yPosition = -(maxChildHeight - child.height) / 2;
               zPosition = camera.z / 2 + selectedChild.width + abs * verticalGap;
               yRotation = rotationAngle;
               alpha = (unscaledWidth / 2 - xPosition) / (unscaledWidth / 2);
               alpha = Math.max(Math.min(alpha * 2,1),0);
               if(i < selectedIndex)
               {
                  xPosition = xPosition * -1;
                  yRotation = yRotation * -1;
               }
               else if(i == selectedIndex)
               {
                  xPosition = 0;
                  zPosition = camera.z / 2;
                  yRotation = 0;
                  alpha = 1;
               }
               
               if(fadeEdges)
               {
                  colorTransform = child.transform.colorTransform;
                  colorTransform.alphaMultiplier = alpha;
                  child.transform.colorTransform = colorTransform;
                  plane.material.updateBitmap();
               }
               if(reflectionEnabled)
               {
                  reflection = lookupReflection(child);
                  if(fadeEdges)
                  {
                     reflection.material.updateBitmap();
                  }
                  reflection.y = yPosition - child.height - 2;
                  if(i != selectedIndex)
                  {
                     Tweener.addTween(reflection,{
                        "z":zPosition,
                        "time":tweenDuration / 3
                     });
                     Tweener.addTween(reflection,{
                        "x":xPosition,
                        "rotationY":yRotation,
                        "time":tweenDuration
                     });
                  }
                  else
                  {
                     Tweener.addTween(reflection,{
                        "x":xPosition,
                        "z":zPosition,
                        "rotationY":yRotation,
                        "time":tweenDuration
                     });
                  }
               }
               if(i != selectedIndex)
               {
                  Tweener.addTween(plane,{
                     "z":zPosition,
                     "time":tweenDuration / 3
                  });
                  Tweener.addTween(plane,{
                     "x":xPosition,
                     "y":yPosition,
                     "rotationY":yRotation,
                     "time":tweenDuration
                  });
               }
               else
               {
                  Tweener.addTween(plane,{
                     "x":xPosition,
                     "y":yPosition,
                     "z":zPosition,
                     "rotationY":yRotation,
                     "time":tweenDuration
                  });
               }
               if(i == selectedIndex)
               {
                  bm = borderMetrics;
                  child.x = unscaledWidth / 2 - child.width / 2 - bm.top;
                  child.y = unscaledHeight / 2 - child.height / 2 - yPosition - bm.left;
                  child.visible = false;
               }
            }
            i++;
         }
      }
   }
}
