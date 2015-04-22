package com.riotgames.platform.common.utils.file
{
   import flash.filesystem.File;
   import mx.logging.ILogger;
   import mx.logging.Log;
   
   public class OutputAssetsDir extends Object
   {
      
      private static var cachedBaseDir:File = null;
      
      private static const CONFIG_DIR_EXTENSIONS:Object = {
         "FILESTRUCTURE_RADS":RADS_CONFIG_DIR,
         "FILESTRUCTURE_DEV":RADS_CONFIG_DIR,
         "FILESTRUCTURE_SHALLOW":SHALLOW_CONFIG_DIR
      };
      
      private static const SHALLOW_GAME_DIR:String = "Game";
      
      private static const FILESTRUCTURE_SHALLOW:String = "FILESTRUCTURE_SHALLOW";
      
      private static const FILESTRUCTURE_DEV:String = "FILESTRUCTURE_DEV";
      
      private static var logger:ILogger = Log.getLogger("com.riotgames.platform.common.utils.file.OutputAssetsDir");
      
      private static const RADS_CONFIG_DIR:String = "Config";
      
      private static const RADSDIR_NAME:String = "RADS";
      
      private static const SHALLOW_LOL_DIR:String = "..";
      
      private static const FILESTRUCTURE_RADS:String = "FILESTRUCTURE_RADS";
      
      private static const SHALLOW_CONFIG_DIR:String = SHALLOW_GAME_DIR + "\\DATA\\CFG";
      
      private static const SHALLOW_PVPNET_DIR:String = "Air";
      
      private static var installedFileStructure:String = null;
      
      public function OutputAssetsDir()
      {
         super();
      }
      
      private static function GetRADsParentDir(param1:File) : File
      {
         var _loc2_:File = param1;
         while((_loc2_.exists) && (!(_loc2_.parent == null)))
         {
            if(_loc2_.resolvePath("./" + RADSDIR_NAME).exists)
            {
               return _loc2_;
            }
            _loc2_ = _loc2_.resolvePath("..");
         }
         return null;
      }
      
      private static function CheckShallowBaseDir(param1:File) : File
      {
         var _loc2_:File = param1.resolvePath(SHALLOW_LOL_DIR);
         if((_loc2_.exists) && (_loc2_.resolvePath(SHALLOW_GAME_DIR).exists) && (_loc2_.resolvePath(SHALLOW_PVPNET_DIR).exists))
         {
            return _loc2_;
         }
         return null;
      }
      
      public static function GetOutputBaseDir() : File
      {
         if((!(cachedBaseDir == null)) && (!(installedFileStructure == null)))
         {
            return cachedBaseDir;
         }
         var _loc1_:File = File.applicationStorageDirectory.resolvePath(File.applicationDirectory.nativePath);
         var _loc2_:File = GetRADsParentDir(_loc1_);
         if((_loc2_) && (_loc2_.exists))
         {
            installedFileStructure = FILESTRUCTURE_RADS;
            cachedBaseDir = _loc2_;
            return _loc2_;
         }
         _loc2_ = CheckShallowBaseDir(_loc1_);
         if((_loc2_) && (_loc2_.exists))
         {
            installedFileStructure = FILESTRUCTURE_SHALLOW;
            cachedBaseDir = _loc2_;
            return _loc2_;
         }
         installedFileStructure = FILESTRUCTURE_DEV;
         cachedBaseDir = _loc1_;
         return _loc1_;
      }
      
      public static function GetGameConfigFileDir() : File
      {
         var _loc1_:File = GetOutputBaseDir().resolvePath(CONFIG_DIR_EXTENSIONS[installedFileStructure]);
         if(!_loc1_.exists)
         {
            _loc1_.createDirectory();
         }
         return _loc1_;
      }
   }
}
