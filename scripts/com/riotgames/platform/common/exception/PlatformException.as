package com.riotgames.platform.common.exception
{
   public class PlatformException extends Object
   {
      
      public var errorCode:String;
      
      public var substitutionArguments:Array;
      
      public var rootCauseClassname:String;
      
      public function PlatformException()
      {
         super();
      }
   }
}
