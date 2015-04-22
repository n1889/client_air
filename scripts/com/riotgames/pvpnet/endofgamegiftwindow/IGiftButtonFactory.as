package com.riotgames.pvpnet.endofgamegiftwindow
{
   import com.riotgames.pvpnet.endofgamegiftwindow.views.IGiftButton;
   import flash.display.DisplayObjectContainer;
   import com.riotgames.pvpnet.endofgamegiftwindow.models.player.IPlayerSummary;
   import flash.display.DisplayObject;
   
   public interface IGiftButtonFactory
   {
      
      function getGiftButton(param1:DisplayObjectContainer, param2:int, param3:Boolean, param4:Number, param5:IPlayerSummary, param6:Number, param7:DisplayObject, param8:Function = null, param9:Function = null) : IGiftButton;
   }
}
