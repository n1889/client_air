package com.riotgames.pvpnet.docked
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayObjectContainerProxy;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   
   public interface IDockedChatProvider extends IProvider
   {
      
      function dock(param1:DisplayObjectContainerProxy) : void;
      
      function showPrivateChatWindow(param1:Buddy) : void;
   }
}
