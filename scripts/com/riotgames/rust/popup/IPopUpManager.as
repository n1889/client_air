package com.riotgames.rust.popup
{
   import blix.view.ILayoutElement;
   import blix.view.ILayoutData;
   import blix.signals.ISignal;
   
   public interface IPopUpManager
   {
      
      function addPopUp(param1:ILayoutElement, param2:ILayoutData = null, param3:Boolean = false) : void;
      
      function removePopUp(param1:ILayoutElement) : Boolean;
      
      function removeAllPopUps() : void;
      
      function getInModalModeChanged() : ISignal;
      
      function getInModalMode() : Boolean;
   }
}
