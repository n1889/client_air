package blix.assets
{
   import flash.net.URLRequest;
   import blix.action.IAction;
   import flash.system.LoaderContext;
   
   public interface IAssetsLoader extends IAssetsManager
   {
      
      function getBytesLoaded() : uint;
      
      function getBytesTotal() : uint;
      
      function unloadAssets(param1:URLRequest) : void;
      
      function loadAssets(param1:URLRequest, param2:LoaderContext = null) : IAction;
      
      function getAssetRequests() : Vector.<URLRequest>;
   }
}
