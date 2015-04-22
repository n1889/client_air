package com.riotgames.platform.common.utils.app
{
   import mx.core.Application;
   
   public class ApplicationUtil extends Object
   {
      
      public function ApplicationUtil()
      {
         super();
      }
      
      public static function get application() : Object
      {
         return Application.application;
      }
   }
}
