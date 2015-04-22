package com.riotgames.platform.gameclient.domain.invite
{
   import mx.logging.ILogger;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class InviteParticipantState extends Object
   {
      
      private static const MEMBER_STATES:Array = [OWNER,CREATOR,ACCEPTED,JOINED];
      
      public static const JOINED:String = "JOINED";
      
      public static const CREATOR:String = "CREATOR";
      
      public static const QUIT:String = "QUIT";
      
      private static const LOGGER:ILogger = Log.getLogger(getQualifiedClassName(InviteParticipantState).replace(new RegExp("::"),"."));
      
      public static const OWNER:String = "OWNER";
      
      public static const ACCEPTED:String = "ACCEPTED";
      
      public static const UNKNOWN:String = "UNKNOWN";
      
      public static const REJECTED_FULL:String = "REJECTED-FULL";
      
      public static const PENDING:String = "PENDING";
      
      public static const CANCEL:String = "CANCEL";
      
      public static const REJECTED:String = "REJECTED";
      
      public function InviteParticipantState()
      {
         super();
         throw new Error("Cannot create an instance of this class.");
      }
      
      public static function isMemberState(param1:String) : Boolean
      {
         return !(MEMBER_STATES.indexOf(param1) == -1);
      }
      
      public static function fromPlatformInviteeState(param1:String) : String
      {
         switch(param1)
         {
            case "CREATOR":
               return CREATOR;
            case "PENDING":
               return PENDING;
            case "DECLINED":
               return REJECTED;
            case "ACCEPTED":
               return ACCEPTED;
            case "ACCEPT_FAILED":
               return REJECTED_FULL;
            case "JOINED":
               return JOINED;
            case "QUIT":
               return QUIT;
            case "KICKED":
               return CANCEL;
            case "BANNED":
               return CANCEL;
         }
      }
   }
}
