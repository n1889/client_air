package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_progressBar extends UIMovieClip
   {
      
      public function cs_progressBar()
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
