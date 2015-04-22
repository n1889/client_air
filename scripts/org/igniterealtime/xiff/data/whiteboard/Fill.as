package org.igniterealtime.xiff.data.whiteboard
{
   import org.igniterealtime.xiff.data.ISerializable;
   import flash.xml.XMLNode;
   
   public class Fill extends Object implements ISerializable
   {
      
      private var myColor:Number;
      
      private var myOpacity:Number;
      
      public function Fill()
      {
         super();
      }
      
      public function serialize(param1:XMLNode) : Boolean
      {
         if(this.myColor)
         {
            param1.attributes["fill"] = "#" + this.myColor.toString(16);
         }
         if(this.myOpacity)
         {
            param1.attributes["fill-opacity"] = this.myOpacity.toString();
         }
         return true;
      }
      
      public function deserialize(param1:XMLNode) : Boolean
      {
         if(param1.attributes["fill"])
         {
            this.myColor = new Number("0x" + param1.attributes["fill"].slice(1));
         }
         if(param1.attributes["fill-opacity"])
         {
            this.myOpacity = new Number(param1.attributes["fill-opacity"]);
         }
         return true;
      }
      
      public function get color() : Number
      {
         return this.myColor?this.myColor:0;
      }
      
      public function set color(param1:Number) : void
      {
         this.myColor = param1;
      }
      
      public function get opacity() : Number
      {
         return this.myOpacity?this.myOpacity:100;
      }
      
      public function set opacity(param1:Number) : void
      {
         this.myOpacity = param1;
      }
   }
}
