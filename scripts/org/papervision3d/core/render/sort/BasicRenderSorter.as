package org.papervision3d.core.render.sort
{
   public class BasicRenderSorter extends Object implements IRenderSorter
   {
      
      public function BasicRenderSorter()
      {
         super();
      }
      
      public function sort(array:Array) : void
      {
         array.sortOn("screenDepth",Array.NUMERIC);
      }
   }
}
