package mx.events
{
   import mx.core.mx_internal;
   
   public final class PropertyChangeEventKind extends Object
   {
      
      mx_internal  static const VERSION:String = "3.0.0.0";
      
      public static const UPDATE:String = "update";
      
      public static const DELETE:String = "delete";
      
      public function PropertyChangeEventKind()
      {
         super();
      }
   }
}
