package com.riotgames.platform.gameclient.controllers.game.utils
{
   import flash.filesystem.File;
   import mx.controls.SWFLoader;
   import com.riotgames.platform.gameclient.domain.Champion;
   
   public class ChampionImages extends Object
   {
      
      private static const BASE_ASSET_PATH:String = "/assets/images/champions/";
      
      private static const BASE_ASSET_PATH_NON_CONTENT:String = "/assets/images/championScreens/";
      
      public static const NO_SELECTION_SWATCH_KEY:String = "NoSwatch";
      
      private static const SWATCH_NOT_FOUND_PATH:String = "missingSwatch.png";
      
      private static const MISSING_CHAMPION_IMAGE_NAME:String = "missingChampion.jpg";
      
      public static const CHROMA_KEY:String = "Chroma";
      
      private static const NO_SELECTION_SWATCH_PATH:String = "chromaParent.jpg";
      
      public static const SWATCH_KEY:String = "Swatch";
      
      public function ChampionImages()
      {
         super();
      }
      
      public static function getChromaSwatchPath(param1:String, param2:Number = 0) : String
      {
         var _loc3_:String = BASE_ASSET_PATH.substring(1) + param1 + "_Swatch_" + param2.toString() + ".jpg";
         var _loc4_:File = File.applicationDirectory.resolvePath(_loc3_);
         if(_loc4_.exists)
         {
            return _loc3_;
         }
         return String(BASE_ASSET_PATH.substring(1) + SWATCH_NOT_FOUND_PATH);
      }
      
      public static function getSplashPath(param1:String, param2:Number = 0) : String
      {
         var _loc3_:String = param1;
         var _loc4_:String = ChampionImages.BASE_ASSET_PATH.substring(1) + _loc3_ + "_Splash_" + param2.toString() + ".jpg";
         var _loc5_:File = File.applicationDirectory.resolvePath(_loc4_);
         if((!_loc5_.exists) && (param2 > 0))
         {
            _loc4_ = ChampionImages.getSplashPath(param1,0);
         }
         return _loc4_;
      }
      
      public static function getNoSelectionChromaSwatchPath() : String
      {
         return BASE_ASSET_PATH.substring(1) + NO_SELECTION_SWATCH_PATH;
      }
      
      public static function getAnimatedChampion(param1:String, param2:Number = 0) : SWFLoader
      {
         var _loc3_:SWFLoader = null;
         var _loc4_:String = ChampionImages.BASE_ASSET_PATH + param1 + "_" + param2.toString() + ".swf";
         var _loc5_:File = File.applicationDirectory.resolvePath(_loc4_);
         if((!_loc5_.exists) && (param2 > 0))
         {
            _loc3_ = ChampionImages.getAnimatedChampion(param1,0);
         }
         else
         {
            _loc3_ = new SWFLoader();
            _loc3_.source = _loc4_;
         }
         return _loc3_;
      }
      
      public static function getImagePath(param1:String, param2:Number = 0) : String
      {
         var _loc3_:String = param1;
         var _loc4_:String = ChampionImages.BASE_ASSET_PATH.substring(1) + _loc3_ + "_" + param2.toString() + ".jpg";
         var _loc5_:File = File.applicationDirectory.resolvePath(_loc4_);
         if((!_loc5_.exists) && (param2 > 0))
         {
            _loc4_ = BASE_ASSET_PATH.substring(1) + MISSING_CHAMPION_IMAGE_NAME;
         }
         return _loc4_;
      }
      
      public static function getIconPath(param1:String, param2:Number = 0) : String
      {
         if(param1 == Champion.RANDOM_SKIN_NAME)
         {
            return "/" + ChampionImages.getImagePath(param1,param2);
         }
         var _loc3_:String = ChampionImages.BASE_ASSET_PATH + param1 + "_square_" + param2.toString() + ".png";
         var _loc4_:File = new File(_loc3_);
         if((!_loc4_.exists) && (param2 > 0))
         {
            _loc3_ = ChampionImages.getIconPath(param1,0);
         }
         return _loc3_;
      }
      
      public static function getIconPath_nonContent(param1:String) : String
      {
         return ChampionImages.BASE_ASSET_PATH_NON_CONTENT + param1 + ".png";
      }
   }
}
