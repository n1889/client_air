package com.riotgames.platform.gameclient.chat.domain
{
   public class RecofrienderLinkStatusDto extends Object
   {
      
      public static const STATUS_ERROR:String = "ERROR";
      
      public static const STATUS_NOT_REGISTERED:String = "NOT-REGISTERED";
      
      public static const STATUS_SUCCESS:String = "SUCCESS";
      
      public static const STATUS_NOT_ALLOWED:String = "NOT-ALLOWED";
      
      public var reason:String;
      
      public var linked:Boolean;
      
      public var name:String;
      
      public function RecofrienderLinkStatusDto()
      {
         super();
      }
      
      public static function buildFromJson(param1:Object) : RecofrienderLinkStatusDto
      {
         var _loc2_:RecofrienderLinkStatusDto = new RecofrienderLinkStatusDto();
         _loc2_.name = param1.name;
         _loc2_.linked = param1.linked;
         _loc2_.reason = param1.reason;
         return _loc2_;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getReason() : String
      {
         return this.reason;
      }
      
      public function equals(param1:RecofrienderLinkStatusDto) : Boolean
      {
         return (this.name == param1.name) && (this.linked == param1.linked) && (this.reason == param1.reason);
      }
      
      public function getLinked() : Boolean
      {
         return this.linked;
      }
   }
}
