package com.riotgames.platform.gameclient.chat.domain
{
   public class RecofrienderStatusDto extends Object
   {
      
      public var linked:Vector.<RecofrienderLinkStatusDto>;
      
      public var accountId:Number;
      
      public var platformId:String;
      
      public var contacts:Vector.<RecofrienderContactInfoDto>;
      
      public var tags:Object;
      
      public function RecofrienderStatusDto()
      {
         super();
      }
      
      public static function buildFromJson(param1:Object) : RecofrienderStatusDto
      {
         var _loc3_:Object = null;
         var _loc2_:RecofrienderStatusDto = new RecofrienderStatusDto();
         _loc2_.platformId = param1.platformId;
         _loc2_.accountId = param1.accountId;
         _loc2_.contacts = new Vector.<RecofrienderContactInfoDto>();
         _loc2_.tags = param1.tags;
         for each(_loc3_ in param1.contacts)
         {
            _loc2_.contacts.push(RecofrienderContactInfoDto.buildFromJson(_loc3_));
         }
         _loc2_.linked = new Vector.<RecofrienderLinkStatusDto>();
         for each(_loc3_ in param1.linked)
         {
            _loc2_.linked.push(RecofrienderLinkStatusDto.buildFromJson(_loc3_));
         }
         return _loc2_;
      }
      
      public function getPlatformId() : String
      {
         return this.platformId;
      }
      
      public function getFacebookNotify() : Boolean
      {
         var _loc1_:* = false;
         if((!(this.tags == null)) && (!(this.tags["fb-notify"] == null)))
         {
            _loc1_ = this.tags["fb-notify"];
         }
         else
         {
            _loc1_ = false;
         }
         trace("notify status is : " + _loc1_);
         return _loc1_;
      }
      
      public function getContacts() : Vector.<RecofrienderContactInfoDto>
      {
         return this.contacts;
      }
      
      public function getAccountId() : Number
      {
         return this.accountId;
      }
      
      public function getLinked() : Vector.<RecofrienderLinkStatusDto>
      {
         return this.linked;
      }
      
      public function getTags() : Object
      {
         return this.tags;
      }
   }
}
