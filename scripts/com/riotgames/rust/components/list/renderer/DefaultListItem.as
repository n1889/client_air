package com.riotgames.rust.components.list.renderer
{
   import blix.components.button.LabelButtonX;
   import blix.components.renderer.IDataRenderer;
   import com.riotgames.rust.components.list.IListSelectable;
   import blix.signals.Signal;
   import flash.events.MouseEvent;
   import blix.assets.proxy.SpriteProxy;
   import blix.assets.proxy.DisplayObjectProxy;
   import blix.signals.ISignal;
   import blix.context.IContext;
   
   public class DefaultListItem extends LabelButtonX implements IDataRenderer, IListSelectable
   {
      
      protected var _selectSignal:Signal;
      
      protected var _toggleSelectSignal:Signal;
      
      protected var _selectToSignal:Signal;
      
      public function DefaultListItem(param1:IContext)
      {
         this._selectSignal = new Signal();
         this._toggleSelectSignal = new Signal();
         this._selectToSignal = new Signal();
         super(param1);
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      }
      
      override public function getData() : *
      {
         return _data;
      }
      
      override public function setData(param1:*) : void
      {
         _data = param1;
         if(_data != null)
         {
            this.updateText();
         }
         else
         {
            setText("");
         }
      }
      
      protected function updateText() : void
      {
         var _loc1_:ILabelFieldContext = null;
         if(_data is String)
         {
            setText(_data as String);
         }
         else
         {
            _loc1_ = getFirstContext(ILabelFieldContext);
            if((_loc1_) && (_loc1_.labelField))
            {
               setText(_data[_loc1_.labelField]);
            }
            else
            {
               setText(_data.toString());
            }
         }
      }
      
      protected function wire(param1:String, param2:Class = null) : *
      {
         if(param2 == null)
         {
            var param2:Class = SpriteProxy;
         }
         var _loc3_:DisplayObjectProxy = new param2(this);
         setTimelineChildByName(param1,_loc3_);
         return _loc3_;
      }
      
      public function get selectSignal() : ISignal
      {
         return this._selectSignal;
      }
      
      public function get toggleSelectSignal() : ISignal
      {
         return this._toggleSelectSignal;
      }
      
      public function get selectToSignal() : ISignal
      {
         return this._selectToSignal;
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         if(param1.ctrlKey)
         {
            this._toggleSelectSignal.dispatch(this);
         }
         else if(param1.shiftKey)
         {
            this._selectToSignal.dispatch(this);
         }
         else
         {
            this._selectSignal.dispatch(this);
         }
         
      }
   }
}
