package com.riotgames.platform.gameclient.domain.invite
{
   public class InviteState extends Object
   {
      
      public static const NONE:String = "NONE";
      
      public static const INVITEE:String = "INVITEE";
      
      public static const INVITOR:String = "INVITOR";
      
      public function InviteState()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
   }
}
