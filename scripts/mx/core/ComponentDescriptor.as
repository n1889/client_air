package mx.core
{
   public class ComponentDescriptor extends Object
   {
      
      public var events:Object;
      
      public var document:Object;
      
      public var type:Class;
      
      public var propertiesFactory:Function;
      
      private var _properties:Object;
      
      public var id:String;
      
      public function ComponentDescriptor(descriptorProperties:Object)
      {
         var p:String = null;
         super();
         for(p in descriptorProperties)
         {
            this[p] = descriptorProperties[p];
         }
      }
      
      public function toString() : String
      {
         return "ComponentDescriptor_" + id;
      }
      
      public function invalidateProperties() : void
      {
         _properties = null;
      }
      
      public function get properties() : Object
      {
         var cd:Array = null;
         var n:* = 0;
         var i:* = 0;
         if(_properties)
         {
            return _properties;
         }
         if(propertiesFactory != null)
         {
            _properties = propertiesFactory.call(document);
         }
         if(_properties)
         {
            cd = _properties.childDescriptors;
            if(cd)
            {
               n = cd.length;
               i = 0;
               while(i < n)
               {
                  cd[i].document = document;
                  i++;
               }
            }
         }
         else
         {
            _properties = {};
         }
         return _properties;
      }
   }
}
