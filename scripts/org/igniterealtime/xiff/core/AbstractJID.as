package org.igniterealtime.xiff.core
{
   public class AbstractJID extends Object
   {
      
      protected static var jidNodeValidator:RegExp = new RegExp("^([\\x29\\x23-\\x25\\x28-\\x2E\\x30-\\x39\\x3B\\x3D\\x3F\\x41-\\x7E\\xA0    　 -  -​۝ ܏᠎‌-‍ - - ⁠-⁣⁪-⁯￹-￼-uFDD0-uFDEF uFFFE-uFFFF?-?￹-�⿰-⿻]{1,1023})");
      
      private static var quoteregex:RegExp = new RegExp("\"","g");
      
      private static var quoteregex2:RegExp = new RegExp("\'","g");
      
      protected var _node:String = "";
      
      protected var _domain:String = "";
      
      protected var _resource:String = "";
      
      private var _bareJIDCache:String;
      
      public function AbstractJID(param1:String, param2:Boolean = false)
      {
         super();
         if(param2)
         {
            if((!jidNodeValidator.test(param1)) || (param1.indexOf(" ") > -1))
            {
               throw "Invalid JID";
            }
         }
         var _loc3_:int = param1.lastIndexOf("@");
         var _loc4_:int = param1.lastIndexOf("/");
         if(_loc4_ >= 0)
         {
            this._resource = param1.substring(_loc4_ + 1);
         }
         this._domain = param1.substring(_loc3_ + 1,_loc4_ >= 0?_loc4_:param1.length);
         if(_loc3_ >= 1)
         {
            this._node = param1.substring(0,_loc3_);
         }
      }
      
      public static function escapedNode(param1:String) : String
      {
         if((param1) && ((param1.indexOf("@") >= 0) || (param1.indexOf(" ") >= 0) || (param1.indexOf("\\") >= 0) || (param1.indexOf("/") >= 0) || (param1.indexOf("&") >= 0) || (param1.indexOf("\'") >= 0) || (param1.indexOf("\"") >= 0) || (param1.indexOf(":") >= 0) || (param1.indexOf("<") >= 0) || (param1.indexOf(">") >= 0)))
         {
            var param1:String = param1.replace(new RegExp("\\\\","g"),"\\5c");
            param1 = param1.replace(new RegExp("@","g"),"\\40");
            param1 = param1.replace(new RegExp(" ","g"),"\\20");
            param1 = param1.replace(new RegExp("&","g"),"\\26");
            param1 = param1.replace(new RegExp(">","g"),"\\3e");
            param1 = param1.replace(new RegExp("<","g"),"\\3c");
            param1 = param1.replace(new RegExp(":","g"),"\\3a");
            param1 = param1.replace(new RegExp("\\/","g"),"\\2f");
            param1 = param1.replace(quoteregex,"\\22");
            param1 = param1.replace(quoteregex2,"\\27");
         }
         return param1;
      }
      
      public static function unescapedNode(param1:String) : String
      {
         if((param1) && ((param1.indexOf("\\40") >= 0) || (param1.indexOf("\\20") >= 0) || (param1.indexOf("\\26") >= 0) || (param1.indexOf("\\3e") >= 0) || (param1.indexOf("\\3c") >= 0) || (param1.indexOf("\\5c") >= 0) || (param1.indexOf("\\3a") >= 0) || (param1.indexOf("\\2f") >= 0) || (param1.indexOf("\\22") >= 0) || (param1.indexOf("\\27") >= 0)))
         {
            var param1:String = param1.replace(new RegExp("\\40","g"),"@");
            param1 = param1.replace(new RegExp("\\20","g")," ");
            param1 = param1.replace(new RegExp("\\26","g"),"&");
            param1 = param1.replace(new RegExp("\\3e","g"),">");
            param1 = param1.replace(new RegExp("\\3c","g"),"<");
            param1 = param1.replace(new RegExp("\\3a","g"),":");
            param1 = param1.replace(new RegExp("\\2f","g"),"/");
            param1 = param1.replace(quoteregex,"\"");
            param1 = param1.replace(quoteregex2,"\'");
            param1 = param1.replace(new RegExp("\\5c","g"),"\\");
         }
         return param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "";
         if(this.node)
         {
            _loc1_ = _loc1_ + (this.node + "@");
         }
         _loc1_ = _loc1_ + this.domain;
         if(this.resource)
         {
            _loc1_ = _loc1_ + ("/" + this.resource);
         }
         return _loc1_;
      }
      
      public function get bareJID() : String
      {
         if(this._bareJIDCache)
         {
            return this._bareJIDCache;
         }
         var _loc1_:String = this.toString();
         var _loc2_:int = _loc1_.lastIndexOf("/");
         if(_loc2_ > 0)
         {
            _loc1_ = _loc1_.substring(0,_loc2_);
         }
         this._bareJIDCache = _loc1_;
         return _loc1_;
      }
      
      public function get resource() : String
      {
         if(this._resource.length > 0)
         {
            return this._resource;
         }
         return null;
      }
      
      public function get node() : String
      {
         if(this._node.length > 0)
         {
            return this._node;
         }
         return null;
      }
      
      public function get domain() : String
      {
         return this._domain;
      }
   }
}
