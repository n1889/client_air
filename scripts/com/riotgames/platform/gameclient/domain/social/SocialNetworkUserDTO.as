package com.riotgames.platform.gameclient.domain.social
{
   import mx.collections.ArrayCollection;
   
   public class SocialNetworkUserDTO extends Object
   {
      
      public var summoners:ArrayCollection;
      
      public var hashedNetworkUserId:String;
      
      public var realName:String;
      
      public var invitedTime:Number;
      
      public var networkUserId:String;
      
      public var network:String;
      
      public function SocialNetworkUserDTO()
      {
         super();
      }
   }
}
