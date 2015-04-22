package com.riotgames.pvpnet.docked
{
   import com.riotgames.platform.provider.IProvider;
   import blix.components.button.ButtonX;
   import blix.assets.proxy.DisplayObjectContainerProxy;
   
   public interface IDockedFriendListProvider extends IProvider
   {
      
      function dock(param1:ButtonX, param2:DisplayObjectContainerProxy) : void;
   }
}
