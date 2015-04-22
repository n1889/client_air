package
{
   import flash.display.MovieClip;
   
   public dynamic class cs_slotItem_bg extends MovieClip
   {
      
      public var arrows_left_finish:MovieClip;
      
      public var arrows_left_start:MovieClip;
      
      public var arrows_right_finish:MovieClip;
      
      public var arrows_right_start:MovieClip;
      
      public var blue_bg:MovieClip;
      
      public var commend_champ_frame:MovieClip;
      
      public var fade_bg:MovieClip;
      
      public var grey_bg:MovieClip;
      
      public var orange_bg:MovieClip;
      
      public function cs_slotItem_bg()
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
