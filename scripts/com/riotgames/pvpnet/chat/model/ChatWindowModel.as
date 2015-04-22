package com.riotgames.pvpnet.chat.model
{
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   import com.riotgames.platform.gameclient.chat.domain.ChatPersonalMessageVO;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class ChatWindowModel extends Object
   {
      
      private var _buddy:Buddy;
      
      private var _messages:Vector.<ChatPersonalMessageVO>;
      
      private var _messagesChanged:Signal;
      
      private var _activated:Signal;
      
      public var hasUnreadMessages:Boolean = false;
      
      public function ChatWindowModel(param1:Buddy)
      {
         this._messages = new Vector.<ChatPersonalMessageVO>();
         this._messagesChanged = new Signal();
         this._activated = new Signal();
         super();
         this._buddy = param1;
      }
      
      public function getBuddy() : Buddy
      {
         return this._buddy;
      }
      
      public function getMessages() : Vector.<ChatPersonalMessageVO>
      {
         return this._messages;
      }
      
      public function addMessage(param1:ChatPersonalMessageVO) : void
      {
         this._messages.push(param1);
         this.hasUnreadMessages = true;
         this._messagesChanged.dispatch(this);
      }
      
      public function getChatMessagesChanged() : ISignal
      {
         return this._messagesChanged;
      }
      
      public function getActivated() : ISignal
      {
         return this._activated;
      }
      
      public function activate() : void
      {
         this._activated.dispatch(this);
      }
   }
}
