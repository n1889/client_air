package com.riotgames.platform.common.validators
{
   import flash.display.DisplayObject;
   
   public class ValidationObject extends Object
   {
      
      public var required:Boolean;
      
      public var objectToMatch:DisplayObject;
      
      public var property:String;
      
      public var expression:String;
      
      public var type:String;
      
      public var source:DisplayObject;
      
      public var propertyToMatch:String;
      
      public var errorMessage:String;
      
      public function ValidationObject()
      {
         super();
      }
   }
}
