package com.riotgames.rust.components.grouplist
{
   import blix.factory.IPool;
   import flash.geom.Rectangle;
   import blix.signals.ISignal;
   
   public interface IRendererPool extends IPool
   {
      
      function getRendererBounds(param1:*) : Rectangle;
      
      function getRendererBoundsChanged() : ISignal;
   }
}
