package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;
   
   public class MoveEvent extends Event
   {
      
      mx_internal  static const VERSION:String = "2.0.1.0";
      
      public static const MOVE:String = "move";
      
      public var oldY:Number;
      
      public var oldX:Number;
      
      public function MoveEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, oldX:Number = NaN, oldY:Number = NaN)
      {
         super(type,bubbles,cancelable);
         this.oldX = oldX;
         this.oldY = oldY;
      }
      
      override public function clone() : Event
      {
         return new MoveEvent(type,bubbles,cancelable,oldX,oldY);
      }
   }
}
