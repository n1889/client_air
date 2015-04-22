package
{
   import mx.flash.UIMovieClip;
   import flash.display.MovieClip;
   
   public dynamic class cs_mainMenu extends UIMovieClip
   {
      
      public var mainMenu_nameText1:MovieClip;
      
      public var mainMenu_nameText2:MovieClip;
      
      public function cs_mainMenu()
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
