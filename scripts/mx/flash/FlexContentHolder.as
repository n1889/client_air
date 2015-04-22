package mx.flash
{
   import mx.core.IUIComponent;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.utils.getDefinitionByName;
   import flash.display.InteractiveObject;
   import mx.core.mx_internal;
   
   public dynamic class FlexContentHolder extends ContainerMovieClip
   {
      
      private var flexContent:IUIComponent;
      
      private var pendingFlexContent:IUIComponent;
      
      public function FlexContentHolder()
      {
         super();
         trackSizeChanges = false;
         showInAutomationHierarchy = false;
      }
      
      override public function get content() : IUIComponent
      {
         return flexContent;
      }
      
      override protected function notifySizeChanged() : void
      {
         super.notifySizeChanged();
         sizeFlexContent();
      }
      
      override public function set content(value:IUIComponent) : void
      {
         if(initialized)
         {
            setFlexContent(value);
         }
         else
         {
            pendingFlexContent = value;
         }
      }
      
      override public function initialize() : void
      {
         super.initialize();
         _width = bounds.width;
         _height = bounds.height;
         getChildAt(0).alpha = 0;
         if(pendingFlexContent)
         {
            setFlexContent(pendingFlexContent);
            pendingFlexContent = null;
         }
      }
      
      override public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         if((sizeChanged(_width,newWidth)) || (sizeChanged(_height,newHeight)))
         {
            dispatchResizeEvent();
         }
         _width = newWidth;
         _height = newHeight;
         scaleX = scaleY = 1;
         if(flexContent)
         {
            sizeFlexContent();
         }
      }
      
      protected function setFlexContent(value:IUIComponent) : void
      {
         var uiComponentClass:Class = null;
         var uicParent:Object = null;
         var p:DisplayObjectContainer = null;
         var applicationClass:Class = null;
         var child:Object = null;
         if(flexContent)
         {
            removeChild(DisplayObject(flexContent));
            flexContent = null;
         }
         flexContent = value;
         if(flexContent)
         {
            addChild(DisplayObject(flexContent));
            try
            {
               uiComponentClass = Class(getDefinitionByName("mx.core::UIComponent"));
            }
            catch(e:Error)
            {
            }
            if(uiComponentClass)
            {
               p = parent;
               while(p)
               {
                  if(p is uiComponentClass)
                  {
                     uicParent = p;
                     break;
                  }
                  p = p.parent;
               }
               if(!uicParent)
               {
                  try
                  {
                     applicationClass = Class(getDefinitionByName("mx.core::ApplicationGlobals"));
                     uicParent = applicationClass.application;
                  }
                  catch(e:Error)
                  {
                  }
               }
               if(!uicParent)
               {
                  return;
               }
               flexContent.initialize();
               if(!flexContent.document)
               {
                  flexContent.document = uicParent.document;
               }
               if(flexContent is InteractiveObject)
               {
                  if(doubleClickEnabled)
                  {
                     InteractiveObject(flexContent).doubleClickEnabled = true;
                  }
               }
               if(flexContent is uiComponentClass)
               {
                  flexContent.mx_internal::_parent = this;
                  child = flexContent;
                  child.nestLevel = uicParent.nestLevel + 1;
                  child.mx_internal::_parent = uicParent;
                  child.regenerateStyleCache(true);
                  child.styleChanged(null);
                  child.notifyStyleChangeInChildren(null,true);
                  child.mx_internal::initThemeColor();
                  child.mx_internal::_parent = this;
                  child.stylesInitialized();
               }
               _width = _width * scaleX;
               _height = _height * scaleY;
               scaleX = scaleY = 1;
               sizeFlexContent();
            }
         }
      }
      
      protected function sizeFlexContent() : void
      {
         if(!flexContent)
         {
            return;
         }
         flexContent.scaleX = 1;
         flexContent.scaleY = 1;
         var contentWidth:Number = _width;
         var contentHeight:Number = _height;
         if(flexContent.explicitWidth)
         {
            contentWidth = Math.min(contentWidth,flexContent.explicitWidth);
         }
         if(flexContent.explicitHeight)
         {
            contentHeight = Math.min(contentHeight,flexContent.explicitHeight);
         }
         flexContent.setActualSize(contentWidth,contentHeight);
      }
   }
}
