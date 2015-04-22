package com.riotgames.platform.gameclient.domain.game
{
   import mx.collections.ArrayCollection;
   
   public class GameMutator extends Object
   {
      
      public static const REROLL:String = "ReRoll";
      
      public static const BATTLE_BOOST:String = "BattleBoost";
      
      public function GameMutator()
      {
         super();
      }
      
      public static function hasMutator(param1:ArrayCollection, param2:String) : Boolean
      {
         return (!(param1 == null)) && (param1.contains(param2));
      }
   }
}
