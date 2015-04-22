package blix.model
{
   import flash.utils.IExternalizable;
   import blix.signals.Signal;
   import blix.signals.ISignal;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class TextModel extends Object implements ITextModel, IExternalizable
   {
      
      protected var _textChanged:Signal;
      
      protected var _text:String;
      
      public function TextModel(param1:String = "")
      {
         this._textChanged = new Signal();
         super();
         this.setText(param1);
      }
      
      public function getTextChanged() : ISignal
      {
         return this._textChanged;
      }
      
      public function getText() : String
      {
         return this._text;
      }
      
      public function setText(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         var _loc2_:String = this._text;
         this._text = param1;
         this._textChanged.dispatch(this,_loc2_,this._text);
      }
      
      public function clone() : TextModel
      {
         return new TextModel(this._text);
      }
      
      public function toString() : String
      {
         return "[TextModel text=" + this._text + "]";
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeUTF(this._text);
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this._text = param1.readUTF();
      }
   }
}
