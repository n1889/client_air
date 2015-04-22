package com.riotgames.platform.gameclient.controllers.game.commands.chat
{
   import com.riotgames.platform.common.commands.CommandBase;
   import mx.collections.IList;
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageVO;
   import com.riotgames.platform.gameclient.chat.controllers.ChatRoom;
   import com.riotgames.pvpnet.system.game.GameProviderProxy;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.util.string.RiotStringUtil;
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageType;
   
   public class PrintMatchDetailsCommand extends CommandBase
   {
      
      private var messageType:String;
      
      private var currentMatchDetailsMessages:IList;
      
      private var chatRoom:ChatRoom;
      
      public function PrintMatchDetailsCommand(param1:ChatRoom, param2:String, param3:IList)
      {
         super();
         this.chatRoom = param1;
         this.messageType = param2;
         this.currentMatchDetailsMessages = param3;
      }
      
      private function printChatMessage(param1:ChatMessageVO) : void
      {
         this.chatRoom.addMessageToBuffer(param1);
      }
      
      override public function execute() : void
      {
         super.execute();
         this.printMatchDetailsMessage();
         onComplete();
         onResult();
      }
      
      private function createChatMessage(param1:String, param2:String) : void
      {
         var _loc4_:ChatMessageVO = null;
         var _loc3_:ChatMessageVO = new ChatMessageVO();
         _loc3_.type = param1;
         _loc3_.rosterItem = null;
         _loc3_.timeStamp = new Date();
         _loc3_.body = param2;
         if(this.chatRoom != null)
         {
            if(this.currentMatchDetailsMessages.length > 0)
            {
               _loc4_ = ChatMessageVO(this.currentMatchDetailsMessages.getItemAt(0));
               this.currentMatchDetailsMessages.removeAll();
               this.printChatMessage(_loc4_);
            }
            this.printChatMessage(_loc3_);
         }
         else
         {
            this.currentMatchDetailsMessages.addItem(_loc3_);
         }
      }
      
      private function printMatchDetailsMessage() : void
      {
         var _loc1_:GameFlowVariant = GameProviderProxy.instance.getCurrentGameFlowVariant();
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:String = _loc1_.getMatchDetailsMessage(this.messageType);
         if(!RiotStringUtil.isEmpty(_loc2_))
         {
            this.createChatMessage(ChatMessageType.USER_ALERT,_loc2_);
         }
      }
   }
}
