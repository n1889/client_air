package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_timerLeft extends UIMovieClip
   {
      
      public var timerTxtMc:timer_timerTxtMc;
      
      public function cs_timerLeft()
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
