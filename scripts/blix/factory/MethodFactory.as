package blix.factory
{
   public class MethodFactory extends Object implements IFactory
   {
      
      private var func:Function;
      
      public function MethodFactory(param1:Function)
      {
         super();
         this.func = param1;
      }
      
      public function getInstance() : *
      {
         return this.func();
      }
   }
}
