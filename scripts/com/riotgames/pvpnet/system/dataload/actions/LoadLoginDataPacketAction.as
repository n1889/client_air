package com.riotgames.pvpnet.system.dataload.actions
{
   import blix.action.BasicAction;
   import com.riotgames.pvpnet.system.dataload.InitialClientData;
   import com.riotgames.platform.common.services.ServiceProxy;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.domain.LoginDataPacket;
   
   public class LoadLoginDataPacketAction extends BasicAction
   {
      
      private var _initialClientData:InitialClientData;
      
      public function LoadLoginDataPacketAction(param1:InitialClientData)
      {
         super(false);
         this._initialClientData = param1;
      }
      
      override protected function doInvocation() : void
      {
         ServiceProxy.instance.clientFacadeService.getLoginDataPacketForUser(this.onLoginDataPacket,null);
      }
      
      private function onLoginDataPacket(param1:ResultEvent) : void
      {
         this._initialClientData.loginDataPacket = param1.result as LoginDataPacket;
         complete();
      }
   }
}
