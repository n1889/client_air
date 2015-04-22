package blix.view
{
   import blix.signals.ListenerListItem;
   import blix.frame.getFrameDispatcher;
   import flash.display.DisplayObject;
   import blix.frame.getRender;
   import blix.frame.getEnterFrame;
   
   public final class LayoutValidator extends Object
   {
      
      private static var _instance:LayoutValidator;
      
      private var _isValid:Boolean = true;
      
      private var _isValidatingLayout:Boolean;
      
      private var _validateLayoutBegin:ValidationSignal;
      
      private var enterFrameListenerListItem:ListenerListItem;
      
      private var renderListenerListItem:ListenerListItem;
      
      public function LayoutValidator()
      {
         this._validateLayoutBegin = new ValidationSignal();
         super();
      }
      
      public static function getInstance() : LayoutValidator
      {
         if(_instance == null)
         {
            _instance = new LayoutValidator();
         }
         return _instance;
      }
      
      public function getValidateLayoutBegin() : ValidationSignal
      {
         return this._validateLayoutBegin;
      }
      
      public function getIsValidatingLayout() : Boolean
      {
         return this._isValidatingLayout;
      }
      
      public function invalidateLayout() : void
      {
         if((this._isValidatingLayout) || (!this._isValid))
         {
            return;
         }
         this._isValid = false;
         var _loc1_:DisplayObject = getFrameDispatcher();
         if(_loc1_.stage != null)
         {
            _loc1_.stage.invalidate();
            this.renderListenerListItem = getRender().addOnce(this.validateLayout);
            this.enterFrameListenerListItem = getEnterFrame().addOnce(this.validateLayout);
         }
         else
         {
            this.enterFrameListenerListItem = getEnterFrame().addOnce(this.validateLayout);
         }
      }
      
      public function validateLayout() : void
      {
         this._isValidatingLayout = true;
         getEnterFrame().removeItem(this.enterFrameListenerListItem);
         getRender().removeItem(this.renderListenerListItem);
         this.enterFrameListenerListItem = null;
         this.renderListenerListItem = null;
         this._validateLayoutBegin.dispatch();
         this._isValid = true;
         this._isValidatingLayout = false;
      }
   }
}
