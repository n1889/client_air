package caurina.transitions
{
   public class AuxFunctions extends Object
   {
      
      public function AuxFunctions()
      {
         super();
      }
      
      public static function concatObjects(... args) : Object
      {
         var finalObject:Object = null;
         var currentObject:Object = null;
         var i:* = 0;
         var prop:String = null;
         finalObject = {};
         i = 0;
         while(i < args.length)
         {
            currentObject = args[i];
            for(prop in currentObject)
            {
               if(currentObject[prop] == null)
               {
                  delete finalObject[prop];
                  true;
               }
               else
               {
                  finalObject[prop] = currentObject[prop];
               }
            }
            i++;
         }
         return finalObject;
      }
      
      public static function numberToG(p_num:Number) : Number
      {
         return (p_num & 65280) >> 8;
      }
      
      public static function numberToR(p_num:Number) : Number
      {
         return (p_num & 16711680) >> 16;
      }
      
      public static function isInArray(p_string:String, p_array:Array) : Boolean
      {
         var l:uint = 0;
         var i:uint = 0;
         l = p_array.length;
         i = 0;
         while(i < l)
         {
            if(p_array[i] == p_string)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function getObjectLength(p_object:Object) : uint
      {
         var totalProperties:uint = 0;
         var pName:String = null;
         totalProperties = 0;
         for(pName in p_object)
         {
            totalProperties++;
         }
         return totalProperties;
      }
      
      public static function numberToB(p_num:Number) : Number
      {
         return p_num & 255;
      }
   }
}
