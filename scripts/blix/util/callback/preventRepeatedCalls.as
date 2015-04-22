package blix.util.callback
{
   public function preventRepeatedCalls(param1:Function, param2:Array = null, param3:int = 0) : Boolean
   {
      if(!(param1 in funcCooldownDict))
      {
         funcCooldownDict[param1] = true;
         setTimeout(timeoutHandler,param3,param1);
         return false;
      }
      return true;
   }
}

const funcCooldownDict:Dictionary;

const timeoutHandler:Function;
