package com.riotgames.pvpnet.game.controllers.contextalert
{
   import com.riotgames.platform.common.provider.IChromeContextAlertProvider;
   import com.riotgames.platform.gameclient.contextAlert.AlertParameters;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.domain.inventory.ActiveBoosts;
   import com.riotgames.platform.gameclient.domain.game.GameQueueConfig;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.platform.gameclient.domain.Spell;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.pvpnet.game.variants.GameFlowVariantFactory;
   import com.riotgames.pvpnet.system.leagues.configuration.ChampionMasteryConfig;
   import com.riotgames.platform.gameclient.contextAlert.AlertLocation;
   import com.riotgames.platform.common.provider.ChromeContextAlertProviderProxy;
   
   public class EndOfGameAlertParser extends Object
   {
      
      private static const MESSAGE_SEPARATOR:String = "<br />";
      
      private var chromeContextAlertController:IChromeContextAlertProvider;
      
      var rewardsParams:AlertParameters;
      
      public function EndOfGameAlertParser(param1:IChromeContextAlertProvider)
      {
         super();
         this.chromeContextAlertController = param1;
      }
      
      public function runEndOfGameScript(param1:int, param2:Boolean, param3:ArrayCollection, param4:ActiveBoosts, param5:ArrayCollection, param6:int, param7:Number, param8:Boolean = false) : void
      {
         var _loc10_:Vector.<String> = null;
         var _loc12_:ArrayCollection = null;
         var _loc13_:GameQueueConfig = null;
         var _loc14_:GameFlowVariant = null;
         var _loc15_:Spell = null;
         var _loc9_:Vector.<String> = new Vector.<String>();
         var _loc11_:Boolean = false;
         if(param2)
         {
            if(param6 > 0)
            {
               _loc9_.push(RiotResourceLoader.getString("rp_reward_alert_message","You have been granted RP!",[param1,param6]));
            }
            if((param7 > 0) && (param7 == param1 - 1))
            {
               _loc9_.push(RiotResourceLoader.getString("switch_new_to_free_champion_rotation_alert_message"));
            }
            if((param5) && (param5.length > 0))
            {
               _loc10_ = new Vector.<String>();
               _loc12_ = new ArrayCollection();
               for each(_loc13_ in param5)
               {
                  _loc14_ = GameFlowVariantFactory.instance.getVariant(_loc13_.gameMutators,_loc13_.gameMode);
                  if((!_loc12_.contains(_loc13_.gameMode)) && (_loc14_.showsEndOfGameLevelUpAlertForUnlockedGameMode()))
                  {
                     _loc10_.push(RiotResourceLoader.getString("levelup_alert_newQueue_" + _loc13_.gameMode));
                     _loc12_.addItem(_loc13_.gameMode);
                  }
               }
               _loc9_.push(_loc10_.join(MESSAGE_SEPARATOR));
            }
            _loc10_ = new Vector.<String>();
            if(_loc9_.length > 0)
            {
               _loc10_.push(RiotResourceLoader.getString("levelup_alert_message_also","You\'ve also unlocked"));
            }
            else
            {
               _loc10_.push(RiotResourceLoader.getString("levelup_alert_message","You\'ve unlocked"));
            }
            _loc10_.push(RiotResourceLoader.getString("levelup_alert_newRune"));
            _loc10_.push(RiotResourceLoader.getString("levelup_alert_newMastery"));
            if((param3) && (param3.length > 0))
            {
               for each(_loc15_ in param3)
               {
                  _loc10_.push(RiotResourceLoader.getString("levelup_alert_newSpell",null,[_loc15_.displayName]));
               }
            }
            _loc9_.push(_loc10_.join(MESSAGE_SEPARATOR));
            if(param1 === 5)
            {
               _loc11_ = true;
            }
         }
         if(_loc9_.length > 0)
         {
            this.rewardsParams = new AlertParameters();
            this.rewardsParams.requiresThickChromeState = false;
            if(ChampionMasteryConfig.isEndOfGameEnabled())
            {
               this.rewardsParams.location = param8?AlertLocation.EOG_REWARDS_INFO_CM:AlertLocation.EOG_REWARDS_INFO_CM_R;
            }
            else
            {
               this.rewardsParams.location = AlertLocation.EOG_REWARDS_INFO;
            }
            if(param2)
            {
               this.rewardsParams.title = RiotResourceLoader.getString("levelup_alert_title",null,[param1]);
            }
            else
            {
               this.rewardsParams.title = RiotResourceLoader.getString("eog_rewards_title_nolevel");
            }
            this.rewardsParams.message = _loc9_.join(MESSAGE_SEPARATOR + MESSAGE_SEPARATOR);
            this.chromeContextAlertController.showAlertForParameters(this.rewardsParams);
         }
         else
         {
            this.rewardsParams = null;
         }
         if(_loc11_)
         {
            this.showChatMinimumLvMetAlert();
         }
         this.chromeContextAlertController.runExpiredBoostScript(param4);
      }
      
      public function showRewardsAlert() : void
      {
         if(this.hasRewards())
         {
            ChromeContextAlertProviderProxy.instance.showAlertForParameters(this.rewardsParams);
         }
      }
      
      public function hasRewards() : Boolean
      {
         return !(this.rewardsParams === null);
      }
      
      public function removeAlert() : void
      {
         if(this.hasRewards())
         {
            ChromeContextAlertProviderProxy.instance.removeAlert(this.rewardsParams);
         }
      }
      
      private function showChatMinimumLvMetAlert() : void
      {
         var _loc1_:AlertParameters = new AlertParameters();
         _loc1_.location = AlertLocation.CHAT_ROOMS_BUTTON;
         _loc1_.title = null;
         _loc1_.message = RiotResourceLoader.getString("global_chat_enabled_alert_message");
         this.chromeContextAlertController.showAlertForParameters(_loc1_);
      }
   }
}
