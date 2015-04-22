package com.riotgames.rust.theme
{
   import mx.logging.ILogger;
   import flash.net.URLRequest;
   import flash.filesystem.File;
   import com.riotgames.util.logging.getLogger;
   
   public class ThemeConfig extends Object
   {
      
      private static var _instance:ThemeConfig;
      
      private var logger:ILogger;
      
      private var _rawThemeString:String = "parchment";
      
      private var _themes:Vector.<String>;
      
      public function ThemeConfig()
      {
         this.logger = getLogger(this);
         super();
         this._themes = Vector.<String>(["parchment"]);
      }
      
      public static function get instance() : ThemeConfig
      {
         if(!_instance)
         {
            _instance = new ThemeConfig();
         }
         return _instance;
      }
      
      static function setInstance(param1:ThemeConfig) : void
      {
         _instance = param1;
      }
      
      public function set themeConfig(param1:String) : void
      {
         this._rawThemeString = param1;
         var _loc2_:Array = param1.split(",");
         this._themes = Vector.<String>(_loc2_);
      }
      
      public function get themeConfig() : String
      {
         return this._rawThemeString;
      }
      
      public function getThemes() : Vector.<String>
      {
         return this._themes;
      }
      
      public function getDoesThemeHavePrecedence(param1:String, param2:String) : Boolean
      {
         if(this._themes == null)
         {
            return false;
         }
         var _loc3_:int = this._themes.indexOf(param1);
         var _loc4_:int = this._themes.indexOf(param2);
         if(_loc3_ >= 0)
         {
            if((_loc4_ < 0) || (_loc3_ < _loc4_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getThemeAssetUrl(param1:String, param2:String) : URLRequest
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:File = null;
         for each(_loc3_ in this._themes)
         {
            _loc4_ = param1 + "/themes/" + _loc3_ + "/" + param2;
            _loc5_ = File.applicationDirectory.resolvePath(_loc4_);
            if(_loc5_.exists)
            {
               return new URLRequest(_loc4_);
            }
         }
         return null;
      }
      
      public function getThemeWatchPath(param1:String, param2:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:File = null;
         for each(_loc3_ in this._themes)
         {
            _loc4_ = param1 + "/themes/" + _loc3_ + "/" + param2;
            _loc5_ = File.applicationDirectory.resolvePath(_loc4_);
            if(_loc5_.exists)
            {
               return param1 + "/themes/" + _loc3_;
            }
         }
         return param1;
      }
   }
}
