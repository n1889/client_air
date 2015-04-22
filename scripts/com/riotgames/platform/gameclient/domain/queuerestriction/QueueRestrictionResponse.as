package com.riotgames.platform.gameclient.domain.queuerestriction
{
   public class QueueRestrictionResponse extends Object
   {
      
      private var _eligiblityMap:Object;
      
      public function QueueRestrictionResponse()
      {
         super();
      }
      
      public function set eligibilityMapJSON(param1:String) : void
      {
         this._eligiblityMap = JSON.parse(param1);
         if(!this._eligiblityMap)
         {
            this._eligiblityMap = new Object();
         }
      }
      
      public function get eligibilityMap() : Object
      {
         return this._eligiblityMap;
      }
   }
}
