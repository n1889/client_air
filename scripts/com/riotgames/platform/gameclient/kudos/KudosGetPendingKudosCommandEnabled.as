package com.riotgames.platform.gameclient.kudos
{
   import com.riotgames.platform.common.commands.CommandBase;
   import com.riotgames.platform.gameclient.domain.kudos.PendingKudos;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.util.json.jsonDecode;
   import mx.collections.ArrayCollection;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   
   public class KudosGetPendingKudosCommandEnabled extends CommandBase
   {
      
      private var kudosService:IKudosService;
      
      private var clientConfig:ClientConfig;
      
      public function KudosGetPendingKudosCommandEnabled(param1:IKudosService)
      {
         this.clientConfig = ClientConfig.instance;
         super();
         this.kudosService = param1;
      }
      
      override public function execute() : void
      {
         super.execute();
         if(!this.kudosService)
         {
            throw new Error("Unable to execute command - no KudosService specified.");
         }
         else
         {
            this.kudosService.getPendingKudos(this.onResult);
            return;
         }
      }
      
      override protected function onResult(param1:Object = null) : void
      {
         var pendingKudos:PendingKudos = null;
         var response:LcdsResponseString = null;
         var responseData:Object = null;
         var result:Object = param1;
         var resultEvent:ResultEvent = result as ResultEvent;
         try
         {
            response = resultEvent.result as LcdsResponseString;
            if((response) && (response.value))
            {
               responseData = jsonDecode(response.value);
               pendingKudos = new PendingKudos();
               pendingKudos.pendingCounts = new ArrayCollection(responseData["pendingCounts"]);
            }
         }
         catch(e:Error)
         {
            logger.warn("Problem encountered while parsing pendingKudos: " + e.message);
         }
         super.onResult(pendingKudos);
      }
   }
}
