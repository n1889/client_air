package com.riotgames.platform.common.xmpp.data.muc
{
   import org.igniterealtime.xiff.data.muc.MUCBaseExtension;
   import org.igniterealtime.xiff.data.IExtension;
   import org.igniterealtime.xiff.data.muc.MUCItem;
   import org.igniterealtime.xiff.core.EscapedJID;
   import flash.xml.XMLNode;
   
   public class MUCNameCheckExtension extends MUCBaseExtension implements IExtension
   {
      
      public static var ELEMENT:String = "query";
      
      public static var NS:String = "jabber:iq:riotgames:muc:name_check";
      
      public function MUCNameCheckExtension(param1:XMLNode = null)
      {
         super(param1);
      }
      
      public function getElementName() : String
      {
         return MUCNameCheckExtension.ELEMENT;
      }
      
      public function getNS() : String
      {
         return MUCNameCheckExtension.NS;
      }
      
      public function addNamedItem(param1:String, param2:String = null, param3:String = null, param4:String = null, param5:EscapedJID = null, param6:String = null, param7:String = null) : MUCItem
      {
         var _loc8_:MUCItem = super.addItem(param2,param3,param4,param5,param6,param7);
         _loc8_.getNode().attributes.name = param1;
         return null;
      }
   }
}
