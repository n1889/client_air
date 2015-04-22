package com.riotgames.platform.gameclient.chat
{
   import flash.events.EventDispatcher;
   import com.riotgames.platform.gameclient.domain.Summoner;
   import com.riotgames.pvpnet.system.config.ClientConfig;
   import org.igniterealtime.xiff.core.UnescapedJID;
   import org.igniterealtime.xiff.core.EscapedJID;
   import com.riotgames.platform.gameclient.chat.controllers.ChatRoom;
   import com.riotgames.platform.gameclient.chat.domain.ChatRoomType;
   import com.riotgames.pvpnet.system.game.IGameProvider;
   import com.riotgames.pvpnet.system.config.UserPreferencesManager;
   import org.igniterealtime.xiff.data.im.RosterItemVO;
   import org.igniterealtime.xiff.data.im.RosterGroup;
   import com.riotgames.platform.gameclient.chat.domain.Buddy;
   import org.igniterealtime.xiff.events.XIFFErrorEvent;
   import org.igniterealtime.xiff.events.OutgoingDataEvent;
   import org.igniterealtime.xiff.events.IncomingDataEvent;
   import org.igniterealtime.xiff.events.LoginEvent;
   import org.igniterealtime.xiff.events.MessageEvent;
   import org.igniterealtime.xiff.events.RosterEvent;
   import org.igniterealtime.xiff.events.InviteEvent;
   import flash.utils.getQualifiedClassName;
   import blix.signals.ISignal;
   import org.igniterealtime.xiff.data.Presence;
   import flash.events.Event;
   import mx.utils.StringUtil;
   import blix.signals.Signal;
   import mx.resources.ResourceManager;
   import mx.resources.IResourceManager;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import com.riotgames.platform.gameclient.chat.domain.BuddySubscriptionRequestData;
   import com.riotgames.platform.gameclient.chat.controllers.BuddyListPresentationModel;
   import com.riotgames.platform.gameclient.domain.ButtonNameType;
   import com.riotgames.platform.gameclient.chat.domain.RecofrienderContactDetailsDto;
   import com.riotgames.platform.gameclient.chat.controllers.FriendRecommendationService;
   import mx.rpc.events.ResultEvent;
   import com.riotgames.platform.gameclient.domain.SummonerSummary;
   import com.riotgames.platform.gameclient.chat.controllers.PrivacyListController;
   import com.riotgames.platform.gameclient.chat.trackers.GroupChatBehaviorTracker;
   import mx.events.PropertyChangeEvent;
   import flash.events.TimerEvent;
   import com.riotgames.platform.common.services.ServiceProxy;
   import com.riotgames.pvpnet.tracking.trackers.friend.IFriendListBehaviorTracker;
   import com.riotgames.pvpnet.tracking.trackers.chat.IChatBehaviorTracker;
   import mx.events.CollectionEvent;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.chat.domain.BuddyGroup;
   import mx.events.CollectionEventKind;
   import flash.utils.setTimeout;
   import com.riotgames.platform.common.xmpp.data.invite.PresenceStatusXML;
   import flash.utils.Timer;
   import com.riotgames.platform.gameclient.chat.domain.AutojoinChatDesc;
   import com.riotgames.pvpnet.system.messaging.ShellDispatcher;
   import org.igniterealtime.xiff.im.Roster;
   import org.igniterealtime.xiff.data.im.RosterExtension;
   import org.igniterealtime.xiff.data.Message;
   import com.riotgames.platform.common.RiotServiceConfig;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.domain.partner.AntiIndulgenceMessage;
   import com.riotgames.platform.common.AppConfig;
   import com.riotgames.platform.gameclient.chat.controllers.GameChatController;
   import org.igniterealtime.xiff.conference.RoomOccupant;
   import com.riotgames.platform.gameclient.chat.controllers.INameController;
   import com.riotgames.util.json.jsonEncode;
   import blix.util.string.strTrim;
   import com.riotgames.platform.gameclient.chat.domain.DockedPrompt;
   import com.riotgames.platform.common.xmpp.logging.XMPPSessionLogger;
   import flash.utils.ByteArray;
   import com.hurlant.crypto.hash.SHA1;
   import com.hurlant.crypto.hash.IHash;
   import com.riotgames.platform.common.event.RosterProviderEvent;
   import com.riotgames.platform.common.audio.AudioKeys;
   import com.riotgames.pvpnet.system.maestro.IMaestroProvider;
   import com.riotgames.platform.provider.ProviderLookup;
   import flash.utils.Dictionary;
   import com.riotgames.platform.common.session.Session;
   import com.riotgames.platform.common.services.ChatServiceState;
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   import com.riotgames.platform.gameclient.chat.config.ChatConfig;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import org.igniterealtime.xiff.conference.Room;
   import mx.binding.utils.ChangeWatcher;
   import com.riotgames.platform.gameclient.chat.controllers.PresenceController;
   import mx.collections.ListCollectionView;
   import com.riotgames.pvpnet.system.wordfilter.WordFilter;
   import com.riotgames.pvpnet.tracking.ICrossModuleTrackerProvider;
   import org.igniterealtime.xiff.events.DisconnectionEvent;
   import com.riotgames.util.json.jsonDecode;
   import org.igniterealtime.xiff.data.muc.MUC;
   import mx.rpc.AsyncToken;
   import com.riotgames.platform.common.provider.ISoundProvider;
   import com.riotgames.platform.gameclient.chat.event.XMPPEvent;
   import com.riotgames.platform.common.domain.XMPPMessageSubjectTypes;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import mx.logging.Log;
   import com.riotgames.pvpnet.system.maestro.MaestroProviderProxy;
   import com.riotgames.platform.common.provider.SoundProviderProxy;
   
   public class ChatController extends EventDispatcher implements IChatProvider, IChatRosterProvider, IChatRoomProvider, IChatStateProvider, IChatBlockedRosterProvider
   {
      
      public static const OFFLINE:String = "offline";
      
      public static const LOGGING_IN:String = "loggingIn";
      
      public static const MAXIMUM_BUDDY_LIST_SIZE:int = 300;
      
      public static const LOGGING_OUT:String = "loggingOut";
      
      public static const MAXIMUM_OPEN_GROUP_CHAT_WINDOWS:int = 10;
      
      public static const ONLINE:String = "online";
      
      public static const BUDDY_INVITE_TYPE:String = "buddy_invite";
      
      public static const TEMP_FAILURE:String = "tempFailure";
      
      private var _1136849067chatRoomsStartFocused:Boolean = true;
      
      protected var chatWindowDisplayed:Boolean = false;
      
      private var _chatDisplayNameChangedSignal:Signal;
      
      private var queuedEvents:Array;
      
      private var _numPublicChatrooms:uint = 0;
      
      private var _subscriptionRequestSignal:Signal;
      
      private var _rosterPresenceUpdatedSignal:Signal;
      
      public var privacyListController:PrivacyListController;
      
      private var _quietMode:Boolean = false;
      
      private var _buddyRemovedSignal:Signal;
      
      private var _chatSpammerErrorSignal:Signal;
      
      public var serviceProxy:ServiceProxy;
      
      private var _friendTracker:IFriendListBehaviorTracker;
      
      private var _currentUserJIDChangedSignal:Signal;
      
      private var _userAvailableSignal:Signal;
      
      private var activeFriendsTimer:Timer;
      
      private var _1203124485buddyListModel:BuddyListPresentationModel;
      
      private var _chatRestoreChatViewsSignal:Signal;
      
      private var _chatRoomsTimeStamp:Boolean = false;
      
      public var shellDispatcher:ShellDispatcher;
      
      private var _currentChatState:String;
      
      private var isInGameOnLogin:Boolean;
      
      private var _initialized:Boolean = false;
      
      private var servicesConfig:RiotServiceConfig;
      
      private var _chatLoggingOutSignal:Signal;
      
      private var _buddyGroupsInitialized:Boolean = false;
      
      private var _chatCloseMatchmakingQueueChatRoomSignal:Signal;
      
      private var _chatPresenceLayering:ChatPresenceLayering;
      
      private var _925192565roster:Roster;
      
      private var pendingChatInvite:Array;
      
      private var logger:ILogger;
      
      private var _currentUserJID:UnescapedJID;
      
      private var gameChatController:GameChatController;
      
      private var _chatInviteToGroupChatSignal:Signal;
      
      public var realNameController:INameController;
      
      private var _1925355037errorDataProvider:ArrayCollection;
      
      private var _gameProvider:IGameProvider;
      
      private var _chatSystemInitializedSignal:Signal;
      
      private var _currentUserDisplayName:String;
      
      public var xmppSessionLogger:XMPPSessionLogger;
      
      private var _chatRemoveAllChatDisplaysSignal:Signal;
      
      public var maestroController:IMaestroProvider;
      
      private var _pendingFriendRequestTimer:Timer;
      
      private var _buddySubscriptionDict:Dictionary;
      
      private var _chatMessageReceivedFromBuddy:Signal;
      
      private var _chatNormalMessageReceivedSignal:Signal;
      
      private var _buddyGroups:ArrayCollection;
      
      public var session:Session;
      
      private var _453738366currentUserChatRoomName:String;
      
      private var _buddyRequestDict:Dictionary;
      
      private var autoJoinChatList:Array;
      
      private var presenceHandlerTimer:Timer;
      
      private var _chatStateChanged:Signal;
      
      private var _privacyListInitializedSignal:Signal;
      
      private var _currentUserIconID:int;
      
      private var buddyListModelChangeWatcher:ChangeWatcher;
      
      public var clientConfig:ClientConfig;
      
      public var presenceController:PresenceController;
      
      private var _chatTracker:IChatBehaviorTracker;
      
      private var _chatDisplayInviteRecievedSignal:Signal;
      
      private var _chatRoomsMaximized:Boolean = false;
      
      private var _receivingPendingFriendRequests:Boolean = true;
      
      public var wordFilter:WordFilter;
      
      private var _chatRankedTeamUpdatedSignal:Signal;
      
      private var allOpenChatRooms:ArrayCollection;
      
      private var _792412946buddyListOpen:Boolean = false;
      
      private var _chatCloseChatRoomSignal:Signal;
      
      private var _chatCloseAllChatRoomsSignal:Signal;
      
      private var _1808108049inviteBayItems:ArrayCollection;
      
      private var _privacyListReady:Boolean = false;
      
      private var inQueueChatRoom:ChatRoom;
      
      private var _chatOpenChatRoomViewSignal:Signal;
      
      private var _loggingIn:Boolean = false;
      
      private var _buddyAddedSignal:Signal;
      
      private var _2020648519loggedIn:Boolean = false;
      
      private var _chatMinimizeChatViewsSignal:Signal;
      
      private var _loggingInChanged:Signal;
      
      public var soundManager:ISoundProvider;
      
      private var resourceManager:IResourceManager;
      
      private var _personalImTimeStamps:Boolean = true;
      
      private var _inGame:Boolean = false;
      
      private var _chatMessageReceivedSignal:Signal;
      
      public function ChatController(param1:ServiceProxy = null, param2:ISoundProvider = null, param3:IMaestroProvider = null)
      {
         this._chatNormalMessageReceivedSignal = new Signal();
         this._chatRankedTeamUpdatedSignal = new Signal();
         this._chatDisplayNameChangedSignal = new Signal();
         this._chatDisplayInviteRecievedSignal = new Signal();
         this._chatOpenChatRoomViewSignal = new Signal();
         this._chatInviteToGroupChatSignal = new Signal();
         this._chatCloseChatRoomSignal = new Signal();
         this._chatCloseAllChatRoomsSignal = new Signal();
         this._chatCloseMatchmakingQueueChatRoomSignal = new Signal();
         this._chatRemoveAllChatDisplaysSignal = new Signal();
         this._loggingInChanged = new Signal();
         this._chatLoggingOutSignal = new Signal();
         this._chatRestoreChatViewsSignal = new Signal();
         this._chatMinimizeChatViewsSignal = new Signal();
         this._chatSystemInitializedSignal = new Signal();
         this._chatSpammerErrorSignal = new Signal();
         this._chatMessageReceivedSignal = new Signal();
         this._chatMessageReceivedFromBuddy = new Signal();
         this._chatStateChanged = new Signal();
         this._privacyListInitializedSignal = new Signal();
         this._userAvailableSignal = new Signal();
         this._rosterPresenceUpdatedSignal = new Signal();
         this._buddyAddedSignal = new Signal();
         this._buddyRemovedSignal = new Signal();
         this._subscriptionRequestSignal = new Signal();
         this.clientConfig = ClientConfig.instance;
         this.wordFilter = WordFilter.instance;
         this.session = Session.instance;
         this.shellDispatcher = ShellDispatcher.instance;
         this.presenceHandlerTimer = new Timer(15000,1);
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         this.queuedEvents = [];
         this._buddyRequestDict = new Dictionary();
         this._buddySubscriptionDict = new Dictionary();
         this._1925355037errorDataProvider = new ArrayCollection();
         this._currentUserJIDChangedSignal = new Signal();
         this.allOpenChatRooms = new ArrayCollection();
         this._1203124485buddyListModel = new BuddyListPresentationModel();
         this._buddyGroups = new ArrayCollection();
         this.pendingChatInvite = [];
         this.autoJoinChatList = [];
         this.servicesConfig = RiotServiceConfig.instance;
         super();
         if(param1 != null)
         {
            this.serviceProxy = param1;
         }
         else
         {
            this.serviceProxy = ServiceProxy.instance;
         }
         if(param3 != null)
         {
            this.maestroController = param3;
         }
         else
         {
            this.maestroController = MaestroProviderProxy.instance;
         }
         if(param2 != null)
         {
            this.soundManager = param2;
         }
         else
         {
            this.soundManager = SoundProviderProxy.instance;
         }
      }
      
      public static function jidFromSummonerId(param1:Number) : String
      {
         return Summoner.SUMMONER_INTERNAL_NAME_PREFIX + param1.toString() + "@" + ClientConfig.JABBER_DOMAIN;
      }
      
      public static function unescapedJIDFromSummonerId(param1:Number) : UnescapedJID
      {
         var _loc2_:EscapedJID = new EscapedJID(jidFromSummonerId(param1));
         return _loc2_.unescaped;
      }
      
      public function requestChatRoom(param1:String, param2:String, param3:String, param4:String, param5:Function) : void
      {
         var _loc6_:ChatRoom = null;
         var _loc7_:* = false;
         if(param1.length > 0)
         {
            _loc6_ = null;
            if(param1.indexOf("@") > -1)
            {
               _loc7_ = param4 == ChatRoomType.PUBLIC;
               _loc6_ = this.createChatRoom(ChatRoom.createRoomJID(param1,null,param3,_loc7_,false,this.servicesConfig),param2,param3,param4);
            }
            else
            {
               _loc6_ = this.requestChatProperRoom(param1,null,param2,param3,param4);
            }
            if(_loc6_ != null)
            {
               _loc6_.setEnableAutoJoinOption(ChatRoomType.isEnabledAutoJoinOption(param4));
            }
            param5(_loc6_);
         }
         else
         {
            this.logger.error("requestChatRoom: roomName is empty or undefined");
            param5(null);
         }
      }
      
      public function get gameProvider() : IGameProvider
      {
         return this._gameProvider;
      }
      
      private function set _296927628canAddBuddyToBuddyList(param1:Boolean) : void
      {
      }
      
      private function set _473812193personalImTimeStamps(param1:Boolean) : void
      {
         this._personalImTimeStamps = param1;
         UserPreferencesManager.userPrefs.personalImTimeStamps = this._personalImTimeStamps;
      }
      
      private function queueEvent(param1:Object) : void
      {
         this.queuedEvents.push(param1);
      }
      
      public function findBuddyRosterItemByName(param1:String) : RosterItemVO
      {
         var _loc3_:RosterGroup = null;
         var _loc4_:RosterItemVO = null;
         var _loc2_:String = param1.toLowerCase();
         if(this.roster)
         {
            for each(_loc3_ in this.roster.groups)
            {
               for each(_loc4_ in _loc3_)
               {
                  if(_loc4_.displayName.toLowerCase() == _loc2_)
                  {
                     return _loc4_;
                  }
               }
            }
         }
         return null;
      }
      
      public function getOnlineBuddyCount() : int
      {
         var _loc2_:RosterGroup = null;
         var _loc3_:RosterItemVO = null;
         var _loc4_:Buddy = null;
         var _loc1_:int = 0;
         if(this.roster != null)
         {
            for each(_loc2_ in this.roster.groups)
            {
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = RosterUtility.getBuddy(_loc3_);
                  if((_loc4_.getIsOnline()) && (_loc4_.getIsMutualFriend()))
                  {
                     _loc1_++;
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function closeChatRoomIndexes(param1:Array) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:ChatRoom = null;
         var _loc6_:* = 0;
         if((!(param1 == null)) && (param1.length > 0))
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length)
            {
               _loc4_ = param1[_loc2_] as int;
               _loc5_ = this.allOpenChatRooms.getItemAt(_loc4_) as ChatRoom;
               _loc5_.leave();
               if(this.isChatRoomPublic(_loc5_))
               {
                  this._numPublicChatrooms--;
               }
               this._chatCloseChatRoomSignal.dispatch(_loc5_);
               _loc2_++;
            }
            _loc3_ = param1.length - 1;
            while(_loc3_ >= 0)
            {
               _loc6_ = param1[_loc3_] as int;
               this.allOpenChatRooms.removeItemAt(_loc6_);
               _loc3_--;
            }
            if(this.chatTracker != null)
            {
               this._chatTracker.setChatWindowsOpenedAtOnce(this.allOpenChatRooms.length);
            }
         }
      }
      
      private function cleanupXMPPConnection() : void
      {
         this.serviceProxy.chatService.removeConnectionEventListener(XIFFErrorEvent.XIFF_ERROR,this.onError);
         this.serviceProxy.chatService.removeConnectionEventListener(OutgoingDataEvent.OUTGOING_DATA,this.onOutgoingData);
         this.serviceProxy.chatService.removeConnectionEventListener(IncomingDataEvent.INCOMING_DATA,this.onIncomingData);
         this.serviceProxy.chatService.removeConnectionEventListener(LoginEvent.LOGIN,this.onLogin);
         this.serviceProxy.chatService.removeConnectionEventListener(MessageEvent.MESSAGE,this.messageHandler);
      }
      
      public function dequeueNextEvent() : void
      {
         if(this.queuedEvents.length == 0)
         {
            return;
         }
         var _loc1_:Object = this.queuedEvents.pop();
         if(_loc1_.handlerFunction == this.rosterHandler)
         {
            this.rosterHandler(_loc1_.event as RosterEvent);
         }
         else if(_loc1_.handlerFunction == this.messageHandler)
         {
            this.messageHandler(_loc1_.event as MessageEvent);
         }
         else if(_loc1_.handlerFunction == this.handleInvite)
         {
            this.handleInvite(_loc1_.event as InviteEvent);
         }
         else
         {
            this.logger.error("ChatController.dequeueNextEvent: An event was queued and a handler function was not coded for event type " + getQualifiedClassName(_loc1_.event));
            this.dequeueNextEvent();
         }
         
         
      }
      
      public function getChatRemoveAllChatDisplaysSignal() : ISignal
      {
         return this._chatRemoveAllChatDisplaysSignal;
      }
      
      public function sendSummonerNameMessage(param1:String, param2:String) : void
      {
         var _loc3_:RosterItemVO = this.findBuddyRosterItemByName(param1);
         if((_loc3_) && (_loc3_.jid))
         {
            this.sendBuddyMessage(_loc3_.jid.escaped.toString(),param2);
         }
      }
      
      public function enterMatchmakingQueueChatRoom(param1:String, param2:String, param3:ChatRoom = null) : void
      {
         var chatRoomName:String = param1;
         var chatRoomType:String = param2;
         var chatRoom:ChatRoom = param3;
         if(chatRoom == null)
         {
            this.requestChatRoom(chatRoomName,this.resourceManager.getString("resources","waitingForGameView_chatRoom_Subject"),null,chatRoomType,function(param1:ChatRoom):void
            {
               if(param1)
               {
                  inQueueChatRoom = param1;
                  joinMatchmakingQueueChatRoom(param1,chatRoomType);
               }
            });
         }
         else
         {
            this.inQueueChatRoom = chatRoom;
            this.joinMatchmakingQueueChatRoom(chatRoom,chatRoomType);
         }
      }
      
      private function handleChatSpammer(param1:XIFFErrorEvent) : void
      {
         var _loc2_:String = param1.errorFrom.node;
         this._chatSpammerErrorSignal.dispatch(_loc2_);
      }
      
      public function getAllRosterBuddies() : Array
      {
         var _loc2_:RosterGroup = null;
         var _loc3_:RosterItemVO = null;
         var _loc4_:Buddy = null;
         var _loc1_:Array = [];
         if(this.roster)
         {
            for each(_loc2_ in this.roster.groups)
            {
               for each(_loc3_ in _loc2_)
               {
                  _loc4_ = RosterUtility.getBuddy(_loc3_);
                  _loc1_.push(_loc4_);
               }
            }
         }
         return _loc1_;
      }
      
      private function presenceOnlineHandler(param1:RosterEvent) : void
      {
         var item:RosterItemVO = null;
         var presence:Presence = null;
         var message:String = null;
         var e:RosterEvent = param1;
         try
         {
            item = e.data as RosterItemVO;
            presence = this.roster.getPresence(item.jid);
            if((!presence.from.equals(presence.to,true)) && (!presence.isDelayed()) && (item.online) && (UserPreferencesManager.userPrefs.friendOnlinePrompts))
            {
               message = this.resourceManager.getString("resources","chat_buddyWindow_buddyOnlineMessage",["<font size=\"13\">" + item.displayName + "</font><br>"]);
               this.showPromptMessage("resources",message,"chat_buddyWindow_buddyOnlineAlertTitle",item.displayName,"common_button_close",null,null,null,null,false);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function getChatInviteToGroupChatSignal() : ISignal
      {
         return this._chatInviteToGroupChatSignal;
      }
      
      public function getUserAvailableSignal() : ISignal
      {
         return this._userAvailableSignal;
      }
      
      public function getBuddyCache() : BuddyCache
      {
         return BuddyCache.getInstance();
      }
      
      private function onChatStateChanged(param1:Event) : void
      {
         this.currentChatState = this.serviceProxy.chatService.currentState;
      }
      
      public function removeGroup(param1:String) : void
      {
         var _loc2_:RosterGroup = null;
         var param1:String = StringUtil.trim(param1);
         if(param1.length > 0)
         {
            _loc2_ = this.roster.getGroup(param1);
            if((_loc2_) && (this.isCustomRosterGroup(_loc2_)))
            {
               this.roster.groups.removeItemAt(this.roster.groups.getItemIndex(_loc2_));
               this.reprioritizeRosterGroups();
            }
         }
      }
      
      private function getChatRoomSubjectIndexes(param1:String, param2:String = "pu") : Array
      {
         var _loc4_:* = 0;
         var _loc5_:ChatRoom = null;
         var _loc3_:Array = [];
         if(param1 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < this.allOpenChatRooms.length)
            {
               _loc5_ = this.allOpenChatRooms[_loc4_];
               if((_loc5_.subject == param1) && (_loc5_.getRoomType() == param2))
               {
                  _loc3_.push(_loc4_);
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      private function warnTooManyFriends() : void
      {
         var _loc1_:IResourceManager = ResourceManager.getInstance();
         var _loc2_:AlertAction = new AlertAction(_loc1_.getString("resources","chat_buddyWindow_buddyBayLabel"),_loc1_.getString("resources","addBuddyWindow_tooManyBuddiesLabel",[ChatController.MAXIMUM_BUDDY_LIST_SIZE]));
         _loc2_.add();
      }
      
      public function moveGroupUp(param1:String) : void
      {
         var _loc2_:int = this.getGroupIndex(param1);
         if((_loc2_ == 0) || (_loc2_ == -1))
         {
            return;
         }
         var _loc3_:int = this.roster.groups[_loc2_ - 1].priority;
         this.roster.groups[_loc2_ - 1].priority = this.roster.groups[_loc2_].priority;
         this.roster.groups[_loc2_].priority = _loc3_;
         this.changeGroupsPriorities([this.roster.groups[_loc2_ - 1].label,this.roster.groups[_loc2_].label],[this.roster.groups[_loc2_ - 1].priority,this.roster.groups[_loc2_].priority]);
      }
      
      private function fixBustedRosterItem(param1:UnescapedJID) : void
      {
         this.serviceProxy.statisticsService.getSummonerSummaryByInternalName(param1.node,this.onRosterItemFixNameSuccess,null);
      }
      
      private function onIncomingData(param1:IncomingDataEvent) : void
      {
         var _loc2_:IncomingDataEvent = new IncomingDataEvent();
         _loc2_.data = param1.data;
         dispatchEvent(_loc2_);
      }
      
      private function isChatRoomPublic(param1:ChatRoom) : Boolean
      {
         return param1.getRoomType() == ChatRoomType.PUBLIC;
      }
      
      public function get chatRoomsMaximized() : Boolean
      {
         return this._chatRoomsMaximized;
      }
      
      private function onSubscriptionRequestSucccessCallBack(param1:String, param2:Object) : void
      {
         var buddySubscription:BuddySubscriptionRequestData = null;
         var buddyListModel:BuddyListPresentationModel = null;
         var addContactWithContext:Function = null;
         var clickedButtonName:String = param1;
         var callbackProperty:Object = param2;
         buddySubscription = callbackProperty as BuddySubscriptionRequestData;
         if(clickedButtonName == ButtonNameType.LEFT_BUTTON)
         {
            this.roster.grantSubscription(buddySubscription.subscriptionRequestJID,false);
            if(this.canAddBuddyToBuddyList)
            {
               buddyListModel = this.buddyListModel;
               addContactWithContext = function(param1:Error, param2:RecofrienderContactDetailsDto):void
               {
                  var _loc3_:String = "";
                  if((param1 == null) && (!(param2 == null)) && (!(param2.getName() == null)))
                  {
                     _loc3_ = param2.getName();
                  }
                  roster.addContact(buddySubscription.subscriptionRequestJID,buddySubscription.summonerSummary.name,buddyListModel.defaultGroupName,buddyListModel.defaultGroupPriority,true,_loc3_);
               };
               FriendRecommendationService.instance().getContactDetailsFromSummoner(buddySubscription.summonerSummary.getSummonerIdForInternalName(),buddySubscription.summonerSummary.name,addContactWithContext,this);
               if(this._friendTracker != null)
               {
                  this._friendTracker.incrementFriendRequestAccepted_InASession();
               }
            }
         }
         else
         {
            this.roster.denySubscription(buddySubscription.subscriptionRequestJID);
            if(this._friendTracker != null)
            {
               this._friendTracker.incrementFriendRequestDenied_InASession();
            }
         }
         delete this._buddySubscriptionDict[buddySubscription.subscriptionRequestJID.node];
         true;
         this._subscriptionRequestSignal.dispatch(buddySubscription);
         this.dequeueNextEvent();
      }
      
      public function getChatSystemInitializedSignal() : ISignal
      {
         return this._chatSystemInitializedSignal;
      }
      
      private function onRosterItemFixNameSuccess(param1:ResultEvent) : void
      {
         var _loc4_:RosterItemVO = null;
         var _loc2_:SummonerSummary = param1.result as SummonerSummary;
         var _loc3_:String = "";
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.name;
         }
         for each(_loc4_ in this.roster)
         {
            if(_loc2_.internalName == _loc4_.jid.node)
            {
               _loc4_.displayName = _loc3_;
               this.roster.updateContactName(_loc4_,_loc3_);
            }
         }
      }
      
      public function updateNicknameInRooms(param1:String) : void
      {
         var _loc2_:ChatRoom = null;
         for each(_loc2_ in this.allOpenChatRooms)
         {
            _loc2_.setNickName(param1);
         }
      }
      
      private function joinMatchmakingQueueChatRoom(param1:ChatRoom, param2:String) : void
      {
         param1.join();
         this._chatOpenChatRoomViewSignal.dispatch(param1,param2);
      }
      
      private function internalAddBuddy(param1:UnescapedJID, param2:String, param3:String, param4:String, param5:int) : void
      {
         var buddyJID:UnescapedJID = param1;
         var internalBuddyName:String = param2;
         var buddyDisplayName:String = param3;
         var groupName:String = param4;
         var groupPriority:int = param5;
         this._buddyRequestDict[internalBuddyName] = buddyDisplayName;
         if((!groupName) || (groupName.length == 0))
         {
            groupName = this.buddyListModel.defaultGroupName;
         }
         var addContactWithContext:Function = function(param1:Error, param2:RecofrienderContactDetailsDto):void
         {
            var _loc3_:String = "";
            if((param1 == null) && (!(param2 == null)) && (!(param2.getName() == null)))
            {
               _loc3_ = param2.getName();
            }
            roster.addContact(buddyJID,buddyDisplayName,groupName,groupPriority,true,_loc3_);
         };
         var summonerId:Number = SummonerSummary.getSummonerIdForInternalName(internalBuddyName);
         FriendRecommendationService.instance().getContactDetailsFromSummoner(summonerId,buddyDisplayName,addContactWithContext,this);
         var message:String = this.resourceManager.getString("resources","chat_buddyWindow_addBuddyAlertMessage");
         this.showPromptMessage("resources",message,"chat_buddyWindow_addBuddyLabel","PVP.NET","common_button_close");
         if(this._friendTracker != null)
         {
            this._friendTracker.incrementFriendRequestSent_InASession();
         }
      }
      
      public function getAllRosterItems() : Array
      {
         var _loc2_:RosterGroup = null;
         var _loc3_:RosterItemVO = null;
         var _loc1_:Array = [];
         if(this.roster)
         {
            for each(_loc2_ in this.roster.groups)
            {
               for each(_loc3_ in _loc2_)
               {
                  _loc1_.push(_loc3_);
               }
            }
         }
         return _loc1_;
      }
      
      private function set _1928130839currentUserDisplayName(param1:String) : void
      {
         this._currentUserDisplayName = param1;
         this.currentUserChatRoomName = this.resourceManager.getString("resources","chat_buddyWindow_userChatRoomName",[param1]);
         this._chatDisplayNameChangedSignal.dispatch(param1);
         GroupChatBehaviorTracker.instance.setPrivateChatName(this.currentUserChatRoomName.toLowerCase());
      }
      
      public function getChatSpammerErrorSignal() : ISignal
      {
         return this._chatSpammerErrorSignal;
      }
      
      public function set loggedIn(param1:Boolean) : void
      {
         var _loc2_:Object = this._2020648519loggedIn;
         if(_loc2_ !== param1)
         {
            this._2020648519loggedIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loggedIn",_loc2_,param1));
         }
      }
      
      public function getBuddyAddedSignal() : ISignal
      {
         return this._buddyAddedSignal;
      }
      
      private function set _1737028735currentUserJID(param1:UnescapedJID) : void
      {
         this._currentUserJID = param1;
         this._currentUserJIDChangedSignal.dispatch();
      }
      
      public function disconnect() : void
      {
         if(this.loggedIn)
         {
            this.serviceProxy.chatService.disconnect(true,false);
         }
      }
      
      private function checkPrivacyListAndAddBuddy(param1:String, param2:String, param3:String, param4:int) : Boolean
      {
         var _loc6_:Object = null;
         var _loc7_:AlertAction = null;
         var _loc5_:UnescapedJID = new UnescapedJID(StringUtil.trim(param1) + "@" + ClientConfig.JABBER_DOMAIN);
         if(this.isJidInRoster(_loc5_))
         {
            return false;
         }
         if(this.privacyListController.isBlocked(_loc5_.bareJID))
         {
            _loc6_ = {};
            _loc6_.buddyJID = _loc5_;
            _loc6_.internalBuddyName = param1;
            _loc6_.buddyDisplayName = param2;
            _loc6_.groupName = param3;
            _loc6_.groupPriority = param4;
            _loc7_ = new AlertAction(this.resourceManager.getString("resources","chat_buddyWindow_errorOnAddBuddyAlertTitle"),this.resourceManager.getString("resources","chat_buddyWindow_addBuddyExistsInIgnoreListMessage",[param2]));
            _loc7_.setYesNoLabels();
            _loc7_.showNegative = true;
            _loc7_.data = _loc6_;
            _loc7_.getCompleted().add(this.onPromptToAddBuddyAcknowledged);
            _loc7_.add();
            return false;
         }
         this.internalAddBuddy(_loc5_,param1,param2,param3,param4);
         return true;
      }
      
      public function getChatMessageReceivedSignal() : ISignal
      {
         return this._chatMessageReceivedSignal;
      }
      
      public function get currentUserChatRoomName() : String
      {
         return this._453738366currentUserChatRoomName;
      }
      
      private function extractConferenceName(param1:String) : String
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:int = param1.indexOf(".");
         return _loc2_ >= 0?param1.substring(0,_loc2_):param1;
      }
      
      public function set chatRoomsTimeStamp(param1:Boolean) : void
      {
         var _loc2_:Object = this.chatRoomsTimeStamp;
         if(_loc2_ !== param1)
         {
            this._1370146218chatRoomsTimeStamp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatRoomsTimeStamp",_loc2_,param1));
         }
      }
      
      private function set _1349617544chatRoomsMaximized(param1:Boolean) : void
      {
         this._chatRoomsMaximized = param1;
         UserPreferencesManager.userPrefs.chatRoomsMaximized = this._chatRoomsMaximized;
      }
      
      private function cleanupRosterListeners() : void
      {
         if(this.roster)
         {
            this.roster.connection = null;
            this.roster.removeEventListener(RosterEvent.SUBSCRIPTION_DENIAL,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.SUBSCRIPTION_REQUEST,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.SUBSCRIPTION_REVOCATION,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.USER_AVAILABLE,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.USER_UNAVAILABLE,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.ROSTER_LOADED,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.USER_REMOVED,this.rosterHandler);
            this.roster.removeEventListener(RosterEvent.USER_PRESENCE_ONLINE,this.presenceOnlineHandler);
            this.roster = null;
            this.presenceHandlerTimer.stop();
            this.presenceHandlerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPresenceHandlerTimerComplete);
            this.presenceHandlerTimer = null;
         }
      }
      
      public function emptyAndRemoveGroup(param1:String) : void
      {
         var _loc3_:RosterGroup = null;
         var _loc4_:RosterGroup = null;
         var _loc5_:RosterGroup = null;
         var _loc6_:* = 0;
         var _loc2_:String = StringUtil.trim(param1);
         if(_loc2_.length > 0)
         {
            _loc3_ = this.roster.getGroup(_loc2_);
            if((_loc3_) && (this.isCustomRosterGroup(_loc3_)))
            {
               _loc4_ = null;
               for each(_loc5_ in this.roster.groups)
               {
                  if(_loc5_.label == this.buddyListModel.defaultGroupName)
                  {
                     _loc4_ = _loc5_;
                  }
               }
               if(_loc4_ == null)
               {
                  _loc4_ = this.addGroup(this.buddyListModel.defaultGroupName,0,true);
               }
               this.moveBuddies(_loc3_.label,_loc4_.label);
               _loc6_ = this.roster.groups.getItemIndex(_loc3_);
               if(_loc6_ != -1)
               {
                  this.roster.groups.removeItemAt(_loc6_);
               }
               this.reprioritizeRosterGroups();
               if(this._friendTracker != null)
               {
                  this._friendTracker.incrementBuddyGroupDeleted_InASession();
               }
            }
         }
      }
      
      private function onOutgoingData(param1:OutgoingDataEvent) : void
      {
         var _loc2_:OutgoingDataEvent = new OutgoingDataEvent();
         _loc2_.data = param1.data;
         dispatchEvent(_loc2_);
      }
      
      public function openChatRoom(param1:String, param2:String) : String
      {
         var _loc5_:Array = null;
         if((this._numPublicChatrooms >= MAXIMUM_OPEN_GROUP_CHAT_WINDOWS) && (!(param2 == ChatRoomType.PRIVATE)))
         {
            _loc5_ = this.getChatRoomSubjectIndexes(param1,param2);
            if(_loc5_.length == 0)
            {
               this.warnTooManyGroupChatWindows();
               return null;
            }
         }
         if(!param2)
         {
            var param2:String = ChatRoomType.PUBLIC;
         }
         var _loc3_:String = this.obfuscateChatRoom(param1,param2);
         var _loc4_:String = null;
         return this.openObfuscatedChatRoom(_loc3_,null,_loc4_,param1,param2);
      }
      
      public function get chatTracker() : IChatBehaviorTracker
      {
         return this._chatTracker;
      }
      
      private function updateBuddyGroupsStructure(param1:CollectionEvent) : void
      {
         var _loc2_:RosterGroup = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:BuddyGroup = null;
         this.initializeBuddyGroups();
         switch(param1.kind)
         {
            case CollectionEventKind.ADD:
               _loc3_ = new ArrayCollection();
               for each(_loc2_ in param1.items)
               {
                  _loc3_.addItem(this.makeBuddyGroupFromRosterGroup(_loc2_));
               }
               this._buddyGroups.addAllAt(_loc3_,param1.location);
               break;
            case CollectionEventKind.REFRESH:
            case CollectionEventKind.RESET:
               this._buddyGroups.removeAll();
               for each(_loc2_ in this.roster.groups)
               {
                  _loc6_ = this.makeBuddyGroupFromRosterGroup(_loc2_);
                  this._buddyGroups.addItem(_loc6_);
               }
               break;
            case CollectionEventKind.REMOVE:
               _loc4_ = 0;
               _loc5_ = param1.items.length;
               while(_loc4_ < _loc5_)
               {
                  this._buddyGroups.removeItemAt(param1.location);
                  _loc4_++;
               }
               break;
         }
      }
      
      private function cleanupMessageListeners() : void
      {
         this.serviceProxy.chatService.removeConnectionEventListener(MessageEvent.MESSAGE,this.messageHandler);
      }
      
      protected function onLogin(param1:LoginEvent) : void
      {
         var _loc2_:String = null;
         this.loggingIn = false;
         if(!this.chatWindowDisplayed)
         {
            _loc2_ = this.serviceProxy.chatService.getConnection().username;
            this.currentUserJID = new UnescapedJID(_loc2_ + "@" + ClientConfig.JABBER_DOMAIN);
            dispatchEvent(new LoginEvent());
            this.chatWindowDisplayed = true;
            dispatchEvent(new Event("chatlogin"));
            if(this.isInGameOnLogin)
            {
               setTimeout(this.changePresence,50,PresenceStatusXML.GAME_STATUS_IN_GAME);
               this.isInGameOnLogin = false;
            }
            this.autoJoinRooms();
         }
         if(this.gameChatController)
         {
            this.gameChatController.activate();
         }
         setTimeout(this.presenceController.activate,50);
         this.loggedIn = true;
         this.startPresenceHandlerTimer();
         this.startUserPresenceDetection();
         setTimeout(this.setupActiveFriendsTimer,10000);
      }
      
      public function changePresence(param1:String) : void
      {
         this._inGame = !(param1 == PresenceStatusXML.GAME_STATUS_OUT_OF_GAME);
         this.presenceLayering.changeBasePresence(param1);
         this.presenceController.setGameStatus(this.presenceLayering.presenceWithPrecedence,PresenceStatusXML.getStatusShowMode(this.presenceLayering.presenceWithPrecedence),this.inGame,true);
      }
      
      public function moveBuddies(param1:String, param2:String) : void
      {
         this.roster.moveGroupMembers(param1,param2);
      }
      
      public function inviteToChat(param1:Array, param2:Boolean = false, param3:String = "pu") : void
      {
         if(this._friendTracker != null)
         {
            if(!param2)
            {
               this._friendTracker.incrementFriendChatInviteSent_InASession();
            }
            else
            {
               this._friendTracker.incrementBuddyGroupChatInviteSent_InASession();
            }
         }
         this.inviteToChatRoom(param1,this.currentUserChatRoomName,param3,null,false);
      }
      
      public function get personalImTimeStamps() : Boolean
      {
         return this._personalImTimeStamps;
      }
      
      public function set canAddBuddyToBuddyList(param1:Boolean) : void
      {
         var _loc2_:Object = this.canAddBuddyToBuddyList;
         if(_loc2_ !== param1)
         {
            this._296927628canAddBuddyToBuddyList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canAddBuddyToBuddyList",_loc2_,param1));
         }
      }
      
      public function inviteSummonersToChatRoom(param1:Array, param2:String, param3:String, param4:String, param5:String, param6:Boolean) : void
      {
         var _loc8_:* = NaN;
         var _loc9_:RosterItemVO = null;
         var _loc7_:Array = [];
         for each(_loc8_ in param1)
         {
            _loc9_ = this.getBuddyBySummonerId(_loc8_);
            if(!_loc9_)
            {
               _loc9_ = new RosterItemVO(unescapedJIDFromSummonerId(_loc8_));
               _loc9_.online = true;
               _loc9_.show = Presence.SHOW_CHAT;
            }
            _loc7_.push(_loc9_);
         }
         this.inviteToChatRoom(_loc7_,param3,param4,param5,param6);
      }
      
      public function get loggingIn() : Boolean
      {
         return this._loggingIn;
      }
      
      public function get buddyListOpen() : Boolean
      {
         return this._792412946buddyListOpen;
      }
      
      public function isAutojoinChannel(param1:String) : Boolean
      {
         var _loc2_:AutojoinChatDesc = null;
         for each(_loc2_ in this.autoJoinChatList)
         {
            if(_loc2_.roomName == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateBuddyGroup(param1:CollectionEvent) : void
      {
         var _loc3_:* = 0;
         var _loc4_:BuddyGroup = null;
         var _loc5_:ArrayCollection = null;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:RosterItemVO = null;
         var _loc9_:PropertyChangeEvent = null;
         var _loc10_:RosterItemVO = null;
         var _loc11_:Buddy = null;
         this.initializeBuddyGroups();
         this._buddyGroups.disableAutoUpdate();
         this.setAutoUpdateOnBuddyGroups(false);
         var _loc2_:RosterGroup = param1.target as RosterGroup;
         if(_loc2_ != null)
         {
            _loc3_ = this.roster.groups.getItemIndex(_loc2_);
            if(_loc3_ >= this._buddyGroups.length)
            {
               this.logger.warn("0001 invalid group id in updateBuddyGroup! Ignoring update");
               return;
            }
            _loc4_ = this._buddyGroups.getItemAt(_loc3_) as BuddyGroup;
            switch(param1.kind)
            {
               case CollectionEventKind.ADD:
                  _loc5_ = new ArrayCollection();
                  for each(_loc8_ in param1.items)
                  {
                     _loc5_.addItem(RosterUtility.getBuddy(_loc8_));
                  }
                  _loc4_.addAllAt(_loc5_,param1.location);
                  break;
               case CollectionEventKind.REFRESH:
                  _loc4_.refresh();
                  break;
               case CollectionEventKind.REMOVE:
                  _loc6_ = 0;
                  _loc7_ = param1.items.length;
                  while(_loc6_ < _loc7_)
                  {
                     _loc4_.removeItemAt(param1.location);
                     _loc6_++;
                  }
                  break;
               case CollectionEventKind.UPDATE:
                  for each(_loc9_ in param1.items)
                  {
                     _loc10_ = _loc9_.source as RosterItemVO;
                     _loc11_ = RosterUtility.getBuddy(_loc10_);
                     RosterUtility.populateBuddyFromRosterItem(_loc11_,_loc10_);
                  }
                  break;
            }
         }
         this.setAutoUpdateOnBuddyGroups(true);
         this._buddyGroups.enableAutoUpdate();
      }
      
      public function get buddyListModel() : BuddyListPresentationModel
      {
         return this._1203124485buddyListModel;
      }
      
      public function set chatRoomsMaximized(param1:Boolean) : void
      {
         var _loc2_:Object = this.chatRoomsMaximized;
         if(_loc2_ !== param1)
         {
            this._1349617544chatRoomsMaximized = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatRoomsMaximized",_loc2_,param1));
         }
      }
      
      public function set currentUserChatRoomName(param1:String) : void
      {
         var _loc2_:Object = this._453738366currentUserChatRoomName;
         if(_loc2_ !== param1)
         {
            this._453738366currentUserChatRoomName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentUserChatRoomName",_loc2_,param1));
         }
      }
      
      public function getCurrentState() : String
      {
         return this.currentState;
      }
      
      public function getChatMessageReceivedFromBuddy() : ISignal
      {
         return this._chatMessageReceivedFromBuddy;
      }
      
      public function set roster(param1:Roster) : void
      {
         var _loc2_:Object = this._925192565roster;
         if(_loc2_ !== param1)
         {
            this._925192565roster = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"roster",_loc2_,param1));
         }
      }
      
      private function onActiveFriendsTimer(param1:TimerEvent = null) : void
      {
         var _loc3_:RosterItemVO = null;
         var _loc2_:int = 0;
         if(this._friendTracker)
         {
            for each(_loc3_ in this.roster)
            {
               if(_loc3_.online)
               {
                  _loc2_++;
               }
            }
            this._friendTracker.setFriendsOnlineUserHas_InASession(_loc2_);
         }
      }
      
      public function isSummonerBuddy(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc4_:RosterGroup = null;
         var _loc5_:RosterItemVO = null;
         if(!this.roster)
         {
            return false;
         }
         var _loc3_:String = param1.toLowerCase();
         for each(_loc4_ in this.roster.groups)
         {
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_.displayName.toLowerCase() == _loc3_)
               {
                  if((param2) && (!(_loc5_.subscribeType == RosterExtension.SUBSCRIBE_TYPE_BOTH)))
                  {
                     return false;
                  }
                  return true;
               }
            }
         }
         return false;
      }
      
      public function get loggingInChanged() : ISignal
      {
         return this._loggingInChanged;
      }
      
      public function getChatRestoreChatViewsSignal() : ISignal
      {
         return this._chatRestoreChatViewsSignal;
      }
      
      public function set currentChatState(param1:String) : void
      {
         if(this._currentChatState == param1)
         {
            return;
         }
         this._currentChatState = param1;
         dispatchEvent(new Event("currentStateChanged"));
         this._chatStateChanged.dispatch();
      }
      
      public function messageHandler(param1:MessageEvent) : Boolean
      {
         var error:XIFFErrorEvent = null;
         var rosterItem:RosterItemVO = null;
         var queuedEvent:Object = null;
         var e:MessageEvent = param1;
         var m:Message = e.data as Message;
         var fromJID:String = m.from == null?null:m.from.bareJID;
         var isBlockingMessageSender:Boolean = false;
         if(this.privacyListController.isBlocked(fromJID))
         {
            isBlockingMessageSender = true;
         }
         var type:String = m.type;
         if(type == null)
         {
            type = Message.NORMAL_TYPE;
         }
         switch(type)
         {
            case Message.CHAT_TYPE:
               if((!m.body) || (isBlockingMessageSender))
               {
                  break;
               }
               try
               {
                  rosterItem = RosterItemVO.get(m.from.unescaped,false);
                  if(rosterItem.subscribeType != RosterExtension.SUBSCRIBE_TYPE_BOTH)
                  {
                     return false;
                  }
                  if(this.gameChatController)
                  {
                     this.gameChatController.chatMessageReceived(rosterItem,m);
                  }
                  if(this.quietMode)
                  {
                     queuedEvent = {};
                     queuedEvent.event = e;
                     queuedEvent.handlerFunction = this.messageHandler;
                     this.queueEvent(queuedEvent);
                     return true;
                  }
                  this._chatMessageReceivedSignal.dispatch(rosterItem,m);
                  this._chatMessageReceivedFromBuddy.dispatch(RosterUtility.getBuddy(rosterItem),m);
                  if(this.chatTracker != null)
                  {
                     this._chatTracker.incrementChatMessagesReceived_InASession(m.from.bareJID,m.body);
                  }
               }
               catch(e:Error)
               {
               }
               break;
            case Message.ERROR_TYPE:
               error = new XIFFErrorEvent();
               error.errorCode = m.errorCode;
               error.errorCondition = m.errorCondition;
               error.errorMessage = m.errorMessage;
               error.errorType = m.errorType;
               this.onError(error);
               break;
            case Message.NORMAL_TYPE:
               this.handleNormalMessage(m,isBlockingMessageSender);
               break;
         }
         var event:MessageEvent = new MessageEvent();
         event.data = e.data;
         dispatchEvent(event);
         this.dequeueNextEvent();
         return true;
      }
      
      public function getSubscriptionRequestSignal() : ISignal
      {
         return this._subscriptionRequestSignal;
      }
      
      public function isBlockedBySummonerId(param1:Number) : Boolean
      {
         return this.isBlockedByJid(jidFromSummonerId(param1));
      }
      
      public function getChatDisplayInviteRecievedSignal() : ISignal
      {
         return this._chatDisplayInviteRecievedSignal;
      }
      
      public function get currentUserIconID() : int
      {
         return this._currentUserIconID;
      }
      
      private function chatSubjectChanged(param1:Event) : void
      {
         var _loc2_:ChatRoom = param1.target as ChatRoom;
         if((_loc2_) && (_loc2_.subject))
         {
            _loc2_.removeEventListener("subjectChanged",this.chatSubjectChanged);
            this.addChatRoomToAppropriateList(_loc2_);
         }
      }
      
      public function removeBuddyWithJID(param1:UnescapedJID) : Boolean
      {
         var _loc4_:RosterItemVO = null;
         var _loc2_:RosterItemVO = null;
         var _loc3_:Boolean = false;
         for each(_loc4_ in this.roster)
         {
            if(_loc4_.jid.node == param1.node)
            {
               _loc2_ = _loc4_;
               break;
            }
         }
         if(_loc2_ != null)
         {
            this.roster.withdrawSubscription(param1);
            this.roster.removeContact(_loc2_);
            _loc3_ = true;
         }
         if(this._buddyRequestDict[param1.node])
         {
            delete this._buddyRequestDict[param1.node];
            true;
         }
         return _loc3_;
      }
      
      private function createChatRoom(param1:UnescapedJID, param2:String, param3:String, param4:String) : ChatRoom
      {
         var _loc5_:ChatRoom = null;
         var _loc6_:ChatRoom = null;
         for each(_loc5_ in this.allOpenChatRooms)
         {
            if(_loc5_.getRoomJID().equals(param1,true))
            {
               return _loc5_;
            }
         }
         _loc6_ = new ChatRoom(this,this.serviceProxy.chatService,this.presenceController,param1,param3,param4);
         _loc6_.subject = param2;
         this.addChatRoomToAppropriateList(_loc6_);
         return _loc6_;
      }
      
      private function set _1370146218chatRoomsTimeStamp(param1:Boolean) : void
      {
         this._chatRoomsTimeStamp = param1;
         UserPreferencesManager.userPrefs.chatRoomsTimeStamp = this._chatRoomsTimeStamp;
      }
      
      public function getPrivacyListInitializedSignal() : ISignal
      {
         return this._privacyListInitializedSignal;
      }
      
      public function getGroupIndex(param1:String) : int
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this.roster.groups.length)
         {
            if(this.roster.groups[_loc2_].label == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function logout() : void
      {
         this.loggedIn = false;
         dispatchEvent(new Event("chatlogout"));
         this.closeAllChatRooms();
         this._chatRemoveAllChatDisplaysSignal.dispatch();
         this._chatLoggingOutSignal.dispatch();
         this.cleanupXMPPConnection();
         this.cleanupRosterListeners();
         this.serviceProxy.chatService.disconnect(false,false);
         this.cleanupMessageListeners();
         this.presenceController.deactivate();
         if(this.gameChatController)
         {
            this.gameChatController.deactivate();
         }
         this.inviteBayItems = null;
         if(this.buddyListModelChangeWatcher != null)
         {
            this.buddyListModelChangeWatcher.unwatch();
            this.buddyListModelChangeWatcher = null;
         }
         this.privacyListController.logout();
         this.buddyListModel.logout();
         this.chatWindowDisplayed = false;
      }
      
      public function getGroupPriority(param1:String) : int
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < this.roster.groups.length)
         {
            if(this.roster.groups[_loc2_].label == param1)
            {
               return this.roster.groups[_loc2_].priority;
            }
            _loc2_++;
         }
         return RosterGroup.UNDEFINED_PRIORITY;
      }
      
      private function buddyGroupSortFunction(param1:Object, param2:Object, param3:Array = null) : int
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:* = 0;
         if(param1 == param2)
         {
            return 0;
         }
         if(param2 == null)
         {
            return -1;
         }
         if(param1 == null)
         {
            return 1;
         }
         var _loc4_:int = (param1 as RosterGroup).priority;
         var _loc5_:int = (param2 as RosterGroup).priority;
         if(_loc4_ > _loc5_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return 1;
         }
         _loc6_ = (param1 as RosterGroup).label;
         if(_loc6_ == this.getDefaultGroupName())
         {
            _loc6_ = ResourceManager.getInstance().getString("resources","chat_defaultBuddyGroup");
         }
         _loc7_ = (param2 as RosterGroup).label;
         if(_loc7_ == this.getDefaultGroupName())
         {
            _loc7_ = ResourceManager.getInstance().getString("resources","chat_defaultBuddyGroup");
         }
         _loc8_ = _loc6_.toLocaleLowerCase().localeCompare(_loc7_.toLocaleLowerCase());
         if(_loc8_ > 0)
         {
            return 1;
         }
         if(_loc8_ < 0)
         {
            return -1;
         }
         return 0;
      }
      
      private function handleAASNotification(param1:Message) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:AntiIndulgenceMessage = null;
         if(param1.from.bareJID == "admin@" + ClientConfig.JABBER_DOMAIN)
         {
            _loc2_ = param1.body;
            _loc3_ = _loc2_.split(",");
            _loc4_ = StringUtil.trim(_loc3_[0] as String);
            _loc5_ = _loc3_.length > 1?StringUtil.trim(_loc3_[1] as String):"";
            _loc6_ = new AntiIndulgenceMessage(param1.subject,_loc4_,_loc5_);
            AppConfig.instance.antiIndulgenceMessage = _loc6_;
            this.sendGameAntiIndulgenceMessage(_loc6_);
         }
      }
      
      private function setAutoUpdateOnBuddyGroups(param1:Boolean) : void
      {
         var _loc2_:BuddyGroup = null;
         for each(_loc2_ in this._buddyGroups)
         {
            if(param1)
            {
               _loc2_.enableAutoUpdate();
            }
            else
            {
               _loc2_.disableAutoUpdate();
            }
         }
      }
      
      public function getChatRankedTeamUpdatedSignal() : ISignal
      {
         return this._chatRankedTeamUpdatedSignal;
      }
      
      public function getAllOccupantsInChatRooms() : ArrayCollection
      {
         var _loc2_:ChatRoom = null;
         var _loc3_:RoomOccupant = null;
         var _loc1_:ArrayCollection = new ArrayCollection();
         for each(_loc2_ in this.allOpenChatRooms)
         {
            for each(_loc3_ in _loc2_.getRoomOccupants())
            {
               _loc1_.addItem(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function hasSubscriptionRequest(param1:String) : Boolean
      {
         return !(this._buddySubscriptionDict[param1] == null);
      }
      
      public function set personalImTimeStamps(param1:Boolean) : void
      {
         var _loc2_:Object = this.personalImTimeStamps;
         if(_loc2_ !== param1)
         {
            this._473812193personalImTimeStamps = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"personalImTimeStamps",_loc2_,param1));
         }
      }
      
      private function makeBuddyGroupFromRosterGroup(param1:RosterGroup) : BuddyGroup
      {
         var _loc3_:RosterItemVO = null;
         var _loc4_:Buddy = null;
         var _loc2_:BuddyGroup = new BuddyGroup();
         _loc2_.setLabel(param1.label);
         for each(_loc3_ in param1)
         {
            _loc4_ = RosterUtility.getBuddy(_loc3_);
            _loc2_.addItem(_loc4_);
         }
         return _loc2_;
      }
      
      public function getCurrentStateChanged() : ISignal
      {
         return this._chatStateChanged;
      }
      
      public function set loggingIn(param1:Boolean) : void
      {
         this._loggingIn = param1;
         this._loggingInChanged.dispatch(param1);
      }
      
      public function getChatCloseAllChatRoomsSignal() : ISignal
      {
         return this._chatCloseAllChatRoomsSignal;
      }
      
      public function set currentUserDisplayName(param1:String) : void
      {
         var _loc2_:Object = this.currentUserDisplayName;
         if(_loc2_ !== param1)
         {
            this._1928130839currentUserDisplayName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentUserDisplayName",_loc2_,param1));
         }
      }
      
      public function set buddyListOpen(param1:Boolean) : void
      {
         var _loc2_:Object = this._792412946buddyListOpen;
         if(_loc2_ !== param1)
         {
            this._792412946buddyListOpen = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buddyListOpen",_loc2_,param1));
         }
      }
      
      public function get errorDataProvider() : ArrayCollection
      {
         return this._1925355037errorDataProvider;
      }
      
      private function onPendingFriendRequestTimerComplete(param1:TimerEvent) : void
      {
         this._pendingFriendRequestTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPendingFriendRequestTimerComplete);
         this._pendingFriendRequestTimer.stop();
         this._pendingFriendRequestTimer = null;
         this._receivingPendingFriendRequests = false;
      }
      
      public function changePresenceToSpecating(param1:String, param2:Object) : void
      {
         this.presenceController.presenceStatus.setDropInSpectatorId(param1);
         this.presenceController.presenceStatus.setFeaturedGameData(jsonEncode(param2));
         this.changePresence(PresenceStatusXML.GAME_STATUS_IN_SPECTATING);
      }
      
      public function get inviteBayItems() : ArrayCollection
      {
         return this._1808108049inviteBayItems;
      }
      
      public function addPresenceLayer(param1:String) : void
      {
         this.presenceLayering.addPresenceLayer(param1,this.inGame);
      }
      
      private function get quietMode() : Boolean
      {
         return this._quietMode;
      }
      
      public function isValidNewGroupName(param1:String) : Boolean
      {
         var _loc2_:BuddyGroup = null;
         if((param1 == this.getOfflineGroupName()) || (param1 == this.getDefaultGroupName()) || (param1 == this.resourceManager.getString("resources","chat_defaultBuddyGroup")) || (strTrim(param1) == ""))
         {
            return false;
         }
         for each(_loc2_ in this.getBuddyGroups())
         {
            if(param1 == _loc2_.getLabel())
            {
               return false;
            }
         }
         return true;
      }
      
      public function showPromptMessage(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String = null, param7:String = null, param8:Function = null, param9:Object = null, param10:Boolean = true, param11:int = -1) : void
      {
         var _loc12_:String = this.resourceManager.getString(param1,param3);
         var _loc13_:String = this.resourceManager.getString(param1,param5);
         var _loc14_:String = null;
         if(param6 != null)
         {
            _loc14_ = this.resourceManager.getString(param1,param6);
         }
         var _loc15_:DockedPrompt = DockedPrompt.create(param2,_loc12_,param4,_loc13_,_loc14_,param7,param8,param9,param10,param11);
         NotificationsProviderProxy.instance.showDockedPrompt(_loc15_);
      }
      
      public function sendBuddyMessage(param1:String, param2:String) : void
      {
         this.serviceProxy.chatService.sendBuddyMessage(param1,param2);
         if(this.chatTracker != null)
         {
            this._chatTracker.incrementChatMessageSent_InASession(param1,param2);
         }
      }
      
      public function isJidBuddy(param1:UnescapedJID) : Boolean
      {
         var _loc2_:RosterItemVO = null;
         for each(_loc2_ in this.roster)
         {
            if(_loc2_.jid.node == param1.node)
            {
               return true;
            }
         }
         return false;
      }
      
      private function changeGroupsPriorities(param1:Array, param2:Array) : void
      {
         var _loc3_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == this.buddyListModel.defaultGroupName)
            {
               this.buddyListModel.defaultGroupPriority = param2[_loc3_];
               break;
            }
            _loc3_++;
         }
         this.roster.changeGroupsPriorities(param1,param2);
      }
      
      public function obfuscateChatRoom(param1:String, param2:String) : String
      {
         var _loc7_:uint = 0;
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1.toLowerCase(),"utf-8");
         var _loc4_:IHash = new SHA1();
         var _loc5_:ByteArray = _loc4_.hash(_loc3_);
         var _loc6_:String = "";
         var _loc8_:int = 0;
         while(_loc8_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc8_];
            _loc6_ = _loc6_ + ((_loc7_ & 240) >>> 4).toString(16);
            _loc6_ = _loc6_ + (_loc7_ & 15).toString(16);
            _loc8_++;
         }
         _loc6_ = _loc6_.replace(new RegExp("\\s+","gx"),"");
         _loc6_ = _loc6_.replace(new RegExp("[^a-zA-Z0-9_~]","gx"),"");
         return param2 + ChatRoomType.PREFIX_DELIMITER + _loc6_;
      }
      
      private function onRosterChanged(param1:CollectionEvent) : void
      {
         if(param1 != null)
         {
            this.updateBuddyGroup(param1);
         }
         dispatchEvent(new RosterProviderEvent(RosterProviderEvent.ROSTER_CHANGED));
      }
      
      private function onHandleChatInviteSuccess(param1:ResultEvent) : void
      {
         var _loc2_:SummonerSummary = param1.result as SummonerSummary;
         var _loc3_:String = "";
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.name;
         }
         this.soundManager.play(AudioKeys.SOUND_GAME_INVITE);
         var _loc4_:Object = this.pendingChatInvite.pop();
         var _loc5_:String = this.obfuscateChatRoom(_loc4_["subject"],_loc4_["type"]);
         var _loc6_:String = this.resourceManager.getString("resources","chat_buddyWindow_inviteMessage",["<font size=\"13\">" + _loc3_ + "</font>"]);
         this._chatDisplayInviteRecievedSignal.dispatch(_loc5_,"resources",_loc6_,"chat_buddyWindow_inviteBuddyAlertTitle",_loc3_,"common_button_accept","common_button_decline",DockedPrompt.TYPE_FRIEND_INVITE,this.handleInviteResponse,_loc4_);
         dispatchEvent(param1);
         this.dequeueNextEvent();
      }
      
      public function getChatMinimizeChatViewsSignal() : ISignal
      {
         return this._chatMinimizeChatViewsSignal;
      }
      
      public function set buddyListModel(param1:BuddyListPresentationModel) : void
      {
         var _loc2_:Object = this._1203124485buddyListModel;
         if(_loc2_ !== param1)
         {
            this._1203124485buddyListModel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buddyListModel",_loc2_,param1));
         }
      }
      
      private function requestChatProperRoom(param1:String, param2:String, param3:String, param4:String, param5:String) : ChatRoom
      {
         var _loc6_:Boolean = param5 == ChatRoomType.PUBLIC;
         if(param1.length > 0)
         {
            return this.createChatRoom(ChatRoom.createRoomJID(param1,param2,param4,_loc6_,true,this.servicesConfig),param3,param4,param5);
         }
         return null;
      }
      
      private function setupActiveFriendsTimer() : void
      {
         this.activeFriendsTimer = new Timer(300000,0);
         this.activeFriendsTimer.addEventListener(TimerEvent.TIMER,this.onActiveFriendsTimer);
         this.activeFriendsTimer.start();
         this.onActiveFriendsTimer();
      }
      
      private function startPresenceHandlerTimer() : void
      {
         this.roster.removeEventListener(RosterEvent.USER_PRESENCE_ONLINE,this.presenceOnlineHandler);
         this.presenceHandlerTimer.start();
      }
      
      private function rosterHandler(param1:RosterEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:Presence = null;
         var _loc5_:RosterItemVO = null;
         var _loc6_:RosterItemVO = null;
         if(this.quietMode)
         {
            _loc2_ = {};
            _loc2_.event = param1;
            _loc2_.handlerFunction = this.rosterHandler;
            this.queueEvent(_loc2_);
            return;
         }
         switch(param1.type)
         {
            case RosterEvent.SUBSCRIPTION_REQUEST:
               this.subscriptionRequest(param1.jid);
               break;
            case RosterEvent.USER_UNAVAILABLE:
               this.dequeueNextEvent();
               break;
            case RosterEvent.USER_AVAILABLE:
               if(param1.data is Presence)
               {
                  _loc4_ = param1.data as Presence;
                  if((_loc4_.type == Presence.SUBSCRIBED_TYPE) || (_loc4_.type == Presence.UNSUBSCRIBE_TYPE))
                  {
                     delete this._buddyRequestDict[param1.jid.node];
                     true;
                  }
                  this._userAvailableSignal.dispatch(param1.data);
               }
               this.dequeueNextEvent();
               break;
            case RosterEvent.USER_ADDED:
               this._buddyAddedSignal.dispatch(param1.data);
               this.dequeueNextEvent();
               break;
            case RosterEvent.USER_REMOVED:
               this._buddyRemovedSignal.dispatch(param1.data);
               this.dequeueNextEvent();
               break;
            case RosterEvent.SUBSCRIPTION_DENIAL:
               this.subscriptionDenial(param1.jid);
               break;
            case RosterEvent.SUBSCRIPTION_REVOCATION:
               this.dequeueNextEvent();
               break;
            case RosterEvent.ROSTER_LOADED:
               _loc3_ = [];
               for each(_loc5_ in this.roster)
               {
                  if(_loc5_.displayName == _loc5_.jid.node)
                  {
                     this.fixBustedRosterItem(_loc5_.jid);
                  }
                  if(_loc5_.subscribeType == RosterExtension.SUBSCRIBE_TYPE_TO)
                  {
                     this.roster.grantSubscription(_loc5_.jid,false);
                  }
                  else if(_loc5_.subscribeType == RosterExtension.SUBSCRIBE_TYPE_FROM)
                  {
                     this.roster.requestSubscription(_loc5_.jid,false);
                  }
                  else if((_loc5_.subscribeType == RosterExtension.SUBSCRIBE_TYPE_NONE) && (_loc5_.askType == RosterExtension.ASK_TYPE_NONE))
                  {
                     _loc3_.push(_loc5_);
                  }
                  
                  
               }
               for each(_loc6_ in _loc3_)
               {
                  this.roster.removeContact(_loc6_);
               }
               if(this.buddyListModel.sourceRosterGroups == null)
               {
                  this.buddyListModel.sourceRosterGroups = this.roster.groups;
               }
               if(this._friendTracker != null)
               {
                  this._friendTracker.setNumberOfFriendsUserHas_InASession(this.roster.length);
               }
               this.listenForRosterChanges();
               this.initializeBuddyGroups();
               this._buddyGroupsInitialized = true;
               this.renameGeneralToDefault();
               ProviderLookup.publishProvider(IChatProvider,this);
               ProviderLookup.publishProvider(IChatRoomProvider,this);
               this.dispatchEvent(param1);
               this.dequeueNextEvent();
               break;
         }
      }
      
      public function getChatCloseChatRoomSignal() : ISignal
      {
         return this._chatCloseChatRoomSignal;
      }
      
      private function onGameProviderRetrieved(param1:IGameProvider) : void
      {
         this._gameProvider = param1;
      }
      
      public function isPrivacyListReady() : Boolean
      {
         return this._privacyListReady;
      }
      
      public function get chatRoomsTimeStamp() : Boolean
      {
         return this._chatRoomsTimeStamp;
      }
      
      public function addGroup(param1:String, param2:int = 0, param3:Boolean = false) : RosterGroup
      {
         var _loc4_:RosterGroup = null;
         var _loc5_:String = StringUtil.trim(param1);
         if(param2 == 0)
         {
            if(this.roster.groups.length > 0)
            {
               var param2:int = this.roster.groups[0].priority + 1;
            }
            else
            {
               param2 = RosterGroup.UNDEFINED_PRIORITY;
            }
         }
         if((this.isValidNewGroupName(_loc5_)) || (param3))
         {
            _loc4_ = new RosterGroup(_loc5_,param2);
            this.roster.groups.addItem(_loc4_);
            this.reprioritizeRosterGroups();
            if((!(this._friendTracker == null)) && (!param3))
            {
               this._friendTracker.incrementBuddyGroupCreated_InASession();
            }
         }
         return _loc4_;
      }
      
      public function get loggedIn() : Boolean
      {
         return this._2020648519loggedIn;
      }
      
      private function onTotalBuddyCountChanged(param1:PropertyChangeEvent) : void
      {
         var _loc2_:int = param1.oldValue as int;
         var _loc3_:int = param1.newValue as int;
         if((_loc2_ >= ChatController.MAXIMUM_BUDDY_LIST_SIZE) && (_loc3_ < ChatController.MAXIMUM_BUDDY_LIST_SIZE) || (_loc2_ < ChatController.MAXIMUM_BUDDY_LIST_SIZE) && (_loc3_ >= ChatController.MAXIMUM_BUDDY_LIST_SIZE))
         {
            this.canAddBuddyToBuddyList = !this.canAddBuddyToBuddyList;
         }
      }
      
      private function dequeueEvents() : void
      {
         this.queuedEvents.reverse();
         this.dequeueNextEvent();
      }
      
      public function getChatCloseMatchmakingQueueChatRoomSignal() : ISignal
      {
         return this._chatCloseMatchmakingQueueChatRoomSignal;
      }
      
      public function get canAddBuddyToBuddyList() : Boolean
      {
         return this.buddyListModel.totalBuddyCount < ChatController.MAXIMUM_BUDDY_LIST_SIZE;
      }
      
      public function isCustomRosterGroup(param1:RosterGroup) : Boolean
      {
         if((param1 == null) || (param1.label == this.buddyListModel.offlineGroupName) || (param1.label == this.buddyListModel.defaultGroupName))
         {
            return false;
         }
         return true;
      }
      
      public function closeChatRoom(param1:ChatRoom) : void
      {
         var _loc2_:Array = null;
         var _loc3_:* = 0;
         if(param1 != null)
         {
            _loc2_ = [];
            if(this.isChatRoomPublic(param1))
            {
               _loc3_ = this.allOpenChatRooms.getItemIndex(param1);
               if(_loc3_ >= 0)
               {
                  _loc2_.push(_loc3_);
               }
            }
            else
            {
               _loc2_ = this.getChatRoomSubjectIndexes(param1.subject,param1.getRoomType());
            }
            if(_loc2_.length > 0)
            {
               this.closeChatRoomIndexes(_loc2_);
            }
            else
            {
               param1.leave();
            }
         }
      }
      
      public function getOfflineGroupName() : String
      {
         return this.buddyListModel.offlineGroupName;
      }
      
      private function getGameProvider() : void
      {
         ProviderLookup.getProvider(IGameProvider,this.onGameProviderRetrieved);
      }
      
      private function initializeBuddyGroups() : void
      {
         var _loc1_:RosterGroup = null;
         var _loc2_:BuddyGroup = null;
         if(!this._buddyGroupsInitialized)
         {
            this._buddyGroups.source = [];
            for each(_loc1_ in this.roster.groups)
            {
               _loc2_ = this.makeBuddyGroupFromRosterGroup(_loc1_);
               this._buddyGroups.addItem(_loc2_);
               if(_loc1_.label == this.buddyListModel.defaultGroupName)
               {
                  this.buddyListModel.defaultGroupPriority = _loc1_.priority;
               }
            }
         }
      }
      
      public function get roster() : Roster
      {
         return this._925192565roster;
      }
      
      public function restore() : void
      {
         this.quietMode = false;
         this._chatRestoreChatViewsSignal.dispatch();
      }
      
      private function setupMessageListeners() : void
      {
         this.serviceProxy.chatService.addConnectionEventListener(MessageEvent.MESSAGE,this.messageHandler);
      }
      
      private function warnTooManyGroupChatWindows() : void
      {
         var _loc1_:String = this.resourceManager.getString("resources","alert_title");
         var _loc2_:AlertAction = new AlertAction(_loc1_,this.resourceManager.getString("resources","chat_groupChatWindow_toomany_rooms",[ChatController.MAXIMUM_OPEN_GROUP_CHAT_WINDOWS]));
         _loc2_.add();
      }
      
      public function get currentState() : String
      {
         var _loc1_:String = null;
         switch(this._currentChatState)
         {
            case ChatServiceState.STATE_LOGGING_IN:
               _loc1_ = LOGGING_IN;
               break;
            case ChatServiceState.STATE_LOGGING_OUT:
               _loc1_ = LOGGING_OUT;
               break;
            case ChatServiceState.STATE_DISCONNECTED:
            case ChatServiceState.STATE_DELAYED_RECONNECT:
               _loc1_ = OFFLINE;
               break;
            case ChatServiceState.STATE_RECONNECTING:
               _loc1_ = TEMP_FAILURE;
               break;
            case ChatServiceState.STATE_CONNECTED:
               _loc1_ = ONLINE;
               break;
         }
         return _loc1_;
      }
      
      private function renameGeneralToDefault() : void
      {
         var _loc2_:BuddyGroup = null;
         var _loc1_:ConfigurationModel = DynamicClientConfigManager.getConfiguration(ChatConfig.NAMESPACE,ChatConfig.RENAME_GENERAL_GROUP_THROTTLE,1);
         if(Math.random() < _loc1_.getValue())
         {
            for each(_loc2_ in this._buddyGroups)
            {
               if(_loc2_.getLabel() == ResourceManager.getInstance().getString("resources","chat_defaultBuddyGroup"))
               {
                  this.emptyAndRemoveGroup(_loc2_.getLabel());
               }
            }
         }
      }
      
      private function subscriptionDenial(param1:UnescapedJID) : void
      {
         this.removeBuddyWithJID(param1);
         this.dequeueNextEvent();
      }
      
      public function addBuddy(param1:String, param2:String = null) : void
      {
         var param1:String = StringUtil.trim(param1);
         if((param1.length == 0) || (param1.toLowerCase() == this.currentUserDisplayName.toLowerCase()))
         {
            return;
         }
         if(!this.canAddBuddyToBuddyList)
         {
            this.warnTooManyFriends();
            return;
         }
         if((!(param2 == null)) && (param2 == this.buddyListModel.offlineGroupName))
         {
            var param2:String = null;
         }
         var _loc3_:int = this.buddyListModel.defaultGroupPriority;
         var _loc4_:int = this.getGroupIndex(param2);
         if(_loc4_ != -1)
         {
            _loc3_ = this.roster.groups[_loc4_].priority;
         }
         var _loc5_:Object = {
            "buddyName":param1,
            "groupName":param2,
            "groupPriority":_loc3_
         };
         this.serviceProxy.summonerService.getSummonerInternalNameByName(param1,this.onAddBuddyGetInternalNameSuccess,null,null,_loc5_);
      }
      
      public function removeAutoJoinRoom(param1:ChatRoom) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.getRoomJID().node;
         var _loc3_:String = param1.subject;
         var _loc4_:int = -1;
         var _loc5_:int = 0;
         while(_loc5_ < this.autoJoinChatList.length)
         {
            if((_loc2_ == this.autoJoinChatList[_loc5_].roomName) || (_loc3_ == this.autoJoinChatList[_loc5_].roomSubject))
            {
               _loc4_ = _loc5_;
               break;
            }
            _loc5_++;
         }
         if(_loc4_ > -1)
         {
            this.autoJoinChatList.splice(_loc4_,1);
         }
      }
      
      public function closeChatRoomBySubject(param1:String, param2:String = "pu") : void
      {
         var _loc3_:Array = this.getChatRoomSubjectIndexes(param1,param2);
         this.closeChatRoomIndexes(_loc3_);
      }
      
      private function isJidInRoster(param1:UnescapedJID) : Boolean
      {
         var _loc2_:RosterItemVO = RosterItemVO.get(param1,false);
         return (!(_loc2_ == null)) && (!(this.roster == null)) && (this.roster.contains(_loc2_));
      }
      
      public function minimize() : void
      {
         this.quietMode = true;
         this._chatMinimizeChatViewsSignal.dispatch();
      }
      
      private function privacyListInitialized() : void
      {
         this._privacyListReady = true;
         this._privacyListInitializedSignal.dispatch();
      }
      
      public function set chatRoomsStartFocused(param1:Boolean) : void
      {
         var _loc2_:Object = this._1136849067chatRoomsStartFocused;
         if(_loc2_ !== param1)
         {
            this._1136849067chatRoomsStartFocused = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chatRoomsStartFocused",_loc2_,param1));
         }
      }
      
      public function get inGame() : Boolean
      {
         return this._inGame;
      }
      
      public function addChatRoomToAppropriateList(param1:ChatRoom) : void
      {
         if((param1.subject == null) || (param1.subject == ""))
         {
            param1.addEventListener("subjectChanged",this.chatSubjectChanged);
            return;
         }
         if(this.getChatRoomSubjectIndexes(param1.subject,param1.getRoomType()).length == 0)
         {
            this.allOpenChatRooms.addItem(param1);
            if(param1.getRoomType() == ChatRoomType.PUBLIC)
            {
               this._numPublicChatrooms++;
            }
            if(this.chatTracker != null)
            {
               this._chatTracker.setChatWindowsOpenedAtOnce(this.allOpenChatRooms.length);
            }
         }
      }
      
      public function updateRosterNote(param1:RosterItemVO, param2:String) : void
      {
         var _loc5_:RosterGroup = null;
         var _loc3_:Array = this.roster.getContainingGroups(param1);
         var _loc4_:String = "";
         if(_loc3_.length)
         {
            _loc5_ = _loc3_[0] as RosterGroup;
            _loc4_ = _loc5_.label;
         }
         this.serviceProxy.chatService.updateRosterNote(param1,_loc4_,param2);
         if(this._friendTracker != null)
         {
            this._friendTracker.incrementBuddyNoteCreated_InASession();
         }
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      private function handleInviteResponse(param1:String, param2:Object) : void
      {
         var _loc3_:Room = param2["room"];
         var _loc4_:String = param2["subject"];
         var _loc5_:String = param2["type"];
         var _loc6_:String = null;
         if((!_loc5_) || (_loc5_ == ""))
         {
            _loc5_ = ChatRoomType.PUBLIC;
         }
         if(param1 == ButtonNameType.LEFT_BUTTON)
         {
            if((this._numPublicChatrooms >= MAXIMUM_OPEN_GROUP_CHAT_WINDOWS) && (!(_loc5_ == ChatRoomType.PRIVATE)))
            {
               this.warnTooManyGroupChatWindows();
               return;
            }
            this.openObfuscatedChatRoom(_loc3_.roomName,this.extractConferenceName(_loc3_.conferenceServer),_loc6_,_loc4_,_loc5_);
         }
         else
         {
            _loc3_.decline(_loc3_.userJID,this.resourceManager.getString("resources","chat_buddyWindow_defaultDeclineChatReason"));
         }
      }
      
      public function getChatLoggingOutSignal() : ISignal
      {
         return this._chatLoggingOutSignal;
      }
      
      private function subscriptionRequest(param1:UnescapedJID) : void
      {
         var _loc2_:BuddySubscriptionRequestData = null;
         if(this.privacyListController.isBlocked(param1.bareJID))
         {
            this.roster.denySubscription(param1);
         }
         else if(this._buddyRequestDict[param1.node])
         {
            delete this._buddyRequestDict[param1.node];
            true;
            this.roster.grantSubscription(param1,false);
         }
         else if(this.isJidBuddy(param1))
         {
            this.roster.grantSubscription(param1,false);
         }
         else if(!this.canAddBuddyToBuddyList)
         {
            this.roster.denySubscription(param1);
         }
         else
         {
            _loc2_ = new BuddySubscriptionRequestData();
            _loc2_.subscriptionRequestJID = param1;
            this._buddySubscriptionDict[param1.node] = _loc2_;
            this._subscriptionRequestSignal.dispatch(_loc2_);
            this.serviceProxy.statisticsService.getSummonerSummaryByInternalName(param1.node,this.onSubscriptionRequestSucccess,null);
         }
         
         
         
      }
      
      public function isBlockedByJid(param1:String) : Boolean
      {
         return this.privacyListController.isBlocked(param1);
      }
      
      public function sendGameAntiIndulgenceMessage(param1:AntiIndulgenceMessage) : void
      {
         if(this.gameChatController)
         {
            this.gameChatController.AASNotificationReceived(param1);
         }
      }
      
      public function moveGroupDown(param1:String) : void
      {
         var _loc2_:int = this.getGroupIndex(param1);
         if((_loc2_ == this.roster.groups.length - 1) || (_loc2_ == -1))
         {
            return;
         }
         var _loc3_:int = this.roster.groups[_loc2_ + 1].priority;
         this.roster.groups[_loc2_ + 1].priority = this.roster.groups[_loc2_].priority;
         this.roster.groups[_loc2_].priority = _loc3_;
         this.changeGroupsPriorities([this.roster.groups[_loc2_ + 1].label,this.roster.groups[_loc2_].label],[this.roster.groups[_loc2_ + 1].priority,this.roster.groups[_loc2_].priority]);
      }
      
      public function removePresenceLayer(param1:String) : void
      {
         this.presenceLayering.removePresenceLayer(param1,this.inGame);
      }
      
      public function get currentUserDisplayName() : String
      {
         return this._currentUserDisplayName;
      }
      
      public function getChatDisplayNameChangedSignal() : ISignal
      {
         return this._chatDisplayNameChangedSignal;
      }
      
      private function onSubscriptionRequestSucccess(param1:ResultEvent) : void
      {
         var summonerSummary:SummonerSummary = null;
         var handleContactDetails:Function = null;
         var event:ResultEvent = param1;
         summonerSummary = event.result as SummonerSummary;
         var friendRecoManager:FriendRecommendationService = FriendRecommendationService.instance();
         if(friendRecoManager.isEnabled())
         {
            handleContactDetails = function(param1:Error, param2:RecofrienderContactDetailsDto):void
            {
               if((param1 == null) && (!(param2 == null)))
               {
                  continueSubscriptionRequestSuccess(summonerSummary,param2.getName(),param2.getImageUrl());
               }
               else
               {
                  continueSubscriptionRequestSuccess(summonerSummary,null,null);
               }
            };
            friendRecoManager.getContactDetailsFromSummoner(summonerSummary.getSummonerIdForInternalName(),summonerSummary.name,handleContactDetails,this);
         }
         else
         {
            this.continueSubscriptionRequestSuccess(summonerSummary,null,null);
         }
      }
      
      private function continueSubscriptionRequestSuccess(param1:SummonerSummary, param2:String, param3:String) : void
      {
         var _loc5_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:DockedPrompt = null;
         var _loc4_:String = "";
         if(param1 != null)
         {
            _loc4_ = param1.name;
         }
         if(param2)
         {
            _loc5_ = this.resourceManager.getString("resources","chat_buddyWindow_realNameSubscriptionRequest",["<font size=\"13\" >" + param2 + "</font>","<font size=\"13\" >" + _loc4_ + "</font>"]);
         }
         else
         {
            _loc5_ = this.resourceManager.getString("resources","chat_buddyWindow_subscriptionRequest",["<font size=\"13\" >" + _loc4_ + "</font>"]);
         }
         var _loc6_:String = this.resourceManager.getString("resources","chat_buddyWindow_addBuddyDisabledMessage",["<font size=\"13\" >" + _loc4_ + "</font>"]);
         var _loc7_:BuddySubscriptionRequestData = this._buddySubscriptionDict[param1.internalName];
         if(_loc7_ != null)
         {
            _loc7_.summonerSummary = param1;
            _loc8_ = this.resourceManager.getString("resources","chat_buddyWindow_subscriptionRequestAlertTitle");
            _loc9_ = this.resourceManager.getString("resources","common_button_accept");
            _loc10_ = this.resourceManager.getString("resources","common_button_decline");
            _loc11_ = DockedPrompt.create(_loc5_,_loc8_,_loc4_,_loc9_,_loc10_,DockedPrompt.TYPE_FRIEND_INVITE,this.onSubscriptionRequestSucccessCallBack,_loc7_,true,-1,_loc6_,param3);
            NotificationsProviderProxy.instance.showDockedPrompt(_loc11_);
            if((!(this._friendTracker == null)) && (!this._receivingPendingFriendRequests))
            {
               this._friendTracker.incrementFriendRequestReceived_InASession();
            }
         }
         else
         {
            this.logger.error("ChatController.onSubscriptionRequestSucccess: Unable to find subscriptiondata: " + param1.internalName);
         }
      }
      
      public function getChatNormalMessageRecievedSignal() : ISignal
      {
         return this._chatNormalMessageReceivedSignal;
      }
      
      public function getBuddyGroups() : ListCollectionView
      {
         return new ListCollectionView(this._buddyGroups);
      }
      
      private function autoJoinRooms() : void
      {
         var _loc1_:AutojoinChatDesc = null;
         this.chatRoomsStartFocused = false;
         for each(_loc1_ in this.autoJoinChatList)
         {
            this.openChatRoom(_loc1_.roomSubject,_loc1_.roomType);
         }
         this.chatRoomsStartFocused = true;
      }
      
      public function getRosterPresenceUpdatedSignal() : ISignal
      {
         return this._rosterPresenceUpdatedSignal;
      }
      
      public function set currentUserJID(param1:UnescapedJID) : void
      {
         var _loc2_:Object = this.currentUserJID;
         if(_loc2_ !== param1)
         {
            this._1737028735currentUserJID = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentUserJID",_loc2_,param1));
         }
      }
      
      public function leaveMatchmakingQueueChatRoom() : void
      {
         if(this.inQueueChatRoom != null)
         {
            this.closeChatRoom(this.inQueueChatRoom);
         }
         this._chatCloseMatchmakingQueueChatRoomSignal.dispatch(this.inQueueChatRoom);
      }
      
      private function get presenceLayering() : ChatPresenceLayering
      {
         if(this._chatPresenceLayering == null)
         {
            this._chatPresenceLayering = new ChatPresenceLayering(this.presenceController);
         }
         return this._chatPresenceLayering;
      }
      
      public function refreshOccupantCountForRoom(param1:ChatRoom) : void
      {
         var _loc2_:QueryRoomInformationHandler = new QueryRoomInformationHandler();
         _loc2_.queryChatRoomInformation(param1,param1.getRegisteredChatService());
      }
      
      private function openObfuscatedChatRoom(param1:String, param2:String, param3:String, param4:String, param5:String) : String
      {
         var _loc6_:ChatRoom = this.requestChatProperRoom(param1,param2,param4,param3,param5);
         _loc6_.join();
         this._chatOpenChatRoomViewSignal.dispatch(_loc6_,param5);
         GroupChatBehaviorTracker.instance.incrementPublicChatRoomsVisited_InASession(_loc6_.subject,_loc6_.getRoomJID());
         return param1;
      }
      
      private function onRosterStructureChanged(param1:CollectionEvent) : void
      {
         var _loc2_:ArrayCollection = null;
         if((!(param1 == null)) && (param1.kind == CollectionEventKind.REMOVE))
         {
            for each(_loc2_ in param1.items)
            {
               _loc2_.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onRosterChanged);
            }
         }
         for each(_loc2_ in this.roster.groups)
         {
            _loc2_.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onRosterChanged);
         }
         if(param1 != null)
         {
            this.updateBuddyGroupsStructure(param1);
         }
         dispatchEvent(new RosterProviderEvent(RosterProviderEvent.ROSTER_CHANGED));
      }
      
      private function onGetCrossModuleTrackerProvider(param1:ICrossModuleTrackerProvider) : void
      {
         this._chatTracker = param1.getChatTracker();
         this._friendTracker = param1.getFriendListBehaviorTracker();
      }
      
      private function setupConnectionListeners() : void
      {
         this.serviceProxy.chatService.addInviteListener(InviteEvent.INVITED,this.handleInvite);
         this.serviceProxy.chatService.addConnectionEventListener(XIFFErrorEvent.XIFF_ERROR,this.onError);
         this.serviceProxy.chatService.addConnectionEventListener(OutgoingDataEvent.OUTGOING_DATA,this.onOutgoingData);
         this.serviceProxy.chatService.addConnectionEventListener(IncomingDataEvent.INCOMING_DATA,this.onIncomingData);
         this.serviceProxy.chatService.addConnectionEventListener(LoginEvent.LOGIN,this.onLogin);
         this.serviceProxy.chatService.addChatServiceEventListener(DisconnectionEvent.DISCONNECT,this.onDisconnect);
      }
      
      public function getCurrentUserJIDChangedSignal() : ISignal
      {
         return this._currentUserJIDChangedSignal;
      }
      
      public function addAutoJoinRoom(param1:ChatRoom) : void
      {
         var _loc3_:AutojoinChatDesc = null;
         var _loc4_:AutojoinChatDesc = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:String = param1.getRoomJID().node;
         if((_loc2_ == "") || (param1.subject == "") || (param1.subject == null))
         {
            return;
         }
         for each(_loc3_ in this.autoJoinChatList)
         {
            if(_loc3_.roomName == _loc2_)
            {
               _loc3_.roomSubject = _loc3_.roomSubject;
               return;
            }
         }
         _loc4_ = new AutojoinChatDesc();
         _loc4_.roomName = _loc2_;
         _loc4_.roomSubject = param1.subject;
         _loc4_.roomType = param1.getRoomType();
         this.autoJoinChatList.push(_loc4_);
      }
      
      private function handleInvite(param1:InviteEvent) : void
      {
         var _loc3_:Object = null;
         if(this.quietMode)
         {
            _loc3_ = {};
            _loc3_.event = param1;
            _loc3_.handlerFunction = this.handleInvite;
            this.queueEvent(_loc3_);
            return;
         }
         var _loc2_:Object = jsonDecode(param1.reason);
         _loc2_.room = param1.room;
         this.pendingChatInvite.push(_loc2_);
         this.serviceProxy.statisticsService.getSummonerSummaryByInternalName(param1.from.node,this.onHandleChatInviteSuccess,null);
      }
      
      public function get chatRoomsStartFocused() : Boolean
      {
         return this._1136849067chatRoomsStartFocused;
      }
      
      private function listenForRosterChanges() : void
      {
         this.roster.groups.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onRosterStructureChanged);
         this.onRosterStructureChanged(null);
      }
      
      public function reconnect() : void
      {
         if(this.currentState != ONLINE)
         {
            this.serviceProxy.chatService.reconnect();
         }
      }
      
      private function onError(param1:XIFFErrorEvent) : void
      {
         this.loggingIn = false;
         var _loc2_:Object = {
            "errorCode":param1.errorCode,
            "errorFrom":param1.errorFrom,
            "errorCondition":param1.errorCondition,
            "errorMessage":param1.errorMessage,
            "errorType":param1.errorType
         };
         this.errorDataProvider.addItem(_loc2_);
         if((_loc2_.errorCode == 500) && (_loc2_.errorCondition == "resource-constraint") && (!(_loc2_.errorFrom == null)))
         {
            this.handleChatSpammer(param1);
         }
         dispatchEvent(new Event("error"));
      }
      
      public function login(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false) : void
      {
         if(!this.loggingIn)
         {
            this.loggingIn = true;
            this.isInGameOnLogin = param5;
            this.initialize();
            this.currentUserJID = new UnescapedJID(param1 + "@" + ClientConfig.JABBER_DOMAIN);
            this.currentUserDisplayName = param3;
            this._currentUserIconID = param4;
            this.serviceProxy.chatService.connect(param1,param2,this.servicesConfig.xmpp_resource,this.servicesConfig.xmpp_server_url,0,this.servicesConfig.xmpp_connection_type,this.servicesConfig.xmpp_use_ssl,this.servicesConfig.xmpp_accept_self_signed_cert);
         }
      }
      
      public function sendPresenceToAllChatRooms(param1:String, param2:PresenceStatusXML) : void
      {
         var _loc3_:ChatRoom = null;
         for each(_loc3_ in this.allOpenChatRooms)
         {
            if(_loc3_)
            {
               _loc3_.changePresence(param1,this.currentUserDisplayName,param2.getNode());
            }
         }
      }
      
      private function onPresenceHandlerTimerComplete(param1:TimerEvent) : void
      {
         this.roster.addEventListener(RosterEvent.USER_PRESENCE_ONLINE,this.presenceOnlineHandler);
      }
      
      private function initialize() : void
      {
         var _loc1_:AutojoinChatDesc = null;
         this.privacyListController.getActivePrivacyListInitialized().add(this.privacyListInitialized);
         this.buddyListModel.initialize();
         this._pendingFriendRequestTimer = new Timer(5000,1);
         this._pendingFriendRequestTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPendingFriendRequestTimerComplete);
         this._pendingFriendRequestTimer.start();
         this.setupConnectionListeners();
         this.setupRosterListeners();
         this.setupMessageListeners();
         this.inviteBayItems = new ArrayCollection();
         this.resourceManager = ResourceManager.getInstance();
         this.buddyListModelChangeWatcher = ChangeWatcher.watch(this.buddyListModel,"totalBuddyCount",this.onTotalBuddyCountChanged);
         if(this.maestroController != null)
         {
            this.gameChatController = new GameChatController(this.clientConfig,this.shellDispatcher,this.maestroController,this,this.privacyListController);
         }
         this.getGameProvider();
         if(!this._initialized)
         {
            MUC.enable();
            this._chatSystemInitializedSignal.dispatch();
            ProviderLookup.getProvider(ICrossModuleTrackerProvider,this.onGetCrossModuleTrackerProvider);
         }
         this._initialized = true;
         this.serviceProxy.chatService.addEventListener("currentStateChanged",this.onChatStateChanged);
         this.xmppSessionLogger.setChatService(this.serviceProxy.chatService);
         this.personalImTimeStamps = UserPreferencesManager.userPrefs.personalImTimeStamps;
         this.chatRoomsTimeStamp = UserPreferencesManager.userPrefs.chatRoomsTimeStamp;
         this.chatRoomsMaximized = UserPreferencesManager.userPrefs.chatRoomsMaximized;
         this.autoJoinChatList = UserPreferencesManager.userPrefs.autoJoinList;
         for each(_loc1_ in this.autoJoinChatList)
         {
            if((_loc1_.roomType == null) || (_loc1_.roomType == ""))
            {
               _loc1_.roomType = ChatRoomType.PUBLIC;
            }
         }
         this.xmppSessionLogger.startLoggingIfNecessary((!(this.clientConfig == null)) && (!this.clientConfig.enableXMPPFileLogTarget));
         ProviderLookup.publishProvider(IChatStateProvider,this);
         ProviderLookup.publishProvider(IChatRosterProvider,this);
         ProviderLookup.publishProvider(IChatBlockedRosterProvider,this);
      }
      
      private function reprioritizeRosterGroups() : void
      {
         this.roster.groups.sort.compareFunction = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.roster.groups.length)
         {
            this.roster.groups[_loc1_].priority = this.roster.groups.length - _loc1_;
            _loc1_++;
         }
         this.roster.groups.sort.compareFunction = this.buddyGroupSortFunction;
         this.roster.updateAllGroupsPriorities = true;
      }
      
      private function onAddBuddyGetInternalNameSuccess(param1:ResultEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.result as String;
         var _loc4_:AsyncToken = param1.token;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc5_:Object = _loc4_.asyncObject;
         if(_loc2_ != null)
         {
            this.checkPrivacyListAndAddBuddy(_loc2_,_loc5_.buddyName,_loc5_.groupName,_loc5_.groupPriority);
         }
         else
         {
            _loc3_ = this.resourceManager.getString("resources","chat_buddyWindow_errorOnAddBuddyAlertMessage",[_loc5_.buddyName.replace(new RegExp("<","g"),"&lt;")]);
            this.showPromptMessage("resources",_loc3_,"chat_buddyWindow_errorOnAddBuddyAlertTitle","PVP.NET","common_button_close");
         }
      }
      
      public function get currentUserJID() : UnescapedJID
      {
         return this._currentUserJID;
      }
      
      private function onPromptToAddBuddyAcknowledged(param1:AlertAction) : void
      {
         var _loc2_:Object = null;
         if(param1.affirmativeResponse)
         {
            _loc2_ = param1.data;
            this.privacyListController.unblock(_loc2_.buddyJID.bareJID);
            this.internalAddBuddy(_loc2_.buddyJID,_loc2_.internalBuddyName,_loc2_.buddyDisplayName,_loc2_.groupName,_loc2_.groupPriority);
         }
      }
      
      public function addRecentPlayers(param1:ArrayCollection) : void
      {
         if(this.buddyListModel)
         {
            this.buddyListModel.addRecentPlayers(param1);
         }
      }
      
      private function setupRosterListeners() : void
      {
         this.roster = new Roster();
         this.roster.groups.sort.compareFunction = this.buddyGroupSortFunction;
         this.roster.connection = this.serviceProxy.chatService.getConnection();
         this.roster.addEventListener(RosterEvent.SUBSCRIPTION_DENIAL,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.SUBSCRIPTION_REQUEST,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.SUBSCRIPTION_REVOCATION,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.USER_AVAILABLE,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.USER_UNAVAILABLE,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.ROSTER_LOADED,this.rosterHandler);
         this.roster.addEventListener(RosterEvent.USER_PRESENCE_UPDATED,this.handleRosterPresenceUpdated);
         this.roster.addEventListener(RosterEvent.USER_REMOVED,this.rosterHandler);
         this.presenceHandlerTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPresenceHandlerTimerComplete);
      }
      
      public function getChatOpenChatRoomViewSignal() : ISignal
      {
         return this._chatOpenChatRoomViewSignal;
      }
      
      public function set errorDataProvider(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1925355037errorDataProvider;
         if(_loc2_ !== param1)
         {
            this._1925355037errorDataProvider = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"errorDataProvider",_loc2_,param1));
         }
      }
      
      public function inviteToChatRoom(param1:Array, param2:String, param3:String, param4:String, param5:Boolean) : void
      {
         var _loc7_:RosterItemVO = null;
         var _loc8_:String = null;
         var _loc6_:Array = [];
         for each(_loc7_ in param1)
         {
            if(_loc7_.online)
            {
               _loc6_.push(_loc7_);
            }
         }
         if((_loc6_.length > 0) || (param5))
         {
            _loc8_ = this.openChatRoom(param2,param3);
            if(_loc8_ == null)
            {
               return;
            }
            if(_loc6_.length > 0)
            {
               this._chatInviteToGroupChatSignal.dispatch(_loc8_,_loc6_,param4,param3);
            }
         }
      }
      
      private function handleNormalMessage(param1:Message, param2:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:AlertAction = null;
         switch(param1.subject)
         {
            case XMPPMessageSubjectTypes.SYSTEM_ALERT:
               if((param1.from) && (param1.from.toString() == ClientConfig.JABBER_DOMAIN))
               {
                  _loc3_ = this.resourceManager.getString("resources","alert_title");
                  _loc4_ = new AlertAction(_loc3_,param1.body);
                  _loc4_.add();
               }
               break;
            case XMPPMessageSubjectTypes.GAME_MSG_OUT_OF_SYNC:
               dispatchEvent(new XMPPEvent(XMPPEvent.GAME_MSG_OUT_OF_SYNC,param1));
               break;
            case XMPPMessageSubjectTypes.AAS_NOTIFICATION:
               this.handleAASNotification(param1);
               break;
            case XMPPMessageSubjectTypes.RANKED_TEAM_UPDATE:
               dispatchEvent(new XMPPEvent(XMPPEvent.RANKED_TEAM_UPDATED,param1));
               this._chatRankedTeamUpdatedSignal.dispatch(param1);
               break;
         }
         this._chatNormalMessageReceivedSignal.dispatch(param1,param2);
      }
      
      private function onDisconnect(param1:DisconnectionEvent) : void
      {
         this.loggingIn = false;
         if(this.loggedIn)
         {
            this.showPromptMessage("resources",RiotResourceLoader.getString("chat_loading_alert_message"),"chat_loading_alert_title",RiotResourceLoader.getString("chat_loading_alert_sender"),"common_button_close");
            this.loggedIn = false;
            dispatchEvent(new Event("chatDisconnected"));
         }
      }
      
      public function getDefaultGroupName() : String
      {
         return this.buddyListModel.defaultGroupName;
      }
      
      public function set inviteBayItems(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1808108049inviteBayItems;
         if(_loc2_ !== param1)
         {
            this._1808108049inviteBayItems = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"inviteBayItems",_loc2_,param1));
         }
      }
      
      private function handleRosterPresenceUpdated(param1:RosterEvent) : void
      {
         if(param1.data is RosterItemVO)
         {
            this._rosterPresenceUpdatedSignal.dispatch(param1.data);
         }
      }
      
      private function set quietMode(param1:Boolean) : void
      {
         this._quietMode = param1;
         if(!param1)
         {
            this.dequeueEvents();
         }
      }
      
      public function getBuddyBySummonerId(param1:Number) : RosterItemVO
      {
         var _loc3_:RosterGroup = null;
         var _loc4_:RosterItemVO = null;
         var _loc2_:String = "sum" + param1;
         for each(_loc3_ in this.roster.groups)
         {
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.jid.node == _loc2_)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function closeAllChatRooms() : void
      {
         var _loc1_:ChatRoom = null;
         this._chatTracker.setChatWindowsOpenedAtOnce(this.allOpenChatRooms.length);
         for each(_loc1_ in this.allOpenChatRooms)
         {
            this.closeChatRoom(_loc1_);
         }
         this._chatCloseAllChatRoomsSignal.dispatch();
      }
      
      public function startUserPresenceDetection() : void
      {
         this.presenceController.startUserPresenceDetection();
      }
      
      public function getBuddyRemovedSignal() : ISignal
      {
         return this._buddyRemovedSignal;
      }
   }
}
