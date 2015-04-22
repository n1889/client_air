package blix.action
{
   import flash.system.LoaderContext;
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.ErrorEvent;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.net.URLLoaderDataFormat;
   
   public class LoadBytesAction extends UrlLoaderAction
   {
      
      public var context:LoaderContext;
      
      public var loader:Loader;
      
      public function LoadBytesAction(param1:URLRequest = null, param2:Boolean = false)
      {
         this.loader = new Loader();
         super(param1,URLLoaderDataFormat.BINARY,param2);
         this.createDefaultContext();
      }
      
      public function createDefaultContext() : void
      {
         this.context = new LoaderContext(false,new ApplicationDomain(ApplicationDomain.currentDomain));
         if(this.context.hasOwnProperty("allowCodeImport"))
         {
            this.context["allowCodeImport"] = true;
         }
         if(this.context.hasOwnProperty("allowLoadBytesCodeExecution"))
         {
            this.context["allowLoadBytesCodeExecution"] = true;
         }
      }
      
      override protected function completedHandler(param1:Event) : void
      {
         var event:Event = param1;
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loaderCompletedHandler);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loaderErredHandler);
         this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loaderErredHandler);
         var bytes:ByteArray = _urlLoader.data as ByteArray;
         try
         {
            this.loader.loadBytes(bytes,this.context);
         }
         catch(error:Error)
         {
            err(error);
         }
         bytes.clear();
      }
      
      private function loaderErredHandler(param1:ErrorEvent) : void
      {
         err(new Error(param1.text));
      }
      
      private function loaderCompletedHandler(param1:Event) : void
      {
         (param1.currentTarget as IEventDispatcher).removeEventListener(param1.type,this.loaderCompletedHandler);
         complete();
      }
   }
}
