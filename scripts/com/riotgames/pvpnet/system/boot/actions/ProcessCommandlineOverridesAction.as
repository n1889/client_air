package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import mx.logging.ILogger;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import com.riotgames.platform.common.utils.MultiValueProperty;
   import com.riotgames.util.logging.getLogger;
   
   public class ProcessCommandlineOverridesAction extends BasicAction
   {
      
      private var _invokeArguments:Vector.<String>;
      
      private var _configObjects:Array;
      
      private var unparsedArguments:Vector.<String>;
      
      private var params:Vector.<SimpleProperty>;
      
      var logger:ILogger;
      
      public function ProcessCommandlineOverridesAction(param1:Array, param2:Array)
      {
         this.unparsedArguments = new Vector.<String>();
         this.params = new Vector.<ProcessCommandlineOverridesAction>();
         super(false);
         if(param1 != null)
         {
            this._invokeArguments = Vector.<String>(param1);
         }
         else
         {
            this._invokeArguments = new Vector.<String>();
         }
         this._configObjects = param2;
         this.logger = getLogger(this);
      }
      
      override protected function doInvocation() : void
      {
         this.removeADLArguments();
         this.processParams();
         this.setPartnerCredentials();
         this.applyOverrides();
         complete();
      }
      
      private function removeADLArguments() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._invokeArguments)
         {
            if((_loc2_ == "--") && (_loc1_ > 3))
            {
               this._invokeArguments = this._invokeArguments.slice(_loc1_ + 1);
               break;
            }
            _loc1_++;
         }
      }
      
      private function processParams() : void
      {
         var _loc1_:String = null;
         var _loc2_:RegExp = null;
         var _loc3_:Object = null;
         for each(_loc1_ in this._invokeArguments)
         {
            _loc2_ = new RegExp("--([^=]+)=(.*)","g");
            _loc3_ = _loc2_.exec(_loc1_);
            if(_loc3_ == null)
            {
               this.unparsedArguments.push(_loc1_);
            }
            else
            {
               this.params.push(new SimpleProperty(_loc3_[1],_loc3_[2]));
            }
         }
      }
      
      private function setPartnerCredentials() : void
      {
         if(this.unparsedArguments.length > 1)
         {
            ClientConfig.instance.partnerCredentials = this.unparsedArguments.join(" ");
         }
      }
      
      private function applyOverrides() : void
      {
         var property:SimpleProperty = null;
         var configObject:Object = null;
         for each(property in this.params)
         {
            for each(configObject in this._configObjects)
            {
               if(configObject.hasOwnProperty(property.key))
               {
                  if(configObject[property.key] is MultiValueProperty)
                  {
                     (configObject[property.key] as MultiValueProperty).parsePropertyString(property.value);
                  }
                  else
                  {
                     try
                     {
                        configObject[property.key] = this.parseValue(property.value);
                     }
                     catch(e:Error)
                     {
                        logger.warn("ProcessCommandLineOverridesAction: Error setting property \'" + property.key + "\' to \'" + property.value + "\' : " + e.message);
                        continue;
                     }
                  }
               }
            }
         }
      }
      
      private function parseValue(param1:String) : Object
      {
         switch(param1)
         {
            case "true":
               return true;
            case "false":
               return false;
         }
      }
   }
}

class SimpleProperty extends Object
{
   
   public var key:String;
   
   public var value:String;
   
   function SimpleProperty(param1:String, param2:String)
   {
      super();
      this.key = param1;
      this.value = param2;
   }
}
