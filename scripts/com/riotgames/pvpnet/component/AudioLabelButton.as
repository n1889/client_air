package com.riotgames.pvpnet.component
{
   import blix.components.button.LabelButtonX;
   import flash.events.MouseEvent;
   import com.riotgames.platform.common.provider.SoundProviderProxy;
   import blix.context.Context;
   
   public class AudioLabelButton extends LabelButtonX
   {
      
      private var _mouseDownSoundKey:String = "SOUND_MOUSE_DOWN";
      
      private var _mouseOverSoundKey:String = "SOUND_MOUSE_OVER";
      
      public function AudioLabelButton(param1:Context, param2:String = null, param3:String = null)
      {
         super(param1);
         if(param2 != null)
         {
            this._mouseOverSoundKey = param2;
         }
         if(param3 != null)
         {
            this._mouseDownSoundKey = param3;
         }
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOver);
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function onRollOver(param1:MouseEvent) : void
      {
         SoundProviderProxy.instance.play(this._mouseOverSoundKey);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         SoundProviderProxy.instance.play(this._mouseDownSoundKey);
      }
   }
}
