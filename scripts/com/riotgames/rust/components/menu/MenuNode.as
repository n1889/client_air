package com.riotgames.rust.components.menu
{
   public class MenuNode extends Object
   {
      
      public var header;
      
      public var children:Array;
      
      public function MenuNode(param1:*, param2:Array)
      {
         super();
         this.header = param1;
         this.children = param2;
      }
   }
}
