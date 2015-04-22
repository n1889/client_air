package com.riotgames.platform.common.exception
{
   public class LoginFailedException extends PlatformException
   {
      
      public var bannedUntilDate:Number;
      
      public function LoginFailedException()
      {
         super();
      }
   }
}
