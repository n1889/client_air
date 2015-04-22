package blix.components.renderer
{
   import blix.view.IView;
   import blix.view.IValidatable;
   import blix.assets.proxy.IDisplayChild;
   import blix.IDestructible;
   
   public interface IDataRenderer extends IView, IValidatable, IDisplayChild, IDestructible
   {
      
      function getData() : *;
      
      function setData(param1:*) : void;
   }
}
