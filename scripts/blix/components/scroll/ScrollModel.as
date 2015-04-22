package blix.components.scroll
{
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import blix.util.math.clamp;
   
   public class ScrollModel extends Object
   {
      
      protected var _changed:Signal;
      
      protected var _min:Number = 0;
      
      protected var _max:Number = 0;
      
      protected var _value:Number = 0;
      
      public function ScrollModel()
      {
         this._changed = new Signal();
         super();
      }
      
      public function getChanged() : ISignal
      {
         return this._changed;
      }
      
      public function getMin() : Number
      {
         return this._min;
      }
      
      public function setMin(param1:Number) : void
      {
         if(this._min == param1)
         {
            return;
         }
         this._min = param1;
         this._changed.dispatch(this);
      }
      
      public function getMax() : Number
      {
         return this._max;
      }
      
      public function setMax(param1:Number) : void
      {
         if(this._max == param1)
         {
            return;
         }
         this._max = param1;
         this._changed.dispatch(this);
      }
      
      public function getValue() : Number
      {
         return this._value;
      }
      
      public function setValue(param1:Number) : void
      {
         if(this._value == param1)
         {
            return;
         }
         this._value = param1;
         this._changed.dispatch(this);
      }
      
      public function getClampedValue() : Number
      {
         return clamp(this._value,this._min,this._max);
      }
      
      public function clampValue(param1:Number) : Number
      {
         return clamp(param1,this._min,this._max);
      }
   }
}
