package com.riotgames.platform.gameclient.chat.domain
{
   public class RecofrienderContactDetailsDto extends Object
   {
      
      public var accountId:Number;
      
      public var summonerId:Number;
      
      public var name:String;
      
      public var platformId:String;
      
      public var imageUrl:String;
      
      public function RecofrienderContactDetailsDto()
      {
         super();
      }
      
      public static function buildFromJson(param1:Object) : RecofrienderContactDetailsDto
      {
         var _loc2_:RecofrienderContactDetailsDto = new RecofrienderContactDetailsDto();
         _loc2_.platformId = param1.platformId;
         _loc2_.accountId = param1.accountId;
         _loc2_.summonerId = param1.summonerId;
         _loc2_.name = param1.name;
         _loc2_.imageUrl = param1.imageUrl;
         return _loc2_;
      }
      
      public function getName() : String
      {
         return this.name;
      }
      
      public function getPlatformId() : String
      {
         return this.platformId;
      }
      
      public function getImageUrl() : String
      {
         return this.imageUrl;
      }
      
      public function getAccountId() : Number
      {
         return this.accountId;
      }
      
      public function getSummonerId() : Number
      {
         return this.summonerId;
      }
   }
}
