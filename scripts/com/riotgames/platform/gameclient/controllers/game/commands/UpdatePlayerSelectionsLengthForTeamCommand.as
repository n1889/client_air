package com.riotgames.platform.gameclient.controllers.game.commands
{
   import com.riotgames.platform.common.commands.CommandBase;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import mx.collections.ArrayCollection;
   
   public class UpdatePlayerSelectionsLengthForTeamCommand extends CommandBase
   {
      
      private var playerSelections:ArrayCollection;
      
      private var team:ArrayCollection;
      
      public function UpdatePlayerSelectionsLengthForTeamCommand(param1:ArrayCollection, param2:ArrayCollection)
      {
         super();
         this.team = param1;
         this.playerSelections = param2;
      }
      
      override public function execute() : void
      {
         super.execute();
         while(this.playerSelections.length < this.team.length)
         {
            this.playerSelections.addItem(new PlayerSelection(null));
         }
         onComplete(null);
         onResult(null);
      }
   }
}
