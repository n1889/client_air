package com.riotgames.gameItems.model
{
   public class ItemCategory extends Object
   {
      
      public var id:int;
      
      public var name:String;
      
      public var tags:Vector.<ItemTag>;
      
      public function ItemCategory()
      {
         this.tags = new Vector.<ItemTag>();
         super();
      }
   }
}
