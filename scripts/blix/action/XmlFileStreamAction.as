package blix.action
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.filesystem.File;
   
   public class XmlFileStreamAction extends FileStreamAction
   {
      
      public var xml:XML;
      
      public function XmlFileStreamAction(param1:File = null, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override protected function completedHandler(param1:Event) : void
      {
         var event:Event = param1;
         data = new ByteArray();
         fileStream.readBytes(data);
         fileStream.close();
         var xmlStr:String = data.readUTFBytes(data.bytesAvailable);
         try
         {
            this.xml = new XML(xmlStr);
         }
         catch(error:Error)
         {
            err(error);
            return;
         }
         if(unmarshallDataFunction != null)
         {
            try
            {
               unmarshalledData = unmarshallDataFunction(this.xml);
            }
            catch(error:Error)
            {
               err(error);
               return;
            }
         }
         complete();
      }
   }
}
