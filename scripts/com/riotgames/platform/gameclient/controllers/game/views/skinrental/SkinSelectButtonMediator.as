package com.riotgames.platform.gameclient.controllers.game.views.skinrental
{
   import flash.events.Event;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import blix.signals.ISignal;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   import com.riotgames.platform.gameclient.domain.TeamSkinRentalDTO;
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageVO;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.chat.domain.ChatMessageType;
   import org.igniterealtime.xiff.data.im.RosterItemVO;
   import com.riotgames.platform.gameclient.chat.ChatProviderProxy;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import blix.components.tooltip.unassignToolTip;
   import blix.components.tooltip.assignToolTip;
   
   public class SkinSelectButtonMediator extends Object
   {
      
      private var model:ChampionSelectionModel;
      
      private var button:SkinSelectButton;
      
      public function SkinSelectButtonMediator(param1:SkinSelectButton, param2:ChampionSelectionModel)
      {
         super();
         this.button = param1;
         this.model = param2;
         param1.setText(RiotResourceLoader.getString("skinUnlock_selectSkin"));
         param1.getClicked().add(this.onSkinSelectClicked);
         assignToolTip(param1,RiotResourceLoader.getString("skinUnlock_tooltip_selectSkin"));
         param2.addEventListener(ChampionSelectionModel.MAIN_MENU_STATE_CHANGE,this.onMainMenuStateUpdated,false,0,true);
         param2.onRequestSkinSelection.add(this.onPlayerChangedSelectedSkin);
         param2.onSelectionsAssigned.add(this.onSelectionsAssigned);
         param2.teamSkinRentalChanged.add(this.onTeamSkinRentalChanged);
         param2.addEventListener(ChampionSelectionModel.SELECTED_CHAMPION_CHANGED,this.onChampionChanged,false,0,true);
         this.onMainMenuStateUpdated();
         this.addSkinUnlockMessageToChat();
         this.setButtonVisibility(this.getUnlockedChampSkin(),true);
      }
      
      private function onMainMenuStateUpdated(param1:Event = null) : void
      {
         this.setButtonVisibility(this.getUnlockedChampSkin(),!this.model.isChampionsMainMenuState);
      }
      
      private function getUnlockedChampSkin() : ChampionSkin
      {
         var _loc1_:* = NaN;
         var _loc2_:ChampionSkin = null;
         if((this.model.teamSkinRental == null) || (this.model.currentPlayerSelection == null) || (this.model.currentPlayerSelection.champion == null))
         {
            return null;
         }
         for each(_loc1_ in this.model.teamSkinRental.availableSkins)
         {
            for each(_loc2_ in this.model.currentPlayerSelection.champion.championSkins)
            {
               if(_loc2_.skinId == _loc1_)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      private function setButtonVisibility(param1:ChampionSkin, param2:Boolean) : *
      {
         this.button.setVisible((!(param1 == null)) && (param2));
      }
      
      private function onPlayerChangedSelectedSkin(param1:ISignal, param2:ChampionSkin) : void
      {
         this.setButtonEnablement(param2);
      }
      
      private function onSkinSelectClicked() : void
      {
         var _loc1_:ChampionSkin = null;
         if(this.model.currentGame != null)
         {
            _loc1_ = this.getUnlockedChampSkin();
            if(_loc1_ != null)
            {
               this.model.requestNavigateToSkin(_loc1_);
            }
         }
      }
      
      private function onSelectionsAssigned(param1:ISignal) : void
      {
         var _loc2_:ChampionSkin = null;
         if((!(this.model.selectedChampion == null)) && (!(this.model.selectedChampion.champion == null)))
         {
            _loc2_ = SkinsConfig.instance.getLastSelectedSkinForChampion(this.model.selectedChampion.champion);
            this.setButtonEnablement(_loc2_);
            this.setButtonVisibility(this.getUnlockedChampSkin(),true);
         }
      }
      
      private function setButtonEnablement(param1:ChampionSkin) : *
      {
         if((this.model.teamSkinRental == null) || (this.model.teamSkinRental.availableSkins == null))
         {
            return;
         }
         this.button.setEnabled(!this.model.teamSkinRental.availableSkins.contains(param1.skinId));
      }
      
      private function onTeamSkinRentalChanged(param1:ISignal, param2:TeamSkinRentalDTO) : void
      {
         this.onSelectionsAssigned(param1);
         this.addSkinUnlockMessageToChat();
      }
      
      private function addSkinUnlockMessageToChat() : void
      {
         var _loc2_:ChatMessageVO = null;
         if((this.model.currentGame == null) || (!(this.model.championSelectionState == GameState.POST_CHAMPION_SELECTION)))
         {
            return;
         }
         var _loc1_:ChampionSkin = this.getUnlockedChampSkin();
         if((!(_loc1_ == null)) && (!(this.model.chatRoom == null)))
         {
            _loc2_ = new ChatMessageVO();
            _loc2_.type = ChatMessageType.USER_ALERT;
            _loc2_.rosterItem = new RosterItemVO(ChatProviderProxy.instance.currentUserJID);
            _loc2_.timeStamp = new Date();
            _loc2_.body = RiotResourceLoader.getString("skinUnlock_chatMessage_singleSkinUnlocked",null,[_loc1_.getLocalizedSkinName()]);
            this.model.chatRoom.addMessageToBuffer(_loc2_);
         }
      }
      
      public function destroy() : void
      {
         if(this.model != null)
         {
            this.model.removeEventListener(ChampionSelectionModel.SELECTED_CHAMPION_CHANGED,this.onChampionChanged);
            this.model.removeEventListener(ChampionSelectionModel.MAIN_MENU_STATE_CHANGE,this.onMainMenuStateUpdated);
            this.model.onRequestSkinSelection.remove(this.onPlayerChangedSelectedSkin);
            this.model.onSelectionsAssigned.remove(this.onSelectionsAssigned);
            this.model.teamSkinRentalChanged.remove(this.onTeamSkinRentalChanged);
         }
         if(this.button != null)
         {
            unassignToolTip(this.button);
            this.button.destroy();
         }
      }
      
      private function onChampionChanged(param1:Event) : void
      {
         this.addSkinUnlockMessageToChat();
      }
   }
}
