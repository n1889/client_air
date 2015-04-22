package org.igniterealtime.xiff.data.vcard
{
   import org.igniterealtime.xiff.data.Extension;
   import org.igniterealtime.xiff.data.IExtension;
   import org.igniterealtime.xiff.data.ISerializable;
   import flash.xml.XMLNode;
   
   public class VCardExtension extends Extension implements IExtension, ISerializable
   {
      
      public function VCardExtension()
      {
         super();
      }
      
      public function getNS() : String
      {
         return "vcard-temp";
      }
      
      public function getElementName() : String
      {
         return "vCard";
      }
      
      public function serialize(param1:XMLNode) : Boolean
      {
         param1.appendChild(getNode());
         return true;
      }
      
      public function deserialize(param1:XMLNode) : Boolean
      {
         return true;
      }
   }
}
