package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   
   public interface IChampionImagesProvider extends IProvider
   {
      
      function getChromaSwatch(param1:String, param2:Number, param3:Function) : void;
      
      function getChampCard(param1:String, param2:Number, param3:Function) : void;
      
      function getNoSelectionChromaSwatch(param1:Function) : void;
      
      function getIcon(param1:String, param2:Number, param3:Function) : void;
   }
}
