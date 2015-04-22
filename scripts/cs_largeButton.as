package
{
   import mx.flash.UIMovieClip;
   
   public dynamic class cs_largeButton extends UIMovieClip
   {
      
      public function cs_largeButton()
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
