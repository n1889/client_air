package com.riotgames.platform.gameclient.domain.broadcast
{
   import com.riotgames.platform.gameclient.notification.IClientNotification;
   import flash.utils.IExternalizable;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.notification.ClientNotificationType;
   import flash.utils.IDataInput;
   import com.riotgames.util.json.jsonDecode;
   import flash.utils.IDataOutput;
   import mx.logging.ILogger;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class BroadcastNotification extends Object implements IClientNotification, IExternalizable
   {
      
      public var broadcastMessages:ArrayCollection = null;
      
      private var logger:ILogger;
      
      public function BroadcastNotification()
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
      }
      
      private function assignProps(param1:Object) : void
      {
         var _loc2_:Object = null;
         this.broadcastMessages = new ArrayCollection();
         for each(_loc2_ in param1.broadcastMessages)
         {
            this.broadcastMessages.addItem(this.copyProps(_loc2_,new BroadcastMessage()));
         }
      }
      
      public function get notificationType() : String
      {
         return ClientNotificationType.TICKER;
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         var _loc4_:Object = null;
         var _loc2_:int = param1.readInt();
         var _loc3_:String = param1.readUTFBytes(_loc2_);
         if(_loc3_ != null)
         {
            _loc4_ = jsonDecode(_loc3_);
            this.assignProps(_loc4_);
         }
         else
         {
            this.logger.error("json was null!");
         }
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         throw new Error("NotImplementedException");
      }
      
      private function copyProps(param1:Object, param2:Object) : *
      {
         var _loc3_:String = null;
         for(_loc3_ in param1)
         {
            param2[_loc3_] = param1[_loc3_];
         }
         return param2;
      }
   }
}
