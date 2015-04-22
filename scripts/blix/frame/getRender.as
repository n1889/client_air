package blix.frame
{
   public function getRender() : ISignal
   {
      if(render == null)
      {
         render = new NativeSignal(Event.RENDER,getFrameDispatcher());
      }
      return render;
   }
}
