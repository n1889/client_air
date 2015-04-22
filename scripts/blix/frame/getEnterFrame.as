package blix.frame
{
   public function getEnterFrame() : ISignal
   {
      if(enterFrame == null)
      {
         enterFrame = new NativeSignal(Event.ENTER_FRAME,getFrameDispatcher());
      }
      return enterFrame;
   }
}
