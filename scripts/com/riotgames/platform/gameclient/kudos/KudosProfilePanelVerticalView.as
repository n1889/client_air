package com.riotgames.platform.gameclient.kudos
{
   import mx.rpc.events.ResultEvent;
   import com.riotgames.util.json.jsonDecode;
   import blix.context.IContext;
   
   public class KudosProfilePanelVerticalView extends KudosProfilePanelView
   {
      
      private var _currentSummonerId:Number;
      
      private var _service:KudosServicePlatform;
      
      private var _cache:IKudosProfileTotalsCache;
      
      public function KudosProfilePanelVerticalView(param1:IContext, param2:KudosServicePlatform, param3:IKudosProfileTotalsCache)
      {
         super(param1);
         this._service = param2;
         this._cache = param3;
         setLinkage("KudosProfilePanelVertical");
      }
      
      public function onKudosTotals(param1:ResultEvent) : void
      {
         var responseData:Object = null;
         var resultEvent:ResultEvent = param1;
         var response:LcdsResponseString = resultEvent.result as LcdsResponseString;
         var kudosTotals:KudosTotals = new KudosTotals();
         if((response) && (response.value))
         {
            try
            {
               responseData = jsonDecode(response.value);
               kudosTotals.totals = responseData.totals;
            }
            catch(e:Error)
            {
               trace("error retrieving kudos totals: " + e.message);
            }
         }
         this._cache.cacheKudosTotals(this._currentSummonerId,kudosTotals);
         this.setKudosTotals(kudosTotals);
      }
      
      public function setKudosTotals(param1:KudosTotals) : void
      {
         if(param1)
         {
            setVisible(true);
            setFriendlyText(param1.getTotal(KudosType.Friendly));
            setHelpfulText(param1.getTotal(KudosType.Helpful));
            setTeamworkText(param1.getTotal(KudosType.Teamwork));
            setHonorableText(param1.getTotal(KudosType.Honorable));
         }
         else
         {
            setVisible(false);
         }
      }
      
      public function retrieveKudosTotalsForSummoner(param1:Number) : void
      {
         if(isNaN(param1))
         {
            return;
         }
         this._currentSummonerId = param1;
         if(this._cache.getKudosTotals(param1))
         {
            this.setKudosTotals(this._cache.getKudosTotals(param1) as KudosTotals);
         }
         else
         {
            this._service.getTotals(param1,this.onKudosTotals);
         }
      }
   }
}
