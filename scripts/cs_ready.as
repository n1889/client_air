package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_ready extends UIMovieClip
   {
      
      public function cs_ready()
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
