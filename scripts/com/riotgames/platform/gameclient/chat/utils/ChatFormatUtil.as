package com.riotgames.platform.gameclient.chat.utils
{
   public class ChatFormatUtil extends Object
   {
      
      private static const LINK_REGEX:RegExp = new RegExp(LINK_REGEX_SRC,"ig");
      
      private static const LINK_REGEX_SRC:String = "\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)" + "(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^s()<>]+\\)))*\\))+" + "(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|" + "[^\\s`!()\\[\\]{};:\'\".,<>?������]))";
      
      public function ChatFormatUtil()
      {
         super();
         throw new Error("Static util class, do not instantiate");
      }
      
      private static function makeLinkTargetTag(param1:int) : String
      {
         return "<{" + param1 + "}>";
      }
      
      public static function hasUrl(param1:String) : Boolean
      {
         return param1.match(LINK_REGEX).length > 0;
      }
      
      public static function convertUrlsToLinks(param1:String, param2:String) : String
      {
         var _loc5_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc3_:Array = param1.match(LINK_REGEX);
         if((!_loc3_) || (_loc3_.length == 0))
         {
            return param1;
         }
         var _loc4_:String = param1;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc6_];
            _loc7_ = makeLinkTargetTag(_loc6_);
            do
            {
               _loc4_ = _loc4_.replace(_loc5_,_loc7_);
            }
            while(_loc4_.indexOf(_loc5_) != -1);
            
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc6_];
            _loc8_ = _loc5_;
            if(_loc8_.indexOf("http") < 0)
            {
               _loc8_ = "http://" + _loc8_;
            }
            _loc7_ = makeLinkTargetTag(_loc6_);
            _loc8_ = _loc8_.split("\'").join("%27");
            do
            {
               _loc4_ = _loc4_.replace(_loc7_,"<font color=\'" + param2 + "\'><u><a href=\'event:" + _loc8_ + "\'>" + _loc5_ + "</a></u></font>");
            }
            while(_loc4_.indexOf(_loc7_) != -1);
            
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
