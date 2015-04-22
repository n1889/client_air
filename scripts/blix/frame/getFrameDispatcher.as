package blix.frame
{
   public function getFrameDispatcher() : DisplayObject
   {
      if(frameDispatcher == null)
      {
         frameDispatcher = new Shape();
      }
      return frameDispatcher;
   }
}
