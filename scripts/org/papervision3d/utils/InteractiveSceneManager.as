package org.papervision3d.utils
{
   import flash.events.EventDispatcher;
   import flash.display.Sprite;
   import org.papervision3d.core.proto.SceneObject3D;
   import flash.geom.Point;
   import org.papervision3d.core.render.InteractiveRendererEngine;
   import flash.events.MouseEvent;
   import org.papervision3d.events.RendererEvent;
   import org.papervision3d.objects.DisplayObject3D;
   import flash.events.Event;
   import org.papervision3d.core.proto.CameraObject3D;
   import org.papervision3d.utils.virtualmouse.IVirtualMouseEvent;
   import org.papervision3d.events.InteractiveScene3DEvent;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import org.papervision3d.utils.virtualmouse.VirtualMouse;
   import org.papervision3d.core.geom.renderables.Triangle3D;
   import com.blitzagency.xray.logger.XrayLog;
   import org.papervision3d.core.proto.MaterialObject3D;
   import org.papervision3d.materials.MovieMaterial;
   import org.papervision3d.core.render.hit.RenderHitData;
   
   public class InteractiveSceneManager extends EventDispatcher
   {
      
      public static var MOUSE_IS_DOWN:Boolean = false;
      
      public var container:Sprite;
      
      public var scene:SceneObject3D;
      
      protected var point:Point;
      
      public var currentDisplayObject3D:DisplayObject3D;
      
      public var camera:CameraObject3D;
      
      protected var log:XrayLog;
      
      public var currentMaterial:MaterialObject3D;
      
      public var debug:Boolean = false;
      
      public var mouse3D:Mouse3D;
      
      public var enableOverOut:Boolean = true;
      
      public var virtualMouse:VirtualMouse;
      
      public var renderHitData:RenderHitData;
      
      public var currentMouseDO3D:DisplayObject3D = null;
      
      public function InteractiveSceneManager(scene:SceneObject3D, container:Sprite, camera:CameraObject3D = null)
      {
         virtualMouse = new VirtualMouse();
         mouse3D = new Mouse3D();
         enableOverOut = true;
         currentMouseDO3D = null;
         debug = false;
         point = new Point();
         log = new XrayLog();
         super();
         this.scene = scene;
         this.container = container;
         this.camera = camera;
         init();
      }
      
      protected function initVirtualMouse() : void
      {
         virtualMouse.stage = container.stage;
         virtualMouse.container = container;
      }
      
      public function initListeners() : void
      {
         trace("renderer?",scene.renderer is InteractiveRendererEngine);
         if(scene.interactive)
         {
            container.addEventListener(MouseEvent.MOUSE_DOWN,handleMousePress);
            container.addEventListener(MouseEvent.MOUSE_UP,handleMouseRelease);
            container.addEventListener(MouseEvent.CLICK,handleMouseClick);
            container.addEventListener(MouseEvent.MOUSE_MOVE,handleMouseMove);
            if(scene.renderer is InteractiveRendererEngine)
            {
               InteractiveRendererEngine(scene.renderer).addEventListener(RendererEvent.RENDER_DONE,handleRenderDone);
            }
         }
      }
      
      public function init() : void
      {
         if(container)
         {
            if(container.stage)
            {
               initVirtualMouse();
            }
            else
            {
               container.addEventListener(Event.ADDED_TO_STAGE,handleAddedToStage);
            }
         }
      }
      
      protected function handleRenderDone(e:RendererEvent) : void
      {
         resolveRenderHitData();
         if(renderHitData.hasHit)
         {
            currentDisplayObject3D = renderHitData.displayObject3D;
            currentMaterial = renderHitData.material;
            manageOverOut();
         }
      }
      
      protected function handleMouseClick(e:MouseEvent) : void
      {
         if(e is IVirtualMouseEvent)
         {
            return;
         }
         if(renderHitData)
         {
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_CLICK,currentDisplayObject3D);
         }
      }
      
      protected function handleMouseOut(DO3D:DisplayObject3D) : void
      {
         var bitmap:BitmapData = null;
         var rect:Rectangle = null;
         var contains:* = false;
         if((VirtualMouse) && (renderHitData))
         {
            bitmap = currentMaterial.bitmap;
            rect = new Rectangle(0,0,bitmap.width,bitmap.height);
            contains = rect.contains(renderHitData.u,renderHitData.v);
            if(!contains)
            {
               virtualMouse.exitContainer();
            }
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_OUT,DO3D);
         }
      }
      
      protected function manageOverOut() : void
      {
         if((!renderHitData.hasHit) || (!enableOverOut))
         {
            return;
         }
         if((!currentMouseDO3D) && (currentDisplayObject3D))
         {
            handleMouseOver(currentDisplayObject3D);
         }
         if(currentDisplayObject3D != currentMouseDO3D)
         {
            handleMouseOut(currentMouseDO3D);
            handleMouseOver(currentDisplayObject3D);
            currentMouseDO3D = currentDisplayObject3D;
         }
      }
      
      protected function dispatchObjectEvent(event:String, DO3D:DisplayObject3D) : void
      {
         var x:* = NaN;
         var y:* = NaN;
         var IS3DE:InteractiveScene3DEvent = null;
         if(!renderHitData.hasHit)
         {
            return;
         }
         if(debug)
         {
            log.debug(event,DO3D.name);
         }
         x = renderHitData.u?renderHitData.u:0;
         y = renderHitData.v?renderHitData.v:0;
         IS3DE = new InteractiveScene3DEvent(event,DO3D,container,renderHitData.renderable as Triangle3D,x,y);
         dispatchEvent(IS3DE);
         currentDisplayObject3D.dispatchEvent(IS3DE);
      }
      
      protected function handleMouseMove(e:MouseEvent) : void
      {
         var mat:MovieMaterial = null;
         if(e is IVirtualMouseEvent)
         {
            return;
         }
         if((VirtualMouse) && (renderHitData))
         {
            mat = currentMaterial as MovieMaterial;
            if(mat)
            {
               virtualMouse.container = mat.movie as Sprite;
               if(virtualMouse.container)
               {
                  virtualMouse.setLocation(renderHitData.u,renderHitData.v);
               }
            }
            if(Mouse3D.enabled)
            {
               mouse3D.updatePosition(renderHitData);
            }
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_MOVE,currentDisplayObject3D);
         }
         else if(renderHitData.hasHit)
         {
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_MOVE,currentDisplayObject3D);
         }
         
      }
      
      protected function handleMouseOver(DO3D:DisplayObject3D) : void
      {
         dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_OVER,DO3D);
      }
      
      protected function resolveRenderHitData() : void
      {
         point.x = container.mouseX;
         point.y = container.mouseY;
         renderHitData = InteractiveRendererEngine(scene.renderer).hitTestPoint2D(point) as RenderHitData;
      }
      
      protected function handleMousePress(e:MouseEvent) : void
      {
         if(e is IVirtualMouseEvent)
         {
            return;
         }
         MOUSE_IS_DOWN = true;
         if(virtualMouse)
         {
            virtualMouse.press();
         }
         if(renderHitData)
         {
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_PRESS,currentDisplayObject3D);
         }
      }
      
      protected function handleMouseRelease(e:MouseEvent) : void
      {
         if(e is IVirtualMouseEvent)
         {
            return;
         }
         MOUSE_IS_DOWN = false;
         if(virtualMouse)
         {
            virtualMouse.release();
         }
         if(renderHitData)
         {
            dispatchObjectEvent(InteractiveScene3DEvent.OBJECT_RELEASE,currentDisplayObject3D);
         }
      }
      
      protected function handleAddedToStage(e:Event) : void
      {
         initVirtualMouse();
         initListeners();
      }
   }
}
