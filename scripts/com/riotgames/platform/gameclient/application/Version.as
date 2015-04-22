package com.riotgames.platform.gameclient.application
{
   public class Version extends Object
   {
      
      public static var CURRENT_VERSION:String = "5.7.15_04_05_19_47";
      
      public function Version()
      {
         super();
      }
      
      public function getVersion() : String
      {
         return Version.CURRENT_VERSION;
      }
   }
}
