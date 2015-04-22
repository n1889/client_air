package com.riotgames.pvpnet.tracking
{
   import com.riotgames.platform.common.provider.MetricsProxy;
   
   public class Dradis extends Object
   {
      
      public function Dradis()
      {
         super();
      }
      
      public static function track(param1:String, param2:Object = null, param3:Number = 1.0) : void
      {
         MetricsProxy.instance.track(param1,param2,false,param3);
      }
   }
}
