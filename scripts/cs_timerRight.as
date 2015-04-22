package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_timerRight extends UIMovieClip
   {
      
      public var timerTxtMc:timer_timerTxtMc;
      
      public function cs_timerRight()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
