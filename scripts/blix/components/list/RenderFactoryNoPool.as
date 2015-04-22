package blix.components.list
{
   import blix.IDestructible;
   import blix.signals.Signal;
   import blix.view.ILayoutData;
   import blix.factory.ClassFactory;
   import blix.signals.ISignal;
   import blix.layout.LayoutEntry;
   import blix.components.renderer.IDataRenderer;
   
   public class RenderFactoryNoPool extends Object implements IRendererFactory, IDestructible
   {
      
      private var _entryConstructed:Signal;
      
      private var _entryDeconstructed:Signal;
      
      private var _entryActivated:Signal;
      
      private var _entryDeactivated:Signal;
      
      private var layoutData:ILayoutData;
      
      private var classFactory:ClassFactory;
      
      public function RenderFactoryNoPool(param1:Class, param2:Array = null, param3:ILayoutData = null)
      {
         this._entryConstructed = new Signal();
         this._entryDeconstructed = new Signal();
         this._entryActivated = new Signal();
         this._entryDeactivated = new Signal();
         super();
         this.classFactory = new ClassFactory(param1,param2);
         this.layoutData = param3;
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
         var _loc2_:LayoutEntry = null;
         var _loc3_:IDataRenderer = null;
         _loc3_ = this.classFactory.getInstance();
         _loc2_ = new LayoutEntry(_loc3_,this.layoutData);
         this._entryConstructed.dispatch(_loc2_,param1);
         this._entryActivated.dispatch(_loc2_,param1);
         if(param1 != _loc3_.getData())
         {
            _loc3_.setData(param1);
         }
         return _loc2_;
      }
      
      public function returnEntry(param1:LayoutEntry) : void
      {
         if(param1 == null)
         {
            throw new Error("Cannot return a null value to the pool.");
         }
         else
         {
            this._entryDeactivated.dispatch(param1);
            return;
         }
      }
      
      public function clearCache() : void
      {
      }
      
      public function getPoolCount() : uint
      {
         return 0;
      }
      
      public function destroy() : void
      {
         this.clearCache();
         this._entryConstructed.removeAll();
         this._entryDeconstructed.removeAll();
         this._entryActivated.removeAll();
         this._entryDeactivated.removeAll();
      }
   }
}
