package com.riotgames.championdetails.model
{
   import blix.util.string.padNumber;
   
   public class ChampionSkin extends Object
   {
      
      public var id:uint;
      
      public var championId:uint;
      
      public var name:String;
      
      public var displayName:String;
      
      public var portraitPath:String;
      
      public var rank:int;
      
      public var splashPath:String;
      
      public var isFallback:Boolean;
      
      public var fallbackIndex:int;
      
      public var chromas:Vector.<ChampionSkin>;
      
      public function ChampionSkin()
      {
         super();
      }
      
      public function toString() : String
      {
         return "[ChampionSkin id=" + this.id + " name=\'" + this.name + "\']";
      }
      
      public function getFullId() : String
      {
         return "championsskin_" + this.championId + padNumber(this.rank,3);
      }
   }
}
