package mx.flash
{
   import mx.core.IUIComponent;
   import flash.events.FocusEvent;
   import flash.display.DisplayObjectContainer;
   
   public dynamic class ContainerMovieClip extends UIMovieClip
   {
      
      private var _contentHolder;
      
      private var _content:IUIComponent;
      
      public function ContainerMovieClip()
      {
         super();
      }
      
      public function set content(value:IUIComponent) : void
      {
         if(contentHolderObj)
         {
            contentHolderObj.content = value;
         }
         else
         {
            _content = value;
         }
      }
      
      protected function get contentHolderObj() : FlexContentHolder
      {
         var i:* = 0;
         var child:FlexContentHolder = null;
         if(_contentHolder === undefined)
         {
            i = 0;
            while(i < numChildren)
            {
               child = getChildAt(i) as FlexContentHolder;
               if(child)
               {
                  _contentHolder = child;
                  break;
               }
               i++;
            }
         }
         return _contentHolder;
      }
      
      public function get content() : IUIComponent
      {
         return contentHolderObj?contentHolderObj.content:_content;
      }
      
      override protected function focusInHandler(event:FocusEvent) : void
      {
      }
      
      override protected function findFocusCandidates(obj:DisplayObjectContainer) : void
      {
      }
   }
}
