package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import com.greensock.easing.*;
   import com.greensock.TweenMax;
   
   public dynamic class MessageCenter extends MyUIMovieClip
   {
      
      public static const CENTER_MESSAGE_STATE_ANIMATE:String = "newMessage";
      
      public var bg:MovieClip;
      
      public var start:MovieClip;
      
      public var boundingBox:MovieClip;
      
      public var messageCenter_messageText:TextFieldMovieClip;
      
      private var _message:String;
      
      public var frameLabelArr:Array;
      
      public function MessageCenter()
      {
         this.frameLabelArr = ["newMessage"];
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(evt:Event) : void
      {
         this.init();
      }
      
      public function init() : void
      {
         this.addListeners();
      }
      
      public function addListeners() : void
      {
      }
      
      public function gotoStateIndex(idx:uint) : void
      {
         this.currentState = this.frameLabelArr[idx];
      }
      
      public function get message() : String
      {
         return this._message;
      }
      
      public function set message(value:String) : void
      {
         this._message = value;
         this.messageCenter_messageText.label_txt.text = value;
      }
      
      public function fadeInText() : void
      {
         this.messageCenter_messageText.label_txt.text = this._message;
         TweenMax.to(this.messageCenter_messageText,0.5,{"alpha":1});
      }
      
      public function flash() : void
      {
         gotoAndPlay("newMessage");
      }
      
      override public function set currentState(value:String) : void
      {
         switch(value)
         {
            case CENTER_MESSAGE_STATE_ANIMATE:
               gotoAndPlay(value);
               break;
         }
      }
      
      override public function get measuredWidth() : Number
      {
         return this.boundingBox.width;
      }
      
      override public function get measuredHeight() : Number
      {
         return this.boundingBox.height;
      }
      
      override public function setActualSize(newWidth:Number, newHeight:Number) : void
      {
         if((!(newWidth == _width)) || (!(newHeight == _height)))
         {
            _width = newWidth;
            _height = newHeight;
         }
      }
   }
}
