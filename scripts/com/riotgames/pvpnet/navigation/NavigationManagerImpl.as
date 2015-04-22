package com.riotgames.pvpnet.navigation
{
   import blix.signals.Signal;
   import mx.logging.ILogger;
   import blix.signals.ISignal;
   import com.riotgames.util.logging.getLogger;
   
   public class NavigationManagerImpl extends Object implements INavigationManager
   {
      
      private var _path:String = "";
      
      private var _pathChanged:Signal;
      
      private var _history:Vector.<String>;
      
      private var logger:ILogger;
      
      private var _modalDialogPathChanged:Signal;
      
      private var _recursionCounter:uint = 0;
      
      private var _pathSplit:Array;
      
      public function NavigationManagerImpl()
      {
         this._pathChanged = new Signal();
         this._modalDialogPathChanged = new Signal();
         this._pathSplit = [];
         this.logger = getLogger(this);
         this._history = new Vector.<String>();
         super();
      }
      
      public function navigateToLast() : void
      {
         if(this._history.length > 0)
         {
            this.setPath(this._history.pop(),false);
         }
      }
      
      public function getPath() : String
      {
         return "/" + this._path;
      }
      
      public function modalDialog(param1:String) : void
      {
         this._modalDialogPathChanged.dispatch(param1);
      }
      
      private function setPath(param1:String, param2:Boolean = true) : void
      {
         var _loc4_:String = null;
         var _loc3_:String = this._path;
         if(_loc3_ == param1)
         {
            return;
         }
         this._path = param1;
         this._pathSplit = param1?param1.split("/"):[];
         this._recursionCounter++;
         if(this._recursionCounter > 10)
         {
            _loc4_ = "Infinite recursion detected; Do not navigate on a pathChanged signal.";
            this.logger.error(_loc4_);
            throw new Error(_loc4_);
         }
         else
         {
            this._pathChanged.dispatch(this,"/" + _loc3_,"/" + param1);
            if((!(_loc3_ == "")) && (param2))
            {
               this._history.push(_loc3_);
            }
            this._recursionCounter = 0;
            return;
         }
      }
      
      public function getModalDialogPathChanged() : ISignal
      {
         return this._modalDialogPathChanged;
      }
      
      public function navigate(param1:String) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         if(!param1)
         {
            return;
         }
         if(param1 == null)
         {
            var param1:String = "";
         }
         param1 = param1.replace(new RegExp("\\\\","g"),"/");
         if(param1.charAt(0) == "/")
         {
            this.setPath(param1.substring(1));
         }
         else
         {
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = param1.split("/");
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_ == "..")
               {
                  _loc2_++;
                  _loc3_++;
                  continue;
               }
               if(_loc5_ == ".")
               {
                  _loc3_++;
                  continue;
               }
               break;
            }
            if(_loc2_ > this._pathSplit.length)
            {
               _loc10_ = "Invalid navigation, from: " + this._path + " to: " + param1;
               this.logger.error(_loc10_);
               throw new ArgumentError(_loc10_);
            }
            else
            {
               _loc6_ = this._pathSplit.slice(0,this._pathSplit.length - _loc2_);
               _loc7_ = _loc4_.slice(_loc3_,_loc4_.length);
               _loc8_ = _loc6_.concat(_loc7_);
               _loc9_ = _loc8_.join("/");
               this.setPath(_loc9_);
            }
         }
      }
      
      public function getPathChanged() : ISignal
      {
         return this._pathChanged;
      }
      
      public function getPathSplit() : Array
      {
         return this._pathSplit;
      }
   }
}
