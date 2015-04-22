package com.riotgames.platform.gameclient.kudos.iron
{
   import com.riotgames.platform.gameclient.kudos.KudosFactoryDisabled;
   import com.riotgames.platform.gameclient.kudos.IKudosButton;
   import mx.core.UIComponent;
   import com.riotgames.platform.gameclient.domain.PlayerParticipantStatsSummary;
   import flash.display.DisplayObject;
   import blix.assets.IAssetsManager;
   
   public class IronKudosFactoryDisabled extends KudosFactoryDisabled
   {
      
      public function IronKudosFactoryDisabled()
      {
         super();
      }
      
      override public function getKudosButton(param1:UIComponent, param2:int, param3:Boolean, param4:Number, param5:PlayerParticipantStatsSummary, param6:Number, param7:DisplayObject, param8:Function = null, param9:Function = null) : IKudosButton
      {
         var _loc10_:IAssetsManager = this.context.getDependency(IAssetsManager);
         var _loc11_:IronKudosButtonDisabled = new IronKudosButtonDisabled(_loc10_);
         return _loc11_;
      }
   }
}
