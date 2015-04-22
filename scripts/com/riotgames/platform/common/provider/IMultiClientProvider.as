package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   import blix.context.IContext;
   import flash.display.DisplayObjectContainer;
   
   public interface IMultiClientProvider extends IProvider
   {
      
      function getContext() : IContext;
      
      function getDisplayRoot() : DisplayObjectContainer;
   }
}
