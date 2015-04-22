package
{
   import mx.flash.ContainerMovieClip;
   
   public dynamic class slotItem_spellImgContainer extends ContainerMovieClip
   {
      
      public function slotItem_spellImgContainer()
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
