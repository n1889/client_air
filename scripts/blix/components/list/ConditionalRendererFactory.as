package blix.components.list
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import blix.layout.LayoutEntry;
   import blix.components.renderer.IItemRenderer;
   import blix.IDestructible;
   
   public class ConditionalRendererFactory extends Object implements IRendererFactory
   {
      
      protected var _entryConstructed:Signal;
      
      protected var _entryDeconstructed:Signal;
      
      protected var _entryActivated:Signal;
      
      protected var _entryDeactivated:Signal;
      
      protected var factoryFunction:Function;
      
      protected var rendererFactories:Vector.<IRendererFactory>;
      
      public function ConditionalRendererFactory(param1:Function)
      {
         this._entryConstructed = new Signal();
         this._entryDeconstructed = new Signal();
         this._entryActivated = new Signal();
         this._entryDeactivated = new Signal();
         this.rendererFactories = new Vector.<IRendererFactory>();
         super();
         this.factoryFunction = param1;
      }
      
      public function getEntryConstructed() : ISignal
      {
         return this._entryConstructed;
      }
      
      public function getEntryDeconstructed() : ISignal
      {
         return this._entryDeconstructed;
      }
      
      public function getEntryActivated() : ISignal
      {
         return this._entryActivated;
      }
      
      public function getEntryDeactivated() : ISignal
      {
         return this._entryDeactivated;
      }
      
      public function createEntry(param1:*) : LayoutEntry
      {
         var _loc2_:IRendererFactory = this.getFactory(param1);
         var _loc3_:LayoutEntry = _loc2_.createEntry(param1);
         return _loc3_;
      }
      
      public function returnEntry(param1:LayoutEntry) : void
      {
         var _loc2_:* = (param1.element as IItemRenderer).getData();
         var _loc3_:IRendererFactory = this.getFactory(_loc2_);
         _loc3_.returnEntry(param1);
      }
      
      protected function getFactory(param1:*) : IRendererFactory
      {
         var _loc2_:IRendererFactory = this.factoryFunction(param1);
         if(this.rendererFactories.indexOf(_loc2_) == -1)
         {
            _loc2_.getEntryActivated().add(this._entryActivated.dispatch,true);
            _loc2_.getEntryConstructed().add(this._entryConstructed.dispatch,true);
            _loc2_.getEntryDeactivated().add(this._entryDeactivated.dispatch,true);
            _loc2_.getEntryDeconstructed().add(this._entryDeconstructed.dispatch,true);
            this.rendererFactories.push(_loc2_);
         }
         return _loc2_;
      }
      
      public function clearCache() : void
      {
         var _loc1_:IRendererFactory = null;
         for each(_loc1_ in this.rendererFactories)
         {
            _loc1_.clearCache();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:IRendererFactory = null;
         for each(_loc1_ in this.rendererFactories)
         {
            if(_loc1_ is IDestructible)
            {
               (_loc1_ as IDestructible).destroy();
            }
         }
         this._entryConstructed.removeAll();
         this._entryDeconstructed.removeAll();
         this._entryActivated.removeAll();
         this._entryDeactivated.removeAll();
         this.factoryFunction = null;
      }
   }
}
