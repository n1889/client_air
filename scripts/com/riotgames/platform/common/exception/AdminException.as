package com.riotgames.platform.common.exception
{
   import mx.managers.ISystemManager;
   import flash.net.registerClassAlias;
   
   public class AdminException extends PlatformException
   {
      
      public function AdminException()
      {
         super();
      }
      
      public static function init(param1:ISystemManager) : void
      {
         registerClassAlias("com.riotgames.platform.admin.InvitationNotFoundException",AdminException);
      }
   }
}
