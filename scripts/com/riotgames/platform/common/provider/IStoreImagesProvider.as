package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   
   public interface IStoreImagesProvider extends IProvider
   {
      
      function getMysterySkinPortrait(param1:Function) : void;
      
      function getChampIcon(param1:Number, param2:Function) : void;
      
      function getMysteryChampPortraitAssetPath() : String;
      
      function getMysteryChampIconAssetPath() : String;
      
      function getMysteryGenericIcon(param1:Function) : void;
      
      function getChampSkinPortrait(param1:Number, param2:Number, param3:Function) : void;
      
      function getMysteryGenericPortrait(param1:Function) : void;
      
      function getChampClassicPortrait(param1:Number, param2:Function, param3:Boolean = false) : void;
      
      function getMysteryGenericPortraitAssetPath() : String;
      
      function getMysterySkinIcon(param1:Function) : void;
      
      function getMysteryChampIcon(param1:Function) : void;
      
      function getMysteryChampPortrait(param1:Function) : void;
      
      function getChampSkinPortraitAssetNameFromChampIDAndSkinIndex(param1:Number, param2:Number) : String;
      
      function getMysterySkinIconAssetPath() : String;
      
      function getChampPortraitAssetNameFromChampID(param1:Number) : String;
      
      function getMysterySkinPortraitAssetPath() : String;
      
      function getChampSkinIcon(param1:Number, param2:Number, param3:Function) : void;
   }
}
