package mx.events
{
   import flash.events.MouseEvent;
   import mx.core.mx_internal;
   import flash.events.Event;
   import flash.display.InteractiveObject;
   
   public class FlexMouseEvent extends MouseEvent
   {
      
      public static const MOUSE_DOWN_OUTSIDE:String = "mouseDownOutside";
      
      public static const MOUSE_WHEEL_OUTSIDE:String = "mouseWheelOutside";
      
      mx_internal  static const VERSION:String = "3.0.0.0";
      
      public function FlexMouseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, localX:Number = 0, localY:Number = 0, relatedObject:InteractiveObject = null, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false, buttonDown:Boolean = false, delta:int = 0)
      {
         super(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta);
      }
      
      override public function clone() : Event
      {
         return new FlexMouseEvent(type,bubbles,cancelable,localX,localY,relatedObject,ctrlKey,altKey,shiftKey,buttonDown,delta);
      }
   }
}
