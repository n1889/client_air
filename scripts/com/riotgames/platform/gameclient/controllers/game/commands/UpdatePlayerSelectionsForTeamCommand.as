package com.riotgames.platform.gameclient.controllers.game.commands
{
   import com.riotgames.platform.common.commands.CommandBase;
   import mx.collections.ArrayCollection;
   import com.riotgames.platform.gameclient.controllers.game.model.ParticipantChampionListView;
   import com.riotgames.platform.gameclient.domain.GameDTO;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import com.riotgames.platform.gameclient.domain.GameParticipant;
   import com.riotgames.pvpnet.system.game.GameProviderProxy;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.platform.gameclient.domain.PlayerChampionSelectionDTO;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.PlayerParticipant;
   import com.riotgames.platform.gameclient.domain.game.GameState;
   import com.riotgames.platform.gameclient.domain.Champion;
   import com.riotgames.platform.gameclient.domain.game.ParticipantChampionSelection;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.platform.common.provider.IInventory;
   import flash.utils.Dictionary;
   import com.riotgames.platform.gameclient.domain.BotParticipant;
   import com.riotgames.platform.gameclient.controllers.game.views.voting.oneteam.VotePlayerSelectionUtils;
   
   public class UpdatePlayerSelectionsForTeamCommand extends CommandBase
   {
      
      private var currentPlayerSelections:ArrayCollection;
      
      private var participantChampionSelections:ParticipantChampionListView;
      
      private var currentGame:GameDTO;
      
      private var team:ArrayCollection;
      
      private var oneTeamSelectionVotes:ArrayCollection;
      
      private var isOccludingActivePickTurns:Boolean;
      
      private var inventory:IInventory;
      
      private var gameTypeConfig:GameTypeConfig;
      
      private var selectionsDTOCollection:ArrayCollection;
      
      private var shouldShowSpells:Boolean;
      
      private var gameState:String;
      
      public function UpdatePlayerSelectionsForTeamCommand(param1:ParticipantChampionListView, param2:GameDTO, param3:ArrayCollection, param4:ArrayCollection, param5:IInventory, param6:String, param7:GameTypeConfig, param8:Boolean, param9:Boolean)
      {
         super();
         this.participantChampionSelections = param1;
         this.currentGame = param2;
         this.team = param3;
         this.currentPlayerSelections = param4;
         this.selectionsDTOCollection = param2.playerChampionSelections;
         this.gameTypeConfig = param7;
         this.shouldShowSpells = param9;
         this.inventory = param5;
         this.gameState = param6;
         this.isOccludingActivePickTurns = param8;
      }
      
      private function updatePlayerSelectionState(param1:PlayerSelection, param2:GameParticipant) : void
      {
         var _loc3_:GameFlowVariant = GameProviderProxy.instance.getCurrentGameFlowVariant();
         if(_loc3_ != null)
         {
            _loc3_.setPlayerSelectionState(param1,this.currentGame,param2,this.isOccludingActivePickTurns);
         }
         param1.participant = param2;
         if(param2.hasOwnProperty("clientInSynch"))
         {
            param1.isInSync = param2["clientInSynch"];
         }
         else
         {
            param1.isInSync = true;
         }
      }
      
      private function updatePlayerSelectionFromDTO(param1:PlayerSelection, param2:PlayerChampionSelectionDTO, param3:GameParticipant, param4:GameTypeConfig, param5:Boolean) : void
      {
         this.updateSelectedChampion(param1,param2,param4);
         var _loc6_:PlayerParticipant = param3 as PlayerParticipant;
         if(_loc6_)
         {
            param1.selectionStateText = this.getSelectionText(_loc6_,param4);
            if((this.gameState == GameState.CHAMPION_SELECTION) && (!(param4 == null)) && (param4.id == GameTypeConfig.PICK_ID_ONE_TEAM_VOTE_DRAFT))
            {
               this.oneTeamSelectionVotes.addItem(param1);
            }
         }
         else
         {
            param1.selectionStateText = "";
         }
         if((_loc6_ && !_loc6_.isMe && param5) && (!(this.gameState == GameState.PRE_CHAMPION_SELECTION)) && (!(param1.champion == null)))
         {
            param1.spell1 = this.inventory.spellDictionary[param2.spell1Id];
            param1.spell2 = this.inventory.spellDictionary[param2.spell2Id];
         }
      }
      
      private function updateSelectedChampion(param1:PlayerSelection, param2:PlayerChampionSelectionDTO, param3:GameTypeConfig) : void
      {
         var _loc4_:Champion = null;
         var _loc5_:ParticipantChampionSelection = this.participantChampionSelections.getSelectionByChampionId(param2.championId);
         if((!(_loc5_ == null)) && (!(_loc5_.champion == null)))
         {
            _loc4_ = _loc5_.champion;
         }
         else
         {
            _loc4_ = this.inventory.championIdMapping[param2.championId];
         }
         this.updateDefaultChampionVisual(param1,_loc4_,param3);
         param1.champion = _loc4_;
      }
      
      private function updateDefaultChampionVisual(param1:PlayerSelection, param2:Champion, param3:GameTypeConfig) : void
      {
         if((!(param3 == null)) && (param3.id == GameTypeConfig.PICK_ID_ALL_TEAM_VOTE_PICK))
         {
            param1.defaultChampionVisualName = param2 == null?PlayerSelection.OBSCURED_VISUAL_NAME:null;
         }
         else
         {
            param1.defaultChampionVisualName = null;
         }
      }
      
      private function updatePlayerSelection(param1:GameParticipant, param2:PlayerSelection) : void
      {
         var _loc3_:PlayerChampionSelectionDTO = null;
         this.updatePlayerSelectionState(param2,param1);
         for each(_loc3_ in this.selectionsDTOCollection)
         {
            if(_loc3_.summonerInternalName == param1.summonerInternalName)
            {
               this.updatePlayerSelectionFromDTO(param2,_loc3_,param1,this.gameTypeConfig,this.shouldShowSpells);
               break;
            }
         }
      }
      
      private function getSelectionText(param1:PlayerParticipant, param2:GameTypeConfig) : String
      {
         var _loc3_:String = "";
         if(param1.pickMode == GameParticipant.PICK_MODE_ACTIVE)
         {
            if(this.gameState == GameState.PRE_CHAMPION_SELECTION)
            {
               _loc3_ = RiotResourceLoader.getString("champSelect_banning");
               if(_loc3_ == null)
               {
                  _loc3_ = "Banning";
               }
            }
            else if(!this.isOccludingActivePickTurns)
            {
               _loc3_ = (!(param2 == null)) && (param2.votePickGameTypeConfig)?RiotResourceLoader.getString("champSelect_voting"):RiotResourceLoader.getString("champSelect_picking");
               if(_loc3_ == null)
               {
                  _loc3_ = "Picking";
               }
            }
            
         }
         return _loc3_;
      }
      
      override public function execute() : void
      {
         super.execute();
         var _loc1_:PlayerSelection = this.updatePlayerSelectionsForTeam();
         onComplete(null);
         onResult(_loc1_);
      }
      
      private function updatePlayerSelectionsForTeam() : PlayerSelection
      {
         var _loc1_:GameParticipant = null;
         var _loc2_:PlayerParticipant = null;
         var _loc3_:PlayerSelection = null;
         var _loc4_:PlayerParticipant = null;
         var _loc5_:PlayerSelection = null;
         var _loc7_:* = false;
         var _loc8_:Dictionary = null;
         var _loc9_:Object = null;
         var _loc10_:* = 0;
         this.oneTeamSelectionVotes = new ArrayCollection();
         var _loc6_:int = 0;
         while(_loc6_ < this.team.length)
         {
            _loc1_ = this.team.getItemAt(_loc6_) as GameParticipant;
            _loc7_ = false;
            for each(_loc3_ in this.currentPlayerSelections)
            {
               _loc2_ = _loc1_ as PlayerParticipant;
               _loc4_ = _loc3_.participant as PlayerParticipant;
               if((_loc2_) && (_loc4_) && (_loc2_.accountId == _loc4_.accountId))
               {
                  this.updatePlayerSelection(_loc1_,_loc3_);
                  if(_loc1_.isMe)
                  {
                     _loc5_ = _loc3_;
                  }
                  _loc7_ = true;
                  break;
               }
               if((_loc1_ is BotParticipant) && (_loc4_) && (_loc1_.summonerInternalName == _loc3_.participant.summonerInternalName))
               {
                  this.updatePlayerSelection(_loc1_,_loc3_);
                  _loc7_ = true;
                  break;
               }
            }
            if(!_loc7_)
            {
               _loc3_ = this.currentPlayerSelections.getItemAt(_loc6_) as PlayerSelection;
               _loc3_.participant = _loc1_;
               this.updatePlayerSelection(_loc1_,_loc3_);
               if(_loc1_.isMe)
               {
                  _loc5_ = _loc3_;
               }
               _loc7_ = true;
            }
            _loc3_.gameState = this.gameState;
            _loc6_++;
         }
         if((!(this.oneTeamSelectionVotes == null)) && (this.oneTeamSelectionVotes.length > 0))
         {
            _loc8_ = VotePlayerSelectionUtils.getVoteChancesForPlayerSelections(this.oneTeamSelectionVotes);
            for(_loc9_ in _loc8_)
            {
               _loc10_ = int(_loc8_[_loc9_]);
               PlayerSelection(_loc9_).selectionStateText = _loc10_ == 100?RiotResourceLoader.getString("champSelect_voting_majority"):RiotResourceLoader.getString("champSelect_voting_percent",null,[_loc10_]);
            }
         }
         return _loc5_;
      }
   }
}
