package com.riotgames.platform.common.exception
{
   public class UnexpectedServiceException extends Object
   {
      
      public var message:String;
      
      public var rootCauseClassname:String;
      
      public var stackTraceString:String;
      
      public function UnexpectedServiceException()
      {
         super();
      }
   }
}
