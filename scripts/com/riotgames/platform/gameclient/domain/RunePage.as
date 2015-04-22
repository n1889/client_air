package com.riotgames.platform.gameclient.domain
{
   import mx.collections.ArrayCollection;
   
   public class RunePage extends Object
   {
      
      public var index:int;
      
      public var title:String;
      
      public var runes:ArrayCollection;
      
      public var selectedRunes:ArrayCollection;
      
      public function RunePage()
      {
         super();
      }
   }
}
