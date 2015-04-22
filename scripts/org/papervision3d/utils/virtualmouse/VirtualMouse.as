package org.papervision3d.utils.virtualmouse
{
   import flash.events.EventDispatcher;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.events.MouseEvent;
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.display.SimpleButton;
   import flash.display.DisplayObjectContainer;
   import flash.events.KeyboardEvent;
   import com.blitzagency.xray.logger.XrayLog;
   import flash.utils.Dictionary;
   
   public class VirtualMouse extends EventDispatcher
   {
      
      public static const UPDATE:String = "update";
      
      private static var _mouseIsDown:Boolean = false;
      
      private var _container:Sprite;
      
      private var lastDownTarget:DisplayObject;
      
      private var target:InteractiveObject;
      
      private var updateMouseDown:Boolean = false;
      
      private var eventEvent:Class;
      
      private var _lastEvent:Event;
      
      private var mouseEventEvent:Class;
      
      private var location:Point;
      
      private var delta:int = 0;
      
      private var disabledEvents:Object;
      
      private var log:XrayLog;
      
      private var ignoredInstances:Dictionary;
      
      private var isLocked:Boolean = false;
      
      private var lastWithinStage:Boolean = true;
      
      private var lastLocation:Point;
      
      private var isDoubleClickEvent:Boolean = false;
      
      private var lastMouseDown:Boolean = false;
      
      private var altKey:Boolean = false;
      
      private var _useNativeEvents:Boolean = false;
      
      private var ctrlKey:Boolean = false;
      
      private var shiftKey:Boolean = false;
      
      private var _stage:Stage;
      
      public function VirtualMouse(stage:Stage = null, container:Sprite = null, startX:Number = 0, startY:Number = 0)
      {
         altKey = false;
         ctrlKey = false;
         shiftKey = false;
         delta = 0;
         isLocked = false;
         isDoubleClickEvent = false;
         disabledEvents = new Object();
         ignoredInstances = new Dictionary(true);
         lastMouseDown = false;
         updateMouseDown = false;
         lastWithinStage = true;
         _useNativeEvents = false;
         eventEvent = VirtualMouseEvent;
         mouseEventEvent = VirtualMouseMouseEvent;
         log = new XrayLog();
         super();
         this.stage = stage;
         this.container = container;
         location = new Point(startX,startY);
         lastLocation = location.clone();
         addEventListener(UPDATE,handleUpdate);
         update();
      }
      
      public function get mouseIsDown() : Boolean
      {
         return _mouseIsDown;
      }
      
      public function get stage() : Stage
      {
         return _stage;
      }
      
      public function exitContainer() : void
      {
         var targetLocal:Point = null;
         targetLocal = target.globalToLocal(location);
         if(!disabledEvents[MouseEvent.MOUSE_OUT])
         {
            _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_OUT,true,false,targetLocal.x,targetLocal.y,container,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
            container.dispatchEvent(_lastEvent);
            dispatchEvent(_lastEvent);
         }
         if(!disabledEvents[MouseEvent.ROLL_OUT])
         {
            _lastEvent = new mouseEventEvent(MouseEvent.ROLL_OUT,false,false,targetLocal.x,targetLocal.y,container,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
            container.dispatchEvent(_lastEvent);
            dispatchEvent(_lastEvent);
         }
         if(target != container)
         {
            if(!disabledEvents[MouseEvent.MOUSE_OUT])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_OUT,true,false,targetLocal.x,targetLocal.y,container,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               target.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            if(!disabledEvents[MouseEvent.ROLL_OUT])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.ROLL_OUT,false,false,targetLocal.x,targetLocal.y,container,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               target.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
         }
         target = _stage;
      }
      
      public function release() : void
      {
         updateMouseDown = true;
         _mouseIsDown = false;
         if(!isLocked)
         {
            update();
         }
      }
      
      public function click() : void
      {
         press();
         release();
      }
      
      public function get container() : Sprite
      {
         return _container;
      }
      
      public function set container(value:Sprite) : void
      {
         _container = value;
      }
      
      public function get y() : Number
      {
         return location.y;
      }
      
      public function set x(n:Number) : void
      {
         location.x = n;
         if(!isLocked)
         {
            update();
         }
      }
      
      public function disableEvent(type:String) : void
      {
         disabledEvents[type] = true;
      }
      
      public function get lastEvent() : Event
      {
         return _lastEvent;
      }
      
      private function handleUpdate(event:Event) : void
      {
         var objectsUnderPoint:Array = null;
         var currentTarget:InteractiveObject = null;
         var currentParent:DisplayObject = null;
         var i:* = 0;
         var targetLocal:Point = null;
         var currentTargetLocal:Point = null;
         var withinStage:* = false;
         if(!container)
         {
            return;
         }
         objectsUnderPoint = container.getObjectsUnderPoint(location);
         i = objectsUnderPoint.length;
         while(i--)
         {
            currentParent = objectsUnderPoint[i];
            while(currentParent)
            {
               if(ignoredInstances[currentParent])
               {
                  currentTarget = null;
                  break;
               }
               if((currentTarget) && (currentParent is SimpleButton))
               {
                  currentTarget = null;
               }
               else if((currentTarget) && (!DisplayObjectContainer(currentParent).mouseChildren))
               {
                  currentTarget = null;
               }
               
               if((!currentTarget) && (currentParent is InteractiveObject) && (InteractiveObject(currentParent).mouseEnabled))
               {
                  currentTarget = InteractiveObject(currentParent);
               }
               currentParent = currentParent.parent;
            }
            if(currentTarget)
            {
               break;
            }
         }
         if(!currentTarget)
         {
            currentTarget = _stage;
         }
         targetLocal = target.globalToLocal(location);
         currentTargetLocal = currentTarget.globalToLocal(location);
         if((!(lastLocation.x == location.x)) || (!(lastLocation.y == location.y)))
         {
            withinStage = false;
            if(stage)
            {
               withinStage = (location.x >= 0) && (location.y >= 0) && (location.x <= stage.stageWidth) && (location.y <= stage.stageHeight);
            }
            if((!withinStage) && (lastWithinStage) && (!disabledEvents[Event.MOUSE_LEAVE]))
            {
               _lastEvent = new eventEvent(Event.MOUSE_LEAVE,false,false);
               stage.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            if((withinStage) && (!disabledEvents[MouseEvent.MOUSE_MOVE]))
            {
               _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_MOVE,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               currentTarget.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            lastWithinStage = withinStage;
         }
         if(currentTarget != target)
         {
            if(!disabledEvents[MouseEvent.MOUSE_OUT])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_OUT,true,false,targetLocal.x,targetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               target.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            if(!disabledEvents[MouseEvent.ROLL_OUT])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.ROLL_OUT,false,false,targetLocal.x,targetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               target.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            if(!disabledEvents[MouseEvent.MOUSE_OVER])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_OVER,true,false,currentTargetLocal.x,currentTargetLocal.y,target,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               currentTarget.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
            if(!disabledEvents[MouseEvent.ROLL_OVER])
            {
               _lastEvent = new mouseEventEvent(MouseEvent.ROLL_OVER,false,false,currentTargetLocal.x,currentTargetLocal.y,target,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
               currentTarget.dispatchEvent(_lastEvent);
               dispatchEvent(_lastEvent);
            }
         }
         if(updateMouseDown)
         {
            if(_mouseIsDown)
            {
               if(!disabledEvents[MouseEvent.MOUSE_DOWN])
               {
                  _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_DOWN,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
                  currentTarget.dispatchEvent(_lastEvent);
                  dispatchEvent(_lastEvent);
               }
               lastDownTarget = currentTarget;
               updateMouseDown = false;
            }
            else
            {
               if(!disabledEvents[MouseEvent.MOUSE_UP])
               {
                  _lastEvent = new mouseEventEvent(MouseEvent.MOUSE_UP,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
                  currentTarget.dispatchEvent(_lastEvent);
                  dispatchEvent(_lastEvent);
               }
               if((!disabledEvents[MouseEvent.CLICK]) && (currentTarget == lastDownTarget))
               {
                  _lastEvent = new mouseEventEvent(MouseEvent.CLICK,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
                  currentTarget.dispatchEvent(_lastEvent);
                  dispatchEvent(_lastEvent);
               }
               lastDownTarget = null;
               updateMouseDown = false;
            }
         }
         if((isDoubleClickEvent) && (!disabledEvents[MouseEvent.DOUBLE_CLICK]) && (currentTarget.doubleClickEnabled))
         {
            _lastEvent = new mouseEventEvent(MouseEvent.DOUBLE_CLICK,true,false,currentTargetLocal.x,currentTargetLocal.y,currentTarget,ctrlKey,altKey,shiftKey,_mouseIsDown,delta);
            currentTarget.dispatchEvent(_lastEvent);
            dispatchEvent(_lastEvent);
         }
         lastLocation = location.clone();
         lastMouseDown = _mouseIsDown;
         target = currentTarget;
      }
      
      public function getLocation() : Point
      {
         return location.clone();
      }
      
      public function get x() : Number
      {
         return location.x;
      }
      
      public function lock() : void
      {
         isLocked = true;
      }
      
      public function get useNativeEvents() : Boolean
      {
         return _useNativeEvents;
      }
      
      public function setLocation(a:*, b:* = null) : void
      {
         var loc:Point = null;
         if(a is Point)
         {
            loc = Point(a);
            location.x = loc.x;
            location.y = loc.y;
         }
         else
         {
            location.x = Number(a);
            location.y = Number(b);
         }
         if(!isLocked)
         {
            update();
         }
      }
      
      private function keyHandler(event:KeyboardEvent) : void
      {
         altKey = event.altKey;
         ctrlKey = event.ctrlKey;
         shiftKey = event.shiftKey;
      }
      
      public function unignore(instance:DisplayObject) : void
      {
         if(instance in ignoredInstances)
         {
            delete ignoredInstances[instance];
            true;
         }
      }
      
      public function doubleClick() : void
      {
         if(isLocked)
         {
            release();
         }
         else
         {
            click();
            press();
            isDoubleClickEvent = true;
            release();
            isDoubleClickEvent = false;
         }
      }
      
      public function update() : void
      {
         dispatchEvent(new Event(UPDATE,false,false));
      }
      
      public function ignore(instance:DisplayObject) : void
      {
         ignoredInstances[instance] = true;
      }
      
      public function unlock() : void
      {
         isLocked = false;
         update();
      }
      
      public function enableEvent(type:String) : void
      {
         if(type in disabledEvents)
         {
            delete disabledEvents[type];
            true;
         }
      }
      
      public function press() : void
      {
         updateMouseDown = true;
         _mouseIsDown = true;
         if(!isLocked)
         {
            update();
         }
      }
      
      public function set useNativeEvents(b:Boolean) : void
      {
         if(b == _useNativeEvents)
         {
            return;
         }
         _useNativeEvents = b;
         if(_useNativeEvents)
         {
            eventEvent = VirtualMouseEvent;
            mouseEventEvent = VirtualMouseMouseEvent;
         }
         else
         {
            eventEvent = Event;
            mouseEventEvent = MouseEvent;
         }
      }
      
      public function set y(n:Number) : void
      {
         location.y = n;
         if(!isLocked)
         {
            update();
         }
      }
      
      public function set stage(s:Stage) : void
      {
         var hadStage:* = false;
         if(_stage)
         {
            hadStage = true;
            _stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyHandler);
            _stage.removeEventListener(KeyboardEvent.KEY_UP,keyHandler);
         }
         else
         {
            hadStage = false;
         }
         _stage = s;
         if(_stage)
         {
            _stage.addEventListener(KeyboardEvent.KEY_DOWN,keyHandler);
            _stage.addEventListener(KeyboardEvent.KEY_UP,keyHandler);
            target = _stage;
            if(!hadStage)
            {
               update();
            }
         }
      }
   }
}
