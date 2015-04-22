package com.riotgames.platform.common.xmpp.data.muc
{
   import org.igniterealtime.xiff.data.muc.MUCBaseExtension;
   import org.igniterealtime.xiff.data.IExtension;
   import flash.xml.XMLNode;
   
   public class MUCListExtension extends MUCBaseExtension implements IExtension
   {
      
      public static var ELEMENT:String = "query";
      
      public static var NS:String = "jabber:iq:riotgames:muc_list";
      
      public function MUCListExtension(param1:XMLNode = null)
      {
         super(param1);
      }
      
      public function getElementName() : String
      {
         return MUCListExtension.ELEMENT;
      }
      
      public function getNS() : String
      {
         return MUCListExtension.NS;
      }
      
      override public function deserialize(param1:XMLNode) : Boolean
      {
         var _loc2_:XMLNode = null;
         for each(_loc2_ in param1.childNodes)
         {
            _loc2_.nodeName = "item";
         }
         return super.deserialize(param1);
      }
   }
}
