package blix.components.list
{
   import blix.signals.ISignal;
   import blix.layout.LayoutEntry;
   
   public interface IRendererFactory
   {
      
      function getEntryConstructed() : ISignal;
      
      function getEntryDeconstructed() : ISignal;
      
      function getEntryActivated() : ISignal;
      
      function getEntryDeactivated() : ISignal;
      
      function createEntry(param1:*) : LayoutEntry;
      
      function returnEntry(param1:LayoutEntry) : void;
      
      function clearCache() : void;
   }
}
