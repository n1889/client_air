package com.riotgames.platform.gameclient.domain.broadcast
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   import com.riotgames.platform.gameclient.domain.rankedTeams.TeamId;
   
   public class ClientLoginRankedTeamDeletedNotification extends Object implements IClientNotification
   {
      
      public var teamName:String;
      
      public var teamTag:String;
      
      public var teamId:TeamId;
      
      public function ClientLoginRankedTeamDeletedNotification()
      {
         super();
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.LOGIN_DELETED;
      }
   }
}
