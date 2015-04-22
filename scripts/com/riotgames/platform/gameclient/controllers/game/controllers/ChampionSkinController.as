package com.riotgames.platform.gameclient.controllers.game.controllers
{
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   import com.riotgames.platform.common.audio.AudioKeys;
   import com.riotgames.platform.common.commands.ICommand;
   import flash.utils.setTimeout;
   import flash.utils.clearTimeout;
   import com.riotgames.platform.gameclient.controllers.game.model.ChampionSelectionModel;
   import mx.logging.ILogger;
   import com.riotgames.platform.gameclient.controllers.game.builders.IChampionSelectionCommandFactory;
   import mx.logging.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ChampionSkinController extends Object
   {
      
      private var selectSkinTimeoutId:int = 0;
      
      private var requestedSkin:ChampionSkin = null;
      
      private var championSelectionModel:ChampionSelectionModel;
      
      private var logger:ILogger;
      
      private var commandFactory:IChampionSelectionCommandFactory;
      
      public function ChampionSkinController(param1:ChampionSelectionModel, param2:IChampionSelectionCommandFactory)
      {
         this.logger = Log.getLogger(getQualifiedClassName(this).replace(new RegExp("::"),"."));
         super();
         this.championSelectionModel = param1;
         this.commandFactory = param2;
      }
      
      private function isSkinSelected(param1:ChampionSkin) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(SkinsConfig.instance.isSkinLastSelected(param1))
         {
            return true;
         }
         return false;
      }
      
      public function useSkin(param1:ChampionSkin) : void
      {
         this.clearTimer();
         var _loc2_:Boolean = (param1.isAvailable()) || (this.championSelectionModel.availableForTeamSkinRental(param1.skinId));
         if((!_loc2_) || (param1.skinDisabled) || (this.isSkinSelected(param1)))
         {
            return;
         }
         var _loc3_:ICommand = this.commandFactory.getPlaySoundCommand(AudioKeys.NEW_SOUND_SKIN_SCROLL);
         _loc3_.execute();
         this.requestedSkin = null;
         this.selectSkinTimeoutId = setTimeout(this.selectSkin,750);
         if(this.selectSkinTimeoutId > 0)
         {
            this.requestedSkin = param1;
         }
      }
      
      private function onUseSkinSuccess(param1:ChampionSkin) : void
      {
         SkinsConfig.instance.setLastSelectedSkin(param1);
      }
      
      private function clearTimer() : void
      {
         if(this.selectSkinTimeoutId > 0)
         {
            clearTimeout(this.selectSkinTimeoutId);
            this.selectSkinTimeoutId = 0;
         }
      }
      
      protected function selectSkin() : void
      {
         var _loc1_:ICommand = this.commandFactory.getSkinSelectCommand(this.championSelectionModel,this.requestedSkin);
         _loc1_.addResponder(this.onUseSkinSuccess);
         _loc1_.execute();
      }
      
      function forTest_getTimoutId() : int
      {
         return this.selectSkinTimeoutId;
      }
      
      function forTest_clearTimeout() : void
      {
         this.clearTimer();
      }
      
      function forTest_getRequestedSkin() : ChampionSkin
      {
         return this.requestedSkin;
      }
   }
}
