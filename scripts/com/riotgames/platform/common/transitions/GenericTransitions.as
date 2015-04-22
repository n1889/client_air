package com.riotgames.platform.common.transitions
{
   import blix.action.IAction;
   import flash.display.DisplayObject;
   import blix.action.CallAction;
   import mx.effects.easing.Sine;
   import blix.util.display.rasterize;
   import com.greensock.TweenLite;
   import blix.action.NoopAction;
   
   public class GenericTransitions extends Object
   {
      
      public function GenericTransitions()
      {
         super();
      }
      
      public static function getFadeOut(param1:DisplayObject, param2:Number = 0.4, param3:Function = null) : IAction
      {
         var action:CallAction = null;
         var displayObjectToFade:DisplayObject = null;
         var args:Array = null;
         var displayObject:DisplayObject = param1;
         var time:Number = param2;
         var ease:Function = param3;
         if((!(displayObject == null)) && (!(displayObject.parent == null)) && (displayObject.width > 0) && (displayObject.height > 0))
         {
            if(ease == null)
            {
               ease = Sine.easeOut;
            }
            displayObjectToFade = rasterize(displayObject);
            displayObject.visible = false;
            if(displayObjectToFade != null)
            {
               displayObject.parent.addChild(displayObjectToFade);
               args = [displayObjectToFade,time,{
                  "alpha":0,
                  "ease":ease,
                  "onComplete":function():void
                  {
                     displayObject.parent.removeChild(displayObjectToFade);
                     action.complete();
                  }
               }];
               action = new CallAction(TweenLite.to,args);
            }
         }
         return action || new NoopAction();
      }
   }
}
