package com.riotgames.util.string
{
   public class RiotStringUtil extends Object
   {
      
      public function RiotStringUtil()
      {
         super();
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         return (param1 == null) || (param1.length == 0);
      }
      
      public static function isBlank(param1:String) : Boolean
      {
         return (isEmpty(param1)) || (trim(param1).length == 0);
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:int = 0;
         while(isWhitespace(param1.charAt(_loc2_)))
         {
            _loc2_++;
         }
         var _loc3_:int = param1.length - 1;
         while(isWhitespace(param1.charAt(_loc3_)))
         {
            _loc3_--;
         }
         if(_loc3_ >= _loc2_)
         {
            return param1.slice(_loc2_,_loc3_ + 1);
         }
         return "";
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
         }
      }
      
      public static function firstToLower(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if((param1) && (param1.length > 0))
         {
            _loc2_ = param1.substr(0,1).toLowerCase();
            _loc3_ = param1.substr(1);
            return _loc2_ + _loc3_;
         }
         return param1;
      }
      
      public static function firstToUpper(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if((param1) && (param1.length > 0))
         {
            _loc2_ = param1.substr(0,1).toUpperCase();
            _loc3_ = param1.substr(1);
            return _loc2_ + _loc3_;
         }
         return param1;
      }
      
      public static function returnNullIfEmpty(param1:String) : String
      {
         if(isEmpty(param1))
         {
            return null;
         }
         return param1;
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         if((isEmpty(param1)) || (isEmpty(param2)))
         {
            return false;
         }
         if(param2.length > param1.length)
         {
            return false;
         }
         return param2 == param1.substring(param1.length - param2.length);
      }
   }
}
