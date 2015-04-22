package blix.assets.proxy
{
   import blix.IDestructible;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class DisplayAdapter extends Object implements IDestructible
   {
      
      private var parent:DisplayObjectContainerProxy;
      
      private var childDict:Dictionary;
      
      public function DisplayAdapter(param1:*)
      {
         this.childDict = new Dictionary(true);
         super();
         if(param1 is DisplayObjectContainerProxy)
         {
            this.parent = param1 as DisplayObjectContainerProxy;
         }
         else if(param1 is DisplayObjectContainer)
         {
            this.parent = new DisplayObjectContainerProxy(null,param1 as DisplayObjectContainer);
         }
         else
         {
            throw new ArgumentError("DisplayAdapter took an unknown parameter");
         }
         
      }
      
      public function addChild(param1:*) : void
      {
         var _loc2_:IDisplayChild = null;
         if(param1 is IDisplayChild)
         {
            _loc2_ = param1 as IDisplayChild;
         }
         else if(param1 is DisplayObject)
         {
            _loc2_ = new SimpleChild(param1 as DisplayObject);
         }
         else
         {
            throw new ArgumentError("child is an unsupported type.");
         }
         
         this.childDict[param1] = _loc2_;
         this.parent.addChild(_loc2_);
      }
      
      public function removeChild(param1:*) : Boolean
      {
         if(!(param1 in this.childDict))
         {
            return false;
         }
         var _loc2_:IDisplayChild = this.childDict[param1];
         delete this.childDict[param1];
         true;
         return this.parent.removeChild(_loc2_);
      }
      
      public function destroy() : void
      {
         this.childDict = null;
         this.parent.destroy();
      }
   }
}
