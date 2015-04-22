package com.riotgames.platform.common.utils
{
   public class DefaultSanitizer extends Object implements Sanitizer
   {
      
      public function DefaultSanitizer()
      {
         super();
      }
      
      public function sanitize(param1:String) : String
      {
         return param1;
      }
   }
}
