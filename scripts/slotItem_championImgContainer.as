package
{
   import mx.flash.ContainerMovieClip;
   
   public dynamic class slotItem_championImgContainer extends ContainerMovieClip
   {
      
      public function slotItem_championImgContainer()
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
