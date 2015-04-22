package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_contextAlert extends UIMovieClip
   {
      
      public function cs_contextAlert()
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
