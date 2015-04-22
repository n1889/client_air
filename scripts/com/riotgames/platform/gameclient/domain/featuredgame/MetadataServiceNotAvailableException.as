package com.riotgames.platform.gameclient.domain.featuredgame
{
   import com.riotgames.platform.common.exception.PlatformException;
   import mx.managers.ISystemManager;
   import flash.net.registerClassAlias;
   
   public class MetadataServiceNotAvailableException extends PlatformException
   {
      
      public function MetadataServiceNotAvailableException()
      {
         super();
      }
      
      public static function init(param1:ISystemManager) : void
      {
         registerClassAlias("com.riotgames.platform.featuredgame.metadata.service.api.MetadataServiceNotAvailableException",MetadataServiceNotAvailableException);
      }
   }
}
