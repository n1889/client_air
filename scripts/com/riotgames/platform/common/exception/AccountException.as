package com.riotgames.platform.common.exception
{
   import mx.managers.ISystemManager;
   import flash.net.registerClassAlias;
   
   public class AccountException extends PlatformException
   {
      
      public function AccountException()
      {
         super();
      }
      
      public static function init(param1:ISystemManager) : void
      {
         registerClassAlias("com.riotgames.platform.account.AccountSaveFailedException",AccountException);
      }
   }
}
