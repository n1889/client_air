package org.papervision3d.core.render.command
{
   import org.papervision3d.core.render.data.RenderSessionData;
   
   public class AbstractRenderListItem extends Object implements IRenderListItem
   {
      
      public var screenDepth:Number;
      
      public function AbstractRenderListItem()
      {
         super();
      }
      
      public function render(renderSessionData:RenderSessionData) : void
      {
      }
   }
}
