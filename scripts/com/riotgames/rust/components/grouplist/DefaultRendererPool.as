package com.riotgames.rust.components.grouplist
{
   import blix.factory.ObjectPool;
   import blix.assets.proxy.DisplayObjectProxy;
   import blix.signals.Signal;
   import flash.geom.Rectangle;
   import blix.components.renderer.IDataRenderer;
   import blix.signals.ISignal;
   import blix.factory.IFactory;
   import blix.assets.IAssetsManager;
   
   public class DefaultRendererPool extends ObjectPool implements IRendererPool
   {
      
      private var _sampleRenderer:DisplayObjectProxy;
      
      private var _rendererBoundsChanged:Signal;
      
      public function DefaultRendererPool(param1:IFactory)
      {
         this._rendererBoundsChanged = new Signal();
         super(param1);
         this._sampleRenderer = getInstance();
         this._sampleRenderer.validateOffStage = true;
         var _loc2_:IAssetsManager = this._sampleRenderer.getDependency(IAssetsManager);
         _loc2_.getAssetsChanged().add(this.onAssetsChanged);
      }
      
      public function getRendererBounds(param1:*) : Rectangle
      {
         if(this._sampleRenderer is IDataRenderer)
         {
            (this._sampleRenderer as IDataRenderer).setData(param1);
            this._sampleRenderer.validate();
         }
         return this._sampleRenderer.getBounds();
      }
      
      private function onAssetsChanged() : void
      {
         this._rendererBoundsChanged.dispatch(this);
      }
      
      public function getRendererBoundsChanged() : ISignal
      {
         return this._rendererBoundsChanged;
      }
   }
}
