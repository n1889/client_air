package com.riotgames.platform.gameclient.controllers.game.commands.sound
{
   import com.riotgames.platform.common.commands.CommandBase;
   import com.riotgames.platform.gameclient.domain.gameconfig.GameTypeConfig;
   import com.riotgames.platform.gameclient.domain.game.GameType;
   import com.riotgames.platform.common.audio.AudioKeys;
   import com.riotgames.platform.gameclient.domain.game.GameMode;
   import com.riotgames.platform.gameclient.domain.game.GameMap;
   import com.riotgames.platform.common.provider.ISoundProvider;
   
   public class PlayMusicCommand extends CommandBase
   {
      
      private var gameType:String;
      
      private var gameMode:String;
      
      private var gameTypeConfig:GameTypeConfig;
      
      private var mapId:int;
      
      private var soundManager:ISoundProvider;
      
      public function PlayMusicCommand(param1:ISoundProvider, param2:String, param3:String, param4:int, param5:GameTypeConfig)
      {
         super();
         this.soundManager = param1;
         this.gameMode = param2;
         this.gameType = param3;
         this.mapId = param4;
         this.gameTypeConfig = param5;
      }
      
      override public function execute() : void
      {
         super.execute();
         this.playMusic();
         onComplete();
         onResult();
      }
      
      private function playMusic() : void
      {
         if(!this.soundManager)
         {
            return;
         }
         if(this.gameType == GameType.TUTORIAL_GAME)
         {
            this.soundManager.play(AudioKeys.MUSIC_TUTORIAL);
         }
         else if(this.isDraftPickMusic)
         {
            if((this.gameMode == GameMode.DOMINION) || (this.mapId == GameMap.CRYSTAL_SCAR_ID))
            {
               this.soundManager.play(AudioKeys.MUSIC_DOMINION_DRAFT_MODE_PATH);
            }
            else
            {
               this.soundManager.play(AudioKeys.MUSIC_DRAFT_MODE_PATH);
            }
         }
         else if((this.gameMode == GameMode.DOMINION) || (this.mapId == GameMap.CRYSTAL_SCAR_ID))
         {
            this.soundManager.play(AudioKeys.MUSIC_DOMINION_BLIND_PICK_PATH);
         }
         else if((this.gameMode == GameMode.ARAM) || (this.mapId == GameMap.HOWLING_ABYSS))
         {
            this.soundManager.play(AudioKeys.MUSIC_HOWLING_ABYSS_PATH);
         }
         else
         {
            this.soundManager.play(AudioKeys.MUSIC_BLIND_PICK_PATH);
         }
         
         
         
      }
      
      private function get isDraftPickMusic() : Boolean
      {
         if((this.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_DRAFT_MODE_SINGLE_PICK) || (this.gameTypeConfig.pickMode == GameTypeConfig.PICK_MODE_TOURNAMENT) || (this.gameTypeConfig.banTimerDuration > 0))
         {
            return true;
         }
         return false;
      }
   }
}
