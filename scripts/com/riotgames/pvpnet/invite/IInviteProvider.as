package com.riotgames.pvpnet.invite
{
   import com.riotgames.platform.provider.IProvider;
   import com.riotgames.pvpnet.invite.model.InviteGroup;
   import blix.action.IAction;
   import com.riotgames.pvpnet.invite.views.IInviteView;
   import blix.context.IContext;
   import com.riotgames.pvpnet.queuerestriction.controller.IQueueRestrictionController;
   
   public interface IInviteProvider extends IProvider
   {
      
      function getInviteGroup() : InviteGroup;
      
      function getOpenInvitePanelAction() : IAction;
      
      function getInviteListView(param1:IContext) : IInviteView;
      
      function getRankedInviteController() : IInviteRankedTeamController;
      
      function getInviteController() : IInviteController;
      
      function getQueueRestrictionController() : IQueueRestrictionController;
   }
}
