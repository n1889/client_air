package com.riotgames.platform.gameclient.controllers.game.commands
{
   import com.riotgames.platform.common.commands.CommandBase;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.gameclient.domain.game.GameType;
   import com.riotgames.platform.gameclient.controllers.game.enums.MenuStates;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   
   public class UpdateMenuStatesCommand extends CommandBase
   {
      
      private var championSelectionModel:ChampionSelectionModel;
      
      public function UpdateMenuStatesCommand(param1:ChampionSelectionModel)
      {
         super();
         this.championSelectionModel = param1;
      }
      
      private function updateMenuStates() : void
      {
         var _loc1_:GameDTO = this.championSelectionModel.currentGame;
         if(_loc1_.gameType == GameType.TUTORIAL_GAME)
         {
            if(this.championSelectionModel.spellsActive)
            {
               this.championSelectionModel.spellsMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
            }
            else
            {
               this.championSelectionModel.spellsMenuState = MenuStates.SMALL_MENU_STATE_INACTIVE;
            }
            if(this.championSelectionModel.runesActive)
            {
               this.championSelectionModel.masteriesMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
            }
            else
            {
               this.championSelectionModel.masteriesMenuState = MenuStates.SMALL_MENU_STATE_INACTIVE;
            }
            if(this.championSelectionModel.lockInActive)
            {
               this.championSelectionModel.lockInState = MenuStates.SMALL_MENU_STATE_ACTIVE;
            }
            else
            {
               this.championSelectionModel.lockInState = MenuStates.SMALL_MENU_STATE_INACTIVE;
            }
         }
         else
         {
            if((this.championSelectionModel) && (this.championSelectionModel.currentPlayerParticipant) && (this.championSelectionModel.currentPlayerParticipant.pickMode == GameParticipant.PICK_MODE_ACTIVE))
            {
               if(this.championSelectionModel.championSelectionState == GameState.CHAMPION_SELECTION)
               {
                  this.championSelectionModel.lockInState = MenuStates.SMALL_MENU_STATE_ACTIVE;
               }
               else
               {
                  this.championSelectionModel.lockInState = MenuStates.SMALL_MENU_STATE_INACTIVE;
               }
               this.championSelectionModel.spellsMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
               this.championSelectionModel.masteriesMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
            }
            else
            {
               this.promptForSkinSelection();
               this.championSelectionModel.lockInState = MenuStates.SMALL_MENU_STATE_INACTIVE;
               this.championSelectionModel.spellsMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
               this.championSelectionModel.masteriesMenuState = MenuStates.SMALL_MENU_STATE_ACTIVE;
            }
            this.championSelectionModel.updateMainMenu();
         }
      }
      
      override public function execute() : void
      {
         super.execute();
         this.updateMenuStates();
         onComplete();
         onResult();
      }
      
      private function promptForSkinSelection() : void
      {
         if(!this.championSelectionModel.canSelectSkins())
         {
            return;
         }
         if(this.championSelectionModel.promptedForSkinSelection)
         {
            return;
         }
         this.championSelectionModel.setMainMenuToSkins();
      }
   }
}
