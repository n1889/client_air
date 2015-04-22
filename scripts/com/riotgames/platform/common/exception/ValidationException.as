package com.riotgames.platform.common.exception
{
   import mx.collections.ArrayCollection;
   
   public class ValidationException extends PlatformException
   {
      
      public var invalidFields:ArrayCollection;
      
      public function ValidationException()
      {
         super();
      }
   }
}
