package
{
   import mx.flash.ContainerMovieClip;
   
   public dynamic class cs_championItem extends ContainerMovieClip
   {
      
      public var banned:championItem_banned;
      
      public function cs_championItem()
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
