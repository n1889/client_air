package com.riotgames.platform.common.profile
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IOldProfileScreenProvider extends IProvider
   {
      
      function hide() : void;
      
      function show(param1:Number, param2:DisplayAdapter) : void;
   }
}
