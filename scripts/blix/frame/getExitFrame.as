package blix.frame
{
   public function getExitFrame() : ISignal
   {
      if(exitFrame == null)
      {
         exitFrame = new NativeSignal(Event.EXIT_FRAME,getFrameDispatcher());
      }
      return exitFrame;
   }
}
