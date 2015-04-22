package com.riotgames.platform.common.effect.darronschall.util
{
   public final class ColorUtil extends Object
   {
      
      public function ColorUtil()
      {
         super();
      }
      
      public static function intToRgb(param1:int) : Object
      {
         var _loc2_:int = (param1 & 16711680) >> 16;
         var _loc3_:int = (param1 & 65280) >> 8;
         var _loc4_:int = param1 & 255;
         return {
            "r":_loc2_,
            "g":_loc3_,
            "b":_loc4_
         };
      }
   }
}
