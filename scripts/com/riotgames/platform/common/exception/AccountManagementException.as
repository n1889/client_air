package com.riotgames.platform.common.exception
{
   import mx.managers.ISystemManager;
   import flash.net.registerClassAlias;
   
   public class AccountManagementException extends PlatformException
   {
      
      public function AccountManagementException()
      {
         super();
      }
      
      public static function init(param1:ISystemManager) : void
      {
         registerClassAlias("com.riotgames.platform.account.management.InvalidCredentialsException",AccountManagementException);
      }
   }
}
