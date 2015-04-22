package
{
   import mx.flash.UIMovieClip;
   import flash.text.TextField;
   
   public dynamic class timer_timerTxtMc extends UIMovieClip
   {
      
      public var timerTxt:TextField;
      
      public function timer_timerTxtMc()
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
