package blix.assets
{
   import blix.context.Context;
   import flash.net.URLRequest;
   import blix.signals.SteadyFrameSignal;
   import blix.action.LoaderAction;
   import blix.signals.ISignal;
   import flash.system.ApplicationDomain;
   import blix.action.IAction;
   import flash.system.LoaderContext;
   import flash.display.MovieClip;
   import flash.display.Loader;
   
   public class AssetsLoader extends Context implements IAssetsLoader
   {
      
      protected var _assetsChanged:SteadyFrameSignal;
      
      protected var _assetsLoaders:Vector.<LoaderAction>;
      
      public function AssetsLoader()
      {
         this._assetsChanged = new SteadyFrameSignal();
         this._assetsLoaders = new Vector.<LoaderAction>();
         super();
      }
      
      protected static function compareUrlRequests(param1:URLRequest, param2:URLRequest) : Boolean
      {
         var _loc3_:String = param1.data as String;
         var _loc4_:String = param2.data as String;
         return (param1.url == param2.url) && (_loc3_ == _loc4_) && (param1.method == param2.method);
      }
      
      public function getAssetsLoaders() : Vector.<LoaderAction>
      {
         return this._assetsLoaders;
      }
      
      public function getAssetsChanged() : ISignal
      {
         return this._assetsChanged;
      }
      
      public function getAssetByLinkage(param1:String, param2:* = null) : Class
      {
         var _loc3_:LoaderAction = null;
         var _loc4_:ApplicationDomain = null;
         for each(_loc3_ in this._assetsLoaders)
         {
            if(param2 != null)
            {
               if(_loc3_.urlRequest.url.search(param2) == -1)
               {
                  continue;
               }
            }
            _loc4_ = _loc3_.getApplicationDomain();
            if(_loc4_ != null)
            {
               if(_loc4_.hasDefinition(param1))
               {
                  return _loc4_.getDefinition(param1) as Class;
               }
            }
         }
         return null;
      }
      
      public function getBytesLoaded() : uint
      {
         var _loc2_:LoaderAction = null;
         var _loc1_:uint = 0;
         for each(_loc2_ in this.getAssetsLoaders())
         {
            _loc1_ = _loc1_ + _loc2_.loader.contentLoaderInfo.bytesLoaded;
         }
         return _loc1_;
      }
      
      public function getBytesTotal() : uint
      {
         var _loc2_:LoaderAction = null;
         var _loc3_:uint = 0;
         var _loc1_:uint = 0;
         for each(_loc2_ in this.getAssetsLoaders())
         {
            _loc3_ = _loc2_.loader.contentLoaderInfo.bytesTotal;
            if((_loc3_ == 0) && (_loc2_.getHasBeenInvoked()))
            {
               _loc3_ = 1;
            }
            _loc1_ = _loc1_ + _loc3_;
         }
         return _loc1_;
      }
      
      public function unloadAssets(param1:URLRequest) : void
      {
         var _loc4_:LoaderAction = null;
         var _loc2_:uint = this._assetsLoaders.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._assetsLoaders[_loc3_];
            if(compareUrlRequests(_loc4_.urlRequest,param1))
            {
               _loc4_.getCompleted().remove(this.assetsCompletedHandler);
               this._assetsLoaders.splice(_loc3_,1);
               if(_loc4_.getCompleted())
               {
                  _loc4_.loader.unloadAndStop(true);
               }
               else
               {
                  _loc4_.abort();
               }
               this._assetsChanged.dispatch();
               return;
            }
            _loc3_++;
         }
      }
      
      public function loadAssets(param1:URLRequest, param2:LoaderContext = null) : IAction
      {
         this.unloadAssets(param1);
         var _loc3_:LoaderAction = new LoaderAction(param1,param2);
         this._assetsLoaders[this._assetsLoaders.length] = _loc3_;
         _loc3_.getCompleted().add(this.assetsCompletedHandler);
         _loc3_.invoke();
         return _loc3_;
      }
      
      private function assetsCompletedHandler(param1:LoaderAction) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:uint = 0;
         var _loc2_:Loader = param1.loader;
         if(_loc2_.content is MovieClip)
         {
            _loc3_ = _loc2_.content as MovieClip;
            _loc3_.stop();
            _loc4_ = _loc3_.numChildren;
            while(_loc4_--)
            {
               _loc3_.removeChildAt(0);
            }
         }
         this._assetsChanged.dispatch();
      }
      
      public function getAssetRequests() : Vector.<URLRequest>
      {
         var _loc2_:LoaderAction = null;
         var _loc1_:Vector.<URLRequest> = new Vector.<URLRequest>();
         for each(_loc2_ in this._assetsLoaders)
         {
            _loc1_[_loc1_.length] = _loc2_.urlRequest;
         }
         return _loc1_;
      }
      
      public function reloadAssets() : void
      {
         var _loc1_:LoaderAction = null;
         for each(_loc1_ in this._assetsLoaders)
         {
            _loc1_.reset();
            _loc1_.invoke();
         }
      }
   }
}
