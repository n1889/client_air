package
{
   import mx.flash.UIMovieClip;
   import flash.display.MovieClip;
   
   public dynamic class cs_smallMenu extends UIMovieClip
   {
      
      public var smallMenu_nameText:MovieClip;
      
      public function cs_smallMenu()
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
