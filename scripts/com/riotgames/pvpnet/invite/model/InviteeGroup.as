package com.riotgames.pvpnet.invite.model
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   
   public class InviteeGroup extends Object
   {
      
      private var _listItemsChanged:Signal;
      
      private var _listItems:Vector.<Invitee>;
      
      private var _name:String;
      
      public function InviteeGroup(param1:String)
      {
         this._listItemsChanged = new Signal();
         super();
         this._name = param1;
      }
      
      public function setListItems(param1:Vector.<Invitee>) : void
      {
         var _loc2_:Vector.<Invitee> = null;
         if(param1 != this._listItems)
         {
            _loc2_ = this._listItems;
            this._listItems = param1;
            this._listItemsChanged.dispatch(_loc2_,param1);
         }
      }
      
      public function getName() : String
      {
         return this._name;
      }
      
      public function getListItems() : Vector.<Invitee>
      {
         return this._listItems;
      }
      
      public function getListItemsChanged() : ISignal
      {
         return this._listItemsChanged;
      }
   }
}
