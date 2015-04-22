package com.riotgames.pvpnet.system.product
{
   import blix.view.ILayoutElement;
   import blix.assets.proxy.IDisplayChild;
   import blix.IDestructible;
   
   public interface IProductChrome extends ILayoutElement, IDisplayChild, IDestructible
   {
      
      function show() : void;
      
      function hide() : void;
   }
}
