package com.riotgames.platform.gameclient.championmastery
{
   import flash.events.IEventDispatcher;
   import mx.events.PropertyChangeEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class ChampionMasteryChangeNotificationDTO extends Object implements IEventDispatcher
   {
      
      private var _487082538championPointsGained:Number;
      
      private var _502054479championPointsUntilNextLevelAfterGame:Number;
      
      private var _224868317championPointsBeforeGame:Number;
      
      private var _1834107517levelUpList:Array;
      
      private var _269815183championPointsSinceLastLevelBeforeGame:Number;
      
      private var _1262938093championPointsGainedIndividualContribution:Number;
      
      private var _1537709924championId:Number;
      
      private var _1253236563gameId:Number;
      
      private var _1879273436playerId:Number;
      
      private var _bindingEventDispatcher:EventDispatcher;
      
      private var _16695820isChampionLevelUp:Boolean;
      
      private var _1677241808championPointsUntilNextLevelBeforeGame:Number;
      
      private var _219961577bonusChampionPointsGained:Number;
      
      private var _201916261championLevel:Number;
      
      private var _534894966playerGrade:String;
      
      public function ChampionMasteryChangeNotificationDTO()
      {
         this._1834107517levelUpList = new Array();
         this._bindingEventDispatcher = new EventDispatcher(IEventDispatcher(this));
         super();
      }
      
      public static function fromObject(param1:Object) : ChampionMasteryChangeNotificationDTO
      {
         var _loc3_:* = undefined;
         if(!param1)
         {
            return null;
         }
         var _loc2_:ChampionMasteryChangeNotificationDTO = new ChampionMasteryChangeNotificationDTO();
         if(param1.hasOwnProperty("gameId"))
         {
            _loc2_.gameId = Number(param1["gameId"]);
         }
         if(param1.hasOwnProperty("playerId"))
         {
            _loc2_.playerId = Number(param1["playerId"]);
         }
         if(param1.hasOwnProperty("championId"))
         {
            _loc2_.championId = Number(param1["championId"]);
         }
         if(param1.hasOwnProperty("championLevel"))
         {
            _loc2_.championLevel = Number(param1["championLevel"]);
         }
         if(param1.hasOwnProperty("championPointsBeforeGame"))
         {
            _loc2_.championPointsBeforeGame = Number(param1["championPointsBeforeGame"]);
         }
         if(param1.hasOwnProperty("championPointsGained"))
         {
            _loc2_.championPointsGained = Number(param1["championPointsGained"]);
         }
         if(param1.hasOwnProperty("championPointsGainedIndividualContribution"))
         {
            _loc2_.championPointsGainedIndividualContribution = Number(param1["championPointsGainedIndividualContribution"]);
         }
         if(param1.hasOwnProperty("bonusChampionPointsGained"))
         {
            _loc2_.bonusChampionPointsGained = Number(param1["bonusChampionPointsGained"]);
         }
         if(param1.hasOwnProperty("playerGrade"))
         {
            _loc2_.playerGrade = String(param1["playerGrade"]);
         }
         if(param1.hasOwnProperty("championPointsSinceLastLevelBeforeGame"))
         {
            _loc2_.championPointsSinceLastLevelBeforeGame = Number(param1["championPointsSinceLastLevelBeforeGame"]);
         }
         if(param1.hasOwnProperty("championPointsUntilNextLevelBeforeGame"))
         {
            _loc2_.championPointsUntilNextLevelBeforeGame = Number(param1["championPointsUntilNextLevelBeforeGame"]);
         }
         if(param1.hasOwnProperty("championPointsUntilNextLevelAfterGame"))
         {
            _loc2_.championPointsUntilNextLevelAfterGame = Number(param1["championPointsUntilNextLevelAfterGame"]);
         }
         if(param1.hasOwnProperty("championLevelUp"))
         {
            _loc2_.isChampionLevelUp = Boolean(param1["championLevelUp"]);
         }
         if(param1.hasOwnProperty("levelUpList"))
         {
            for each(_loc3_ in param1["levelUpList"])
            {
               _loc2_.levelUpList.push(ChampionMasteryMiniDTO.fromObject(_loc3_));
            }
         }
         return _loc2_;
      }
      
      public function set levelUpList(param1:Array) : void
      {
         var _loc2_:Object = this._1834107517levelUpList;
         if(_loc2_ !== param1)
         {
            this._1834107517levelUpList = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"levelUpList",_loc2_,param1));
         }
      }
      
      public function get levelUpList() : Array
      {
         return this._1834107517levelUpList;
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.willTrigger(param1);
      }
      
      public function get championPointsGainedIndividualContribution() : Number
      {
         return this._1262938093championPointsGainedIndividualContribution;
      }
      
      public function set isChampionLevelUp(param1:Boolean) : void
      {
         var _loc2_:Object = this._16695820isChampionLevelUp;
         if(_loc2_ !== param1)
         {
            this._16695820isChampionLevelUp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isChampionLevelUp",_loc2_,param1));
         }
      }
      
      public function get championLevel() : Number
      {
         return this._201916261championLevel;
      }
      
      public function set championPointsUntilNextLevelAfterGame(param1:Number) : void
      {
         var _loc2_:Object = this._502054479championPointsUntilNextLevelAfterGame;
         if(_loc2_ !== param1)
         {
            this._502054479championPointsUntilNextLevelAfterGame = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsUntilNextLevelAfterGame",_loc2_,param1));
         }
      }
      
      public function get isChampionLevelUp() : Boolean
      {
         return this._16695820isChampionLevelUp;
      }
      
      public function set championPointsGainedIndividualContribution(param1:Number) : void
      {
         var _loc2_:Object = this._1262938093championPointsGainedIndividualContribution;
         if(_loc2_ !== param1)
         {
            this._1262938093championPointsGainedIndividualContribution = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsGainedIndividualContribution",_loc2_,param1));
         }
      }
      
      public function set championPointsUntilNextLevelBeforeGame(param1:Number) : void
      {
         var _loc2_:Object = this._1677241808championPointsUntilNextLevelBeforeGame;
         if(_loc2_ !== param1)
         {
            this._1677241808championPointsUntilNextLevelBeforeGame = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsUntilNextLevelBeforeGame",_loc2_,param1));
         }
      }
      
      public function get championPointsGained() : Number
      {
         return this._487082538championPointsGained;
      }
      
      public function get gameId() : Number
      {
         return this._1253236563gameId;
      }
      
      public function set championLevel(param1:Number) : void
      {
         var _loc2_:Object = this._201916261championLevel;
         if(_loc2_ !== param1)
         {
            this._201916261championLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championLevel",_loc2_,param1));
         }
      }
      
      public function set playerId(param1:Number) : void
      {
         var _loc2_:Object = this._1879273436playerId;
         if(_loc2_ !== param1)
         {
            this._1879273436playerId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerId",_loc2_,param1));
         }
      }
      
      public function set championPointsBeforeGame(param1:Number) : void
      {
         var _loc2_:Object = this._224868317championPointsBeforeGame;
         if(_loc2_ !== param1)
         {
            this._224868317championPointsBeforeGame = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsBeforeGame",_loc2_,param1));
         }
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._bindingEventDispatcher.dispatchEvent(param1);
      }
      
      public function get championPointsUntilNextLevelBeforeGame() : Number
      {
         return this._1677241808championPointsUntilNextLevelBeforeGame;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this._bindingEventDispatcher.removeEventListener(param1,param2,param3);
      }
      
      public function set bonusChampionPointsGained(param1:Number) : void
      {
         var _loc2_:Object = this._219961577bonusChampionPointsGained;
         if(_loc2_ !== param1)
         {
            this._219961577bonusChampionPointsGained = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bonusChampionPointsGained",_loc2_,param1));
         }
      }
      
      public function set championPointsGained(param1:Number) : void
      {
         var _loc2_:Object = this._487082538championPointsGained;
         if(_loc2_ !== param1)
         {
            this._487082538championPointsGained = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsGained",_loc2_,param1));
         }
      }
      
      public function get championPointsUntilNextLevelAfterGame() : Number
      {
         return this._502054479championPointsUntilNextLevelAfterGame;
      }
      
      public function set championId(param1:Number) : void
      {
         var _loc2_:Object = this._1537709924championId;
         if(_loc2_ !== param1)
         {
            this._1537709924championId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championId",_loc2_,param1));
         }
      }
      
      public function get playerId() : Number
      {
         return this._1879273436playerId;
      }
      
      public function get championPointsBeforeGame() : Number
      {
         return this._224868317championPointsBeforeGame;
      }
      
      public function set gameId(param1:Number) : void
      {
         var _loc2_:Object = this._1253236563gameId;
         if(_loc2_ !== param1)
         {
            this._1253236563gameId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gameId",_loc2_,param1));
         }
      }
      
      public function set championPointsSinceLastLevelBeforeGame(param1:Number) : void
      {
         var _loc2_:Object = this._269815183championPointsSinceLastLevelBeforeGame;
         if(_loc2_ !== param1)
         {
            this._269815183championPointsSinceLastLevelBeforeGame = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championPointsSinceLastLevelBeforeGame",_loc2_,param1));
         }
      }
      
      public function getTotalPointsEarned() : Number
      {
         return this.championPointsGained + this.bonusChampionPointsGained;
      }
      
      public function get bonusChampionPointsGained() : Number
      {
         return this._219961577bonusChampionPointsGained;
      }
      
      public function get championId() : Number
      {
         return this._1537709924championId;
      }
      
      public function set playerGrade(param1:String) : void
      {
         var _loc2_:Object = this._534894966playerGrade;
         if(_loc2_ !== param1)
         {
            this._534894966playerGrade = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playerGrade",_loc2_,param1));
         }
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this._bindingEventDispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function get championPointsSinceLastLevelBeforeGame() : Number
      {
         return this._269815183championPointsSinceLastLevelBeforeGame;
      }
      
      public function toString() : String
      {
         var _loc2_:ChampionMasteryMiniDTO = null;
         var _loc1_:String = "";
         _loc1_ = _loc1_ + ("GameId = " + this.gameId);
         _loc1_ = _loc1_ + (", PlayerId = " + this.playerId);
         _loc1_ = _loc1_ + (", championId = " + this.championId);
         _loc1_ = _loc1_ + (", championLevel = " + this.championLevel);
         _loc1_ = _loc1_ + (", championPointsBeforeGame = " + this.championPointsBeforeGame);
         _loc1_ = _loc1_ + (", championPointsGained = " + this.championPointsGained);
         _loc1_ = _loc1_ + (", championPointsGainedIndividualContribution = " + this.championPointsGainedIndividualContribution);
         _loc1_ = _loc1_ + (", bonusChampionPointsGained = " + this.bonusChampionPointsGained);
         _loc1_ = _loc1_ + (", playerGrade = " + this.playerGrade);
         _loc1_ = _loc1_ + (", championPointsSinceLastLevelBeforeGame = " + this.championPointsSinceLastLevelBeforeGame);
         _loc1_ = _loc1_ + (", championPointsUntilNextLevelBeforeGame = " + this.championPointsUntilNextLevelBeforeGame);
         _loc1_ = _loc1_ + (", championPointsUntilNextLevelAfterGame = " + this.championPointsUntilNextLevelAfterGame);
         _loc1_ = _loc1_ + (", isChampionLevelUp = " + this.isChampionLevelUp);
         _loc1_ = _loc1_ + ", levelUpList = [";
         for each(_loc2_ in this.levelUpList)
         {
            _loc1_ = _loc1_ + (" {" + _loc2_.toString() + "}");
         }
         _loc1_ = _loc1_ + " ]";
         return _loc1_;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._bindingEventDispatcher.hasEventListener(param1);
      }
      
      public function get playerGrade() : String
      {
         return this._534894966playerGrade;
      }
   }
}
