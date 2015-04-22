package com.riotgames.platform.gameclient.Models
{
   public class PlayerSelectionEmphasis extends Object
   {
      
      public static const FADE_DIRECTION_RIGHT:String = "FADE_DIRECTION_RIGHT";
      
      public static const FADE_DIRECTION_LEFT:String = "FADE_DIRECTION_LEFT";
      
      public var championMuted:Boolean;
      
      public var fadeDirection:String;
      
      public var championHighlighted:Boolean;
      
      public var syncAnimationsOnly:Boolean;
      
      public function PlayerSelectionEmphasis()
      {
         super();
      }
      
      public static function staticEquals(param1:PlayerSelectionEmphasis, param2:PlayerSelectionEmphasis) : Boolean
      {
         if(param1 == null)
         {
            return param2 == null;
         }
         return param1.equals(param2);
      }
      
      public function equals(param1:PlayerSelectionEmphasis) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return (this.championHighlighted == param1.championHighlighted) && (this.championMuted == param1.championMuted) && (this.fadeDirection == param1.fadeDirection) && (this.syncAnimationsOnly == param1.syncAnimationsOnly);
      }
   }
}
