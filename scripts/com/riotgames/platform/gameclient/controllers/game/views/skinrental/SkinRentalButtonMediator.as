package com.riotgames.platform.gameclient.controllers.game.views.skinrental
{
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageVO;
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageType;
   import org.igniterealtime.xiff.data.im.RosterItemVO;
   import com.riotgames.platform.gameclient.chat.ChatProviderProxy;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.pvpnet.system.alerter.AlertAction;
   import flash.events.Event;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import mx.logging.ILogger;
   import com.riotgames.platform.common.services.ServiceProxy;
   import blix.signals.Signal;
   import blix.components.timeline.TimelineAnimation;
   import blix.components.tooltip.assignToolTip;
   import blix.components.tooltip.unassignToolTip;
   import com.riotgames.platform.gameclient.domain.game.TeamColors;
   import com.riotgames.platform.common.provider.SoundProviderProxy;
   import com.riotgames.platform.common.audio.AudioKeys;
   import mx.rpc.events.ResultEvent;
   import blix.signals.ISignal;
   import com.riotgames.platform.common.error.ServerError;
   import com.riotgames.platform.gameclient.exception.SkinRentalsNotAvailableException;
   import com.riotgames.platform.gameclient.exception.SkinRentalInsufficientFundsException;
   import com.riotgames.platform.gameclient.exception.SkinRentalAlreadyPurchasedException;
   import com.riotgames.platform.gameclient.exception.SkinRentalStoreException;
   import com.riotgames.platform.common.provider.InventoryProviderProxy;
   import com.riotgames.platform.gameclient.domain.TeamSkinRentalDTO;
   import com.riotgames.util.logging.ErrorUtil;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SkinRentalButtonMediator extends Object
   {
      
      private var rentalPrice:Number = NaN;
      
      private var logger:ILogger;
      
      private var onButtonUnlockFadeOut:Signal;
      
      private var model:ChampionSelectionModel;
      
      private var confirmationDialog:AlertAction;
      
      private var button:SkinRentalButton;
      
      public function SkinRentalButtonMediator(param1:SkinRentalButton, param2:ChampionSelectionModel)
      {
         this.onButtonUnlockFadeOut = new Signal();
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this.button = param1;
         this.model = param2;
         if((!(param2.teamSkinRental == null)) && (param2.teamSkinRental.unlocked))
         {
            this.unlockAllSkins();
         }
         else
         {
            param2.teamSkinRentalChanged.add(this.unlockAllSkins);
            param2.addEventListener(ChampionSelectionModel.TIME_REMAINING_SECONDS_CHANGED,this.onTimerUpdate);
            this.initializeButton();
         }
      }
      
      private function addSkinsUnlockMessageToChat(param1:String) : void
      {
         var _loc2_:ChatMessageVO = null;
         if((!(this.model.chatRoom == null)) && (!(this.model.teamSkinRental == null)) && (this.model.teamSkinRental.unlocked))
         {
            _loc2_ = new ChatMessageVO();
            _loc2_.type = ChatMessageType.USER_ALERT;
            _loc2_.rosterItem = new RosterItemVO(ChatProviderProxy.instance.currentUserJID);
            _loc2_.timeStamp = new Date();
            _loc2_.body = this.getPurchaserChatMessage(param1);
            this.model.chatRoom.addMessageToBuffer(_loc2_);
            _loc2_ = new ChatMessageVO();
            _loc2_.type = ChatMessageType.USER_ALERT;
            _loc2_.rosterItem = new RosterItemVO(ChatProviderProxy.instance.currentUserJID);
            _loc2_.timeStamp = new Date();
            _loc2_.body = RiotResourceLoader.getString("skinUnlock_chatMessage_bonusIP",null,[this.getIPReward(param1)]);
            this.model.chatRoom.addMessageToBuffer(_loc2_);
         }
      }
      
      private function onSkinRentalClicked() : void
      {
         this.cleanupConfirmationDialog();
         var _loc1_:String = RiotResourceLoader.getString("skinUnlock_confirmation_RP");
         this.confirmationDialog = new AlertAction(RiotResourceLoader.getString("skinUnlock_confirmation_title"),RiotResourceLoader.getString("skinUnlock_confirmation_description",null,[this.rentalPrice,_loc1_]));
         this.confirmationDialog.showNegative = true;
         this.confirmationDialog.setOkCancelLabels();
         this.confirmationDialog.affirmativeLabel = RiotResourceLoader.getString("skinUnlock_confirmation_unlock");
         this.confirmationDialog.getCompleted().addOnce(this.onSkinRentalConfirmationClicked);
         this.confirmationDialog.add();
      }
      
      private function getIPReward(param1:String) : int
      {
         if(this.isPurchaser(param1))
         {
            return this.model.teamSkinRental.ipRewardForPurchaser;
         }
         return this.model.teamSkinRental.ipReward;
      }
      
      private function isPurchaser(param1:String) : Boolean
      {
         return this.model.currentPlayerParticipant.getSummonerName() == param1;
      }
      
      private function onTimerUpdate(param1:Event = null) : void
      {
         var _loc2_:* = 0;
         if(this.model != null)
         {
            _loc2_ = this.model.timeRemainingSeconds;
            if(_loc2_ <= 5)
            {
               this.button.setClickable(false);
               this.cleanupConfirmationDialog();
               this.model.removeEventListener(ChampionSelectionModel.TIME_REMAINING_SECONDS_CHANGED,this.onTimerUpdate);
            }
         }
      }
      
      private function processPurchase() : void
      {
         if(this.model.teamSkinRental == null)
         {
            this.button.setText(RiotResourceLoader.getString("skinUnlock_processing"));
         }
         this.button.setClickable(false);
         ServiceProxy.instance.gameService.unlockSkinsForTeam("RP",this.onSuccess,null,this.onError);
      }
      
      private function onSkinRentalConfirmationClicked(param1:AlertAction) : void
      {
         if(param1.affirmativeResponse)
         {
            this.processPurchase();
         }
      }
      
      public function destroy() : void
      {
         this.cleanupConfirmationDialog();
         if(this.button != null)
         {
            this.button.getClicked().remove(this.onSkinRentalClicked);
            this.button.destroy();
         }
         this.model.removeEventListener(ChampionSelectionModel.TIME_REMAINING_SECONDS_CHANGED,this.onTimerUpdate);
      }
      
      private function cleanupConfirmationDialog() : void
      {
         if(this.confirmationDialog != null)
         {
            this.confirmationDialog.abort();
         }
      }
      
      private function initializeButton() : void
      {
         this.button.setClickable(false);
         this.button.setText(RiotResourceLoader.getString("skinUnlock_unlockSkins"));
         this.button.getClicked().add(this.onSkinRentalClicked);
         var _loc1_:TimelineAnimation = this.button.getTransitionAnimation("disabled","unlocked");
         _loc1_.getCompleted().add(this.onButtonUnlockFadeOut.dispatch);
         ServiceProxy.instance.gameService.getSkinUnlockPrice("RP",this.onPricingAvailable,null,this.onPriceError);
      }
      
      private function assignNoFundsToolTip() : void
      {
         var _loc1_:String = RiotResourceLoader.getString("skinUnlock_confirmation_RP");
         assignToolTip(this.button,RiotResourceLoader.getString("skinUnlock_tooltip_insufficient_RP",null,[this.rentalPrice,_loc1_]));
      }
      
      private function skinUnlockError(param1:String) : void
      {
         if(this.model.teamSkinRental == null)
         {
            this.button.setText(RiotResourceLoader.getString("skinUnlock_unlockSkins"));
         }
         this.button.setClickable(false);
         var _loc2_:AlertAction = new AlertAction(RiotResourceLoader.getString("skinUnlock_errorTitle"),param1);
         _loc2_.add();
      }
      
      private function unlockAllSkins() : void
      {
         var _loc1_:String = null;
         if((!(this.model.teamSkinRental == null)) && (this.model.teamSkinRental.unlocked) && (!(this.model.currentGame == null)) && (this.button.getEnabled()))
         {
            this.cleanupConfirmationDialog();
            unassignToolTip(this.button);
            this.button.setUnlocked(true);
            _loc1_ = "<font size=\'18\'>";
            _loc1_ = _loc1_ + RiotResourceLoader.getString("championSelection_messageCenter_skinsUnlocked",null,[this.model.teamSkinRental.summonerName,"<font color=\'" + TeamColors.FRIENDLY_TEAM_COLOR + "\'>","</font>"]);
            _loc1_ = _loc1_ + "</font>";
            this.model.stateDescriptionText = _loc1_;
            SoundProviderProxy.instance.play(AudioKeys.SOUND_UNLOCK_CELEBRATION);
            this.addSkinsUnlockMessageToChat(this.model.teamSkinRental.summonerName);
         }
      }
      
      private function onSuccess(param1:ResultEvent) : void
      {
         var _loc2_:Boolean = param1.result as Boolean;
         if(!_loc2_)
         {
            this.skinUnlockError(RiotResourceLoader.getString("skinUnlock_failure"));
         }
      }
      
      public function getOnUnlockButtonFadeOut() : ISignal
      {
         return this.onButtonUnlockFadeOut;
      }
      
      private function onError(param1:ServerError) : void
      {
         if(param1.exception is SkinRentalsNotAvailableException)
         {
            this.skinUnlockError(RiotResourceLoader.getString("SKIN-0010"));
         }
         else if(param1.exception is SkinRentalInsufficientFundsException)
         {
            this.skinUnlockError(RiotResourceLoader.getString("SKIN-0011"));
         }
         else if(param1.exception is SkinRentalAlreadyPurchasedException)
         {
            this.skinUnlockError(RiotResourceLoader.getString("SKIN-0012"));
         }
         else if(param1.exception is SkinRentalStoreException)
         {
            this.skinUnlockError(RiotResourceLoader.getString("SKIN-0013"));
         }
         else
         {
            this.skinUnlockError(RiotResourceLoader.getString("skinUnlock_failure"));
         }
         
         
         
      }
      
      private function onPricingAvailable(param1:ResultEvent) : void
      {
         this.rentalPrice = param1.result as Number;
         this.assignRPToolTip();
         if(InventoryProviderProxy.instance.getInventory().riotPoints >= this.rentalPrice)
         {
            this.button.setClickable(true);
         }
         else
         {
            this.assignNoFundsToolTip();
         }
      }
      
      private function getPurchaserChatMessage(param1:String) : String
      {
         var _loc2_:Boolean = this.model.teamSkinRental.skinUnlockMode == TeamSkinRentalDTO.SKIN_UNLOCK_MODE_SINGLE;
         if(this.isPurchaser(param1))
         {
            if(_loc2_)
            {
               return RiotResourceLoader.getString("skinUnlock_chatMessage_skinsUnlockedNotAll_you");
            }
            return RiotResourceLoader.getString("skinUnlock_chatMessage_skinsUnlocked_you");
         }
         if(_loc2_)
         {
            return RiotResourceLoader.getString("skinUnlock_chatMessage_skinsUnlockedNotAll",null,[param1]);
         }
         return RiotResourceLoader.getString("skinUnlock_chatMessage_skinsUnlocked",null,[param1]);
      }
      
      private function assignRPToolTip() : void
      {
         var _loc1_:String = RiotResourceLoader.getString("skinUnlock_confirmation_RP");
         assignToolTip(this.button,RiotResourceLoader.getString("skinUnlock_tooltip",null,[this.rentalPrice,_loc1_]));
      }
      
      private function onPriceError(param1:ServerError) : void
      {
         var _loc2_:String = null;
         this.logger.error("Could not determine skin unlock price.");
         if((!(param1 == null)) && (!(param1.faultEvent == null)))
         {
            _loc2_ = !(param1.faultEvent.fault == null)?"getSkinUnlockPrice: " + param1.faultEvent.fault.faultString:null;
            this.logger.error(ErrorUtil.makeErrorMessage(param1.faultEvent.fault,_loc2_));
         }
      }
   }
}
