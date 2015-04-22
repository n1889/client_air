package blix.assets.proxy
{
   import blix.context.Context;
   import flash.display.Sprite;
   import blix.view.behaviors.ScalingTransformBehavior;
   
   public class HitAreaProxy extends SpriteProxy
   {
      
      public function HitAreaProxy(param1:Context, param2:Sprite = null)
      {
         super(param1,param2);
         setMouseEnabled(false);
         setTransformBehavior(new ScalingTransformBehavior());
      }
      
      override protected function createChildren() : void
      {
      }
      
      override public function setHitArea(param1:SpriteProxy) : void
      {
      }
   }
}
