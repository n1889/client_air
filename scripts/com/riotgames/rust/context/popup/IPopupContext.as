package com.riotgames.rust.context.popup
{
   import blix.assets.proxy.IDisplayChild;
   import blix.assets.proxy.DisplayObjectProxy;
   
   public interface IPopupContext
   {
      
      function addPopup(param1:IDisplayChild) : void;
      
      function removePopup(param1:IDisplayChild) : void;
      
      function setPosition(param1:DisplayObjectProxy, param2:DisplayObjectProxy, param3:int, param4:int) : void;
   }
}
