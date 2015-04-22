package blix.context
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import blix.logger.ArrayTarget;
   
   public interface IApplicationContext extends IApplicationLoadable
   {
      
      function getRoot() : DisplayObject;
      
      function getSharedEvents() : IEventDispatcher;
      
      function getAppWidth() : Number;
      
      function getAppHeight() : Number;
      
      function getArrayLogTarget() : ArrayTarget;
   }
}
