package com.riotgames.rust.decorator
{
   import flash.utils.Dictionary;
   import mx.logging.ILogger;
   import flash.display.DisplayObject;
   import flash.text.TextFormat;
   import flash.text.TextField;
   import com.riotgames.util.logging.getLogger;
   
   public class FontMapDecorator extends DisplayGraphDecorator
   {
      
      public static const APPLICATION_FONT_1:String = "ApplicationFont1";
      
      public static const APPLICATION_FONT_2:String = "ApplicationFont2";
      
      public static const APPLICATION_FONT_3:String = "ApplicationFont3";
      
      public static const APPLICATION_FONT_3_BOLD:String = "ApplicationFont3Bold";
      
      public static const APPLICATION_FONT_3_ITALIC:String = "ApplicationFont3Italic";
      
      public static const APPLICATION_FONT_3_BOLDITALIC:String = "ApplicationFont3BoldItalic";
      
      public static const APPLICATION_FONT_4:String = "ApplicationFont4";
      
      public static const APPLICATION_FONT_4_BOLD:String = "ApplicationFont4Bold";
      
      public static const APPLICATION_FONT_4_ITALIC:String = "ApplicationFont4Italic";
      
      public static const APPLICATION_FONT_4_BOLDITALIC:String = "ApplicationFont4BoldItalic";
      
      public static const APPLICATION_FONT_LIGHT:String = "ApplicationFontLight";
      
      private static const FONT_MAP:Dictionary = new Dictionary();
      
      private static var initialized:Boolean;
      
      private var logger:ILogger;
      
      public function FontMapDecorator()
      {
         this.logger = getLogger(this);
         super(TextField);
         if(!initialized)
         {
            FONT_MAP["Helvetica LT Std"] = APPLICATION_FONT_1;
            FONT_MAP["Helvetica LT Std Bold"] = APPLICATION_FONT_1;
            FONT_MAP["ITC Friz Quadrata"] = APPLICATION_FONT_2;
            FONT_MAP["Gill Sans MT Pro Medium"] = APPLICATION_FONT_1;
            FONT_MAP["Gill Sans MT Pro Bold"] = APPLICATION_FONT_2;
            FONT_MAP["Gill Sans MT Pro Light"] = APPLICATION_FONT_LIGHT;
            FONT_MAP["Helvetica LT Std Roman"] = APPLICATION_FONT_1;
            FONT_MAP["HelveticaLTStd-Roman"] = APPLICATION_FONT_1;
            FONT_MAP["HelveticaLTStd-Bold"] = APPLICATION_FONT_1;
            FONT_MAP["ITC Friz Quadrata BT Roman"] = APPLICATION_FONT_2;
            FONT_MAP["ITC Friz Quadrata BT Bold"] = APPLICATION_FONT_2;
            FONT_MAP["ITC Friz Quadrata Bold"] = APPLICATION_FONT_2;
            FONT_MAP["Beaufort for LOL"] = APPLICATION_FONT_3;
            FONT_MAP["Beaufort for LOL Bold"] = APPLICATION_FONT_3_BOLD;
            FONT_MAP["Beaufort for LOL Italic"] = APPLICATION_FONT_3_ITALIC;
            FONT_MAP["Beaufort for LOL Bold Italic"] = APPLICATION_FONT_3_BOLDITALIC;
            FONT_MAP["Spiegel Regular"] = APPLICATION_FONT_4;
            FONT_MAP["Spiegel Bold"] = APPLICATION_FONT_4_BOLD;
            FONT_MAP["Spiegel Regular Italic"] = APPLICATION_FONT_4_ITALIC;
            FONT_MAP["Spiegel Bold Italic"] = APPLICATION_FONT_4_BOLDITALIC;
            initialized = true;
         }
      }
      
      override protected function decorate(param1:DisplayObject) : void
      {
         var _loc5_:TextFormat = null;
         var _loc6_:String = null;
         var _loc2_:TextField = param1 as TextField;
         var _loc3_:String = _loc2_.defaultTextFormat.font;
         var _loc4_:String = FONT_MAP[_loc3_];
         if(_loc4_ != null)
         {
            _loc2_.embedFonts = true;
            if(_loc2_.styleSheet == null)
            {
               _loc5_ = new TextFormat();
               _loc5_.font = _loc4_;
               _loc2_.defaultTextFormat = _loc5_;
               _loc2_.setTextFormat(_loc5_);
            }
         }
         else if((!(_loc3_ == APPLICATION_FONT_1)) && (!(_loc3_ == APPLICATION_FONT_2)) && (!(_loc3_ == APPLICATION_FONT_3)) && (!(_loc3_ == APPLICATION_FONT_3_BOLD)) && (!(_loc3_ == APPLICATION_FONT_3_ITALIC)) && (!(_loc3_ == APPLICATION_FONT_3_BOLDITALIC)) && (!(_loc3_ == APPLICATION_FONT_4)) && (!(_loc3_ == APPLICATION_FONT_4_BOLD)) && (!(_loc3_ == APPLICATION_FONT_4_ITALIC)) && (!(_loc3_ == APPLICATION_FONT_4_BOLDITALIC)) && (!(_loc3_ == APPLICATION_FONT_LIGHT)))
         {
            _loc6_ = this.getFormattedPath(_loc2_);
            if(_loc2_.embedFonts)
            {
               this.logger.error("Embedding unsupported font: " + _loc3_ + " in " + _loc6_);
            }
            else
            {
               this.logger.debug("Unembedded font: " + _loc3_ + " in " + _loc6_);
            }
         }
         
      }
      
      private function getFormattedPath(param1:DisplayObject) : String
      {
         var _loc2_:String = null;
         while(param1.parent != null)
         {
            _loc2_ = param1.name + (!_loc2_?"":"." + _loc2_);
            var param1:DisplayObject = param1.parent;
         }
         return _loc2_;
      }
   }
}
