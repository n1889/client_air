package com.riotgames.platform.gameclient.kudos
{
   public class KudosTotals extends Object
   {
      
      public var totals:Array;
      
      public function KudosTotals()
      {
         super();
      }
      
      public function getTotal(param1:Number) : String
      {
         if((this.totals) && (param1 >= 0) && (param1 < this.totals.length))
         {
            return this.totals[param1];
         }
         return "-";
      }
   }
}
