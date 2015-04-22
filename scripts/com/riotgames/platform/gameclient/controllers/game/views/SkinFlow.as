package com.riotgames.platform.gameclient.controllers.game.views
{
   import com.dougmccune.containers.CoverFlowContainer;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import mx.core.IDataRenderer;
   import blix.signals.Signal;
   import flash.display.DisplayObject;
   import blix.signals.ISignal;
   import flash.events.Event;
   import org.papervision3d.objects.DisplayObject3D;
   
   public class SkinFlow extends CoverFlowContainer
   {
      
      public static const SKIN_FLOW_FORCE_UPDATE_EVENT:String = "forceUpdateEvent";
      
      private var _selectedIndexChange:Signal;
      
      private var _isInitialState:Boolean = true;
      
      public function SkinFlow()
      {
         this._selectedIndexChange = new Signal();
         super();
      }
      
      public function get selectedSkin() : ChampionSkin
      {
         if((!(this.selectedChild == null)) && (!(IDataRenderer(this.selectedChild).data == null)))
         {
            return IDataRenderer(this.selectedChild).data as ChampionSkin;
         }
         return null;
      }
      
      public function initializeSelectedIndex(param1:int) : void
      {
         this._isInitialState = true;
         super.selectedIndex = param1;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         super.addChild(param1);
         param1.addEventListener(SKIN_FLOW_FORCE_UPDATE_EVENT,this.onChildForceUpdate);
         return param1;
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         if(this.selectedIndex != param1)
         {
            this._isInitialState = false;
            super.selectedIndex = param1;
            this._selectedIndexChange.dispatch(this._selectedIndexChange,param1);
         }
      }
      
      public function getSelectedIndexChange() : ISignal
      {
         return this._selectedIndexChange;
      }
      
      public function get isAnimating() : Boolean
      {
         if(selectedChild)
         {
            return !selectedChild.visible;
         }
         return false;
      }
      
      public function get isInitialState() : Boolean
      {
         return this._isInitialState;
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         param1.removeEventListener(SKIN_FLOW_FORCE_UPDATE_EVENT,this.onChildForceUpdate);
         return super.removeChild(param1);
      }
      
      private function onChildForceUpdate(param1:Event) : void
      {
         var _loc3_:DisplayObject3D = null;
         var _loc2_:DisplayObject = param1.currentTarget as DisplayObject;
         if(_loc2_)
         {
            _loc3_ = lookupPlane(_loc2_);
            if((_loc3_) && (_loc3_.material))
            {
               _loc3_.material.updateBitmap();
            }
         }
      }
   }
}
