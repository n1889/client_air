package com.riotgames.platform.common.provider
{
   import com.riotgames.platform.provider.IProvider;
   
   public interface IFullScreenPopupProvider extends IProvider
   {
      
      function close() : void;
      
      function displayFullScreenPopup(param1:String) : void;
   }
}
