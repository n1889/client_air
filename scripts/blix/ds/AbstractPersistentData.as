package blix.ds
{
   import blix.signals.Signal;
   import flash.net.SharedObject;
   import flash.net.ObjectEncoding;
   import flash.utils.getQualifiedClassName;
   import flash.net.registerClassAlias;
   import flash.utils.getDefinitionByName;
   import blix.util.ObjectUtils;
   import flash.events.NetStatusEvent;
   import flash.net.SharedObjectFlushStatus;
   
   public class AbstractPersistentData extends Object
   {
      
      private static var sharedObjects:Object = new Object();
      
      protected var _saveSuccess:Signal;
      
      protected var _saveFail:Signal;
      
      private var _cookieName:String;
      
      public function AbstractPersistentData(param1:String, param2:Boolean = false)
      {
         this._saveSuccess = new Signal();
         this._saveFail = new Signal();
         super();
         var _loc3_:String = getQualifiedClassName(this);
         if(Class(getDefinitionByName(_loc3_)) == AbstractPersistentData)
         {
            throw new Error("AbstractPersistentData must be extended");
         }
         else if(!param1)
         {
            throw new ArgumentError("Argument cookieName is required.");
         }
         else
         {
            this._cookieName = param1;
            if(param2)
            {
               this.fetch();
            }
            return;
         }
         
      }
      
      public function getSaveFail() : Signal
      {
         return this._saveFail;
      }
      
      public function getSaveSuccess() : Signal
      {
         return this._saveSuccess;
      }
      
      public function getCookieName() : String
      {
         return this._cookieName;
      }
      
      protected function getSo() : SharedObject
      {
         if(sharedObjects[this._cookieName] != null)
         {
            return sharedObjects[this._cookieName];
         }
         var _loc1_:SharedObject = SharedObject.getLocal(this._cookieName);
         _loc1_.objectEncoding = ObjectEncoding.AMF3;
         sharedObjects[this._cookieName] = _loc1_;
         return _loc1_;
      }
      
      public function fetch() : void
      {
         var className:String = getQualifiedClassName(this);
         var classNameParts:Array = className.split("::");
         var classAliasName:String = classNameParts.pop() + "Alias";
         registerClassAlias(classAliasName,Class(getDefinitionByName(className)));
         var sO:SharedObject = this.getSo();
         if(sO.data.data)
         {
            try
            {
               ObjectUtils.mergeObjects(this,sO.data.data);
            }
            catch(error:Error)
            {
               clear();
            }
         }
      }
      
      public function clear() : void
      {
         this.getSo().clear();
      }
      
      public function save() : void
      {
         this.clear();
         var sO:SharedObject = this.getSo();
         sO.data.data = this;
         var flushStatus:String = null;
         try
         {
            flushStatus = sO.flush(sO.size);
         }
         catch(error:Error)
         {
            _saveFail.dispatch();
         }
         if(flushStatus != null)
         {
            switch(flushStatus)
            {
               case SharedObjectFlushStatus.PENDING:
                  sO.addEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
                  break;
               case SharedObjectFlushStatus.FLUSHED:
                  this._saveSuccess.dispatch();
                  break;
            }
         }
      }
      
      private function onFlushStatus(param1:NetStatusEvent) : void
      {
         this.getSo().removeEventListener(NetStatusEvent.NET_STATUS,this.onFlushStatus);
         switch(param1.info.code)
         {
            case "SharedObject.Flush.Success":
               this._saveSuccess.dispatch();
               break;
            case "SharedObject.Flush.Failed":
               this._saveFail.dispatch();
               break;
         }
      }
   }
}
