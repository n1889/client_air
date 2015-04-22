package com.riotgames.platform.common.utils
{
   import com.riotgames.platform.common.services.IRemoteExceptionFactory;
   import com.riotgames.platform.common.exception.UnexpectedServiceException;
   
   public class DefaultRemoteExceptionFactory extends Object implements IRemoteExceptionFactory
   {
      
      public var interruptAll:Boolean = true;
      
      public function DefaultRemoteExceptionFactory()
      {
         super();
      }
      
      public function shouldInterruptServiceCall(param1:String, param2:String, param3:Array) : Boolean
      {
         return this.interruptAll;
      }
      
      public function generateSimulatedRemoteServiceError(param1:String, param2:String, param3:Array) : Object
      {
         var _loc4_:UnexpectedServiceException = new UnexpectedServiceException();
         _loc4_.message = "DefaultRemoteExceptionFactory fake server error for " + param1 + "." + param2;
         return _loc4_;
      }
   }
}
