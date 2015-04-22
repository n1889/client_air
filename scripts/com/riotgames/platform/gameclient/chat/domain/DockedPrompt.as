package com.riotgames.platform.gameclient.chat.domain
{
   import flash.events.EventDispatcher;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import flash.events.Event;
   
   public class DockedPrompt extends EventDispatcher
   {
      
      public static const TYPE_GAME_INVITE:String = "gameInvite";
      
      public static const TYPE_FRIEND_INVITE:String = "friendInvite";
      
      public static const TYPE_OTHER:String = "other";
      
      public static const TYPE_ALARM:String = "alarm";
      
      public var introShown:Boolean = false;
      
      public var shown:Boolean = false;
      
      private var _leftButtonLabel:String;
      
      private var _rewardsIconChangedSignal:Signal;
      
      public var closeHandlerProperty:Object;
      
      public var type:String = "other";
      
      private var _rightButtonDisabled:Boolean = false;
      
      private var _imageUpdateSignal:Signal;
      
      private var _unreadChangedSignal:Signal;
      
      private var _leftButtonDisabled:Boolean = false;
      
      public var fromName:String;
      
      private var _title:String;
      
      private var _disabledChanged:Signal;
      
      public var isPersistent:Boolean = true;
      
      private var _disabledMessageChanged:Signal;
      
      private var _imageUrl:String;
      
      private var _closeHandlerCallback:Function;
      
      private var _rightButtonLabel:String;
      
      private var _messageChangedSignal:Signal;
      
      private var _titleChangedSignal:Signal;
      
      private var _showIntroChanged:Signal;
      
      private var _closeHandlerCallbackChangedSignal:Signal;
      
      private var _disabledMessage:String = "";
      
      private var _leftButtonLabelChangedSignal:Signal;
      
      private var _leftButtonDisabledChanged:Signal;
      
      private var _message:String;
      
      private var _unread:Boolean;
      
      private var _disabled:Boolean = false;
      
      private var _rightButtonDisabledChanged:Signal;
      
      private var _showIntro:Boolean = false;
      
      public var timeStamp:Date;
      
      private var _rightButtonLabelChangedSignal:Signal;
      
      private var _rewardsIcon:int;
      
      public function DockedPrompt()
      {
         this._leftButtonLabelChangedSignal = new Signal();
         this._rightButtonLabelChangedSignal = new Signal();
         this._rewardsIconChangedSignal = new Signal();
         this._titleChangedSignal = new Signal();
         this._messageChangedSignal = new Signal();
         this._unreadChangedSignal = new Signal();
         this._disabledMessageChanged = new Signal();
         this._disabledChanged = new Signal();
         this._leftButtonDisabledChanged = new Signal();
         this._rightButtonDisabledChanged = new Signal();
         this._showIntroChanged = new Signal();
         this._imageUpdateSignal = new Signal();
         this._closeHandlerCallbackChangedSignal = new Signal();
         super();
      }
      
      public static function create(param1:String, param2:String, param3:String, param4:String, param5:String = null, param6:String = null, param7:Function = null, param8:Object = null, param9:Boolean = true, param10:int = -1, param11:String = "", param12:String = "") : DockedPrompt
      {
         var _loc13_:DockedPrompt = new DockedPrompt();
         _loc13_.message = param1;
         _loc13_.title = param2;
         _loc13_.fromName = param3;
         _loc13_.leftButtonLabel = param4;
         _loc13_.rightButtonLabel = param5;
         _loc13_.closeHandlerCallback = param7;
         _loc13_.closeHandlerProperty = param8;
         _loc13_.rewardsIcon = param10;
         if(param6 != null)
         {
            _loc13_.type = param6;
         }
         _loc13_.timeStamp = new Date();
         _loc13_.isPersistent = param9;
         _loc13_.disabledMessage = param11;
         _loc13_.imageUrl = param12;
         return _loc13_;
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function set message(param1:String) : void
      {
         if(this._message == param1)
         {
            return;
         }
         this._message = param1;
         this._messageChangedSignal.dispatch(param1);
      }
      
      public function get rightButtonDisabled() : Boolean
      {
         return this._rightButtonDisabled;
      }
      
      public function set rightButtonDisabled(param1:Boolean) : void
      {
         if(this._rightButtonDisabled == param1)
         {
            return;
         }
         this._rightButtonDisabled = param1;
         this._rightButtonDisabledChanged.dispatch();
      }
      
      public function get imageUrl() : String
      {
         return this._imageUrl;
      }
      
      public function get rightButtonLabel() : String
      {
         return this._rightButtonLabel;
      }
      
      public function getMessageChangedSignal() : ISignal
      {
         return this._messageChangedSignal;
      }
      
      public function set closeHandlerCallback(param1:Function) : void
      {
         if(param1 == this._closeHandlerCallback)
         {
            return;
         }
         this._closeHandlerCallback = param1;
         this._closeHandlerCallbackChangedSignal.dispatch(param1);
      }
      
      public function set imageUrl(param1:String) : void
      {
         if(this._imageUrl != param1)
         {
            this._imageUrl = param1;
            this._imageUpdateSignal.dispatch();
         }
      }
      
      public function getRewardsIconChangedSignal() : ISignal
      {
         return this._rewardsIconChangedSignal;
      }
      
      public function getDisabledMessageChanged() : ISignal
      {
         return this._disabledMessageChanged;
      }
      
      public function getRightButtonLabelChangedSignal() : ISignal
      {
         return this._rightButtonLabelChangedSignal;
      }
      
      public function getRightButtonDisabledChanged() : ISignal
      {
         return this._rightButtonDisabledChanged;
      }
      
      public function set rightButtonLabel(param1:String) : void
      {
         if(this._rightButtonLabel == param1)
         {
            return;
         }
         this._rightButtonLabel = param1;
         dispatchEvent(new Event("RIGHT_BUTTON_LABEL_CHANGED"));
         this._rightButtonLabelChangedSignal.dispatch(param1);
      }
      
      public function getLeftButtonLabelChangedSignal() : ISignal
      {
         return this._leftButtonLabelChangedSignal;
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function get leftButtonLabel() : String
      {
         return this._leftButtonLabel;
      }
      
      public function set unread(param1:Boolean) : void
      {
         if(this._unread == param1)
         {
            return;
         }
         this._unread = param1;
         this._unreadChangedSignal.dispatch(param1);
      }
      
      public function getDisabledChanged() : ISignal
      {
         return this._disabledChanged;
      }
      
      public function set leftButtonDisabled(param1:Boolean) : void
      {
         if(this._leftButtonDisabled == param1)
         {
            return;
         }
         this._leftButtonDisabled = param1;
         this._leftButtonDisabledChanged.dispatch();
      }
      
      public function getCloseHandlerCallbackChangedSignal() : ISignal
      {
         return this._closeHandlerCallbackChangedSignal;
      }
      
      public function set rewardsIcon(param1:int) : void
      {
         if(this._rewardsIcon == param1)
         {
            return;
         }
         this._rewardsIcon = param1;
         dispatchEvent(new Event("REWARDS_ICON_CHANGED"));
         this._rewardsIconChangedSignal.dispatch(param1);
      }
      
      public function get disabled() : Boolean
      {
         return this._disabled;
      }
      
      public function get showIntro() : Boolean
      {
         return this._showIntro;
      }
      
      public function getLeftButtonDisabledChanged() : ISignal
      {
         return this._leftButtonDisabledChanged;
      }
      
      public function get closeHandlerCallback() : Function
      {
         return this._closeHandlerCallback;
      }
      
      public function get unread() : Boolean
      {
         return this._unread;
      }
      
      public function set title(param1:String) : void
      {
         if(this._title == param1)
         {
            return;
         }
         this._title = param1;
         this._titleChangedSignal.dispatch(param1);
      }
      
      public function get leftButtonDisabled() : Boolean
      {
         return this._leftButtonDisabled;
      }
      
      public function set leftButtonLabel(param1:String) : void
      {
         if(this._leftButtonLabel == param1)
         {
            return;
         }
         this._leftButtonLabel = param1;
         dispatchEvent(new Event("LEFT_BUTTON_LABEL_CHANGED"));
         this._leftButtonLabelChangedSignal.dispatch(param1);
      }
      
      public function getShowIntroChanged() : ISignal
      {
         return this._showIntroChanged;
      }
      
      public function get rewardsIcon() : int
      {
         return this._rewardsIcon;
      }
      
      public function get imageUpdateSignal() : ISignal
      {
         return this._imageUpdateSignal;
      }
      
      public function set disabledMessage(param1:String) : void
      {
         if(param1 == this._disabledMessage)
         {
            return;
         }
         this._disabledMessage = param1;
         this._disabledMessageChanged.dispatch();
      }
      
      public function getUnreadChangedSignal() : ISignal
      {
         return this._unreadChangedSignal;
      }
      
      public function set showIntro(param1:Boolean) : void
      {
         if(this._showIntro != param1)
         {
            this._showIntro = param1;
            this._showIntroChanged.dispatch();
         }
      }
      
      public function get disabledMessage() : String
      {
         return this._disabledMessage;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(this.disabled == param1)
         {
            return;
         }
         this._disabled = param1;
         this._disabledChanged.dispatch();
      }
      
      public function getTitleChangedSignal() : ISignal
      {
         return this._titleChangedSignal;
      }
   }
}
