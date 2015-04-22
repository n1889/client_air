package com.riotgames.util.logging
{
   public function getLogger(param1:Object) : ILogger
   {
      return Log.getLogger(getQualifiedClassName(param1).replace(new RegExp("::"),"."));
   }
}
