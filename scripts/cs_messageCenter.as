package
{
   public dynamic class cs_messageCenter extends MessageCenter
   {
      
      public function cs_messageCenter()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame15() : *
      {
         gotoAndStop(1);
      }
   }
}
