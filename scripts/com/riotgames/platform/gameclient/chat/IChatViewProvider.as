package com.riotgames.platform.gameclient.chat
{
   import com.riotgames.platform.provider.IProvider;
   import blix.assets.proxy.DisplayAdapter;
   
   public interface IChatViewProvider extends IProvider
   {
      
      function getChatRoomView(param1:DisplayAdapter) : IChatRoomView;
   }
}
