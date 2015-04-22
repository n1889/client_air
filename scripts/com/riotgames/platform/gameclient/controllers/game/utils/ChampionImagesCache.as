package com.riotgames.platform.gameclient.controllers.game.utils
{
   import com.riotgames.platform.common.provider.IChampionImagesProvider;
   import flash.utils.Dictionary;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.display.LoaderInfo;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class ChampionImagesCache extends Object implements IChampionImagesProvider
   {
      
      private static var _instance:IChampionImagesProvider;
      
      protected static var cachedImages:Dictionary = new Dictionary();
      
      public function ChampionImagesCache(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function get instance() : IChampionImagesProvider
      {
         if(!_instance)
         {
            _instance = new ChampionImagesCache(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function getChampCard(param1:String, param2:Number, param3:Function) : void
      {
         var _loc5_:String = null;
         var _loc4_:String = param1 + param2.toString() + ChampionImages.CHROMA_KEY;
         if(cachedImages[_loc4_] is Bitmap)
         {
            param3(this.duplicateBitmap(cachedImages[_loc4_]));
         }
         else if(cachedImages[_loc4_] is Object)
         {
            cachedImages[_loc4_].callbacks.push(param3);
         }
         else
         {
            _loc5_ = ChampionImages.getImagePath(param1,param2);
            this.loadRequestedImage(_loc4_,_loc5_,param3);
         }
         
      }
      
      private function duplicateBitmap(param1:Bitmap) : Bitmap
      {
         return new Bitmap(param1.bitmapData,"auto",true);
      }
      
      public function getIcon(param1:String, param2:Number, param3:Function) : void
      {
         var _loc5_:String = null;
         var _loc4_:String = param1 + param2;
         if(cachedImages[_loc4_] is Bitmap)
         {
            param3(this.duplicateBitmap(cachedImages[_loc4_]));
         }
         else if(cachedImages[_loc4_] is Object)
         {
            cachedImages[_loc4_].callbacks.push(param3);
         }
         else
         {
            _loc5_ = ChampionImages.getIconPath(param1,param2);
            this.loadRequestedImage(_loc4_,_loc5_,param3);
         }
         
      }
      
      public function getChromaSwatch(param1:String, param2:Number, param3:Function) : void
      {
         var _loc5_:String = null;
         var _loc4_:String = param1 + param2.toString() + ChampionImages.SWATCH_KEY;
         if(cachedImages[_loc4_] is Bitmap)
         {
            param3(this.duplicateBitmap(cachedImages[_loc4_]));
         }
         else if(cachedImages[_loc4_] is Object)
         {
            cachedImages[_loc4_].callbacks.push(param3);
         }
         else
         {
            _loc5_ = ChampionImages.getChromaSwatchPath(param1,param2);
            this.loadRequestedImage(_loc4_,_loc5_,param3);
         }
         
      }
      
      private function loadRequestedImage(param1:String, param2:String, param3:Function) : void
      {
         var key:String = param1;
         var path:String = param2;
         var callback:Function = param3;
         var loader:Loader = new Loader();
         var obj:Object = {
            "loader":loader,
            "callbacks":[callback]
         };
         cachedImages[key] = obj;
         var onLoadComplete:Function = function(param1:Event):void
         {
            var _loc5_:Function = null;
            var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
            var _loc3_:Array = cachedImages[key].callbacks;
            var _loc4_:Bitmap = _loc2_.content as Bitmap;
            cachedImages[key] = _loc4_;
            for each(_loc5_ in _loc3_)
            {
               _loc5_(duplicateBitmap(_loc4_));
            }
         };
         var onLoadError:Function = function(param1:Event):void
         {
            var _loc4_:Function = null;
            var _loc2_:Array = cachedImages[key].callbacks;
            var _loc3_:Bitmap = new Bitmap();
            cachedImages[key] = _loc3_;
            for each(_loc4_ in _loc2_)
            {
               _loc4_(_loc3_);
            }
         };
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadError);
         loader.load(new URLRequest(path));
      }
      
      public function getNoSelectionChromaSwatch(param1:Function) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = ChampionImages.NO_SELECTION_SWATCH_KEY;
         if(cachedImages[_loc2_] is Bitmap)
         {
            param1(this.duplicateBitmap(cachedImages[_loc2_]));
         }
         else if(cachedImages[_loc2_] is Object)
         {
            cachedImages[_loc2_].callbacks.push(param1);
         }
         else
         {
            _loc3_ = ChampionImages.getNoSelectionChromaSwatchPath();
            this.loadRequestedImage(_loc2_,_loc3_,param1);
         }
         
      }
   }
}

class SingletonEnforcer extends Object
{
   
   function SingletonEnforcer()
   {
      super();
   }
}
