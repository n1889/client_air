package blix.factory
{
   public class ObjectPool extends Object implements IPool
   {
      
      private var instances:Array;
      
      private var factory:IFactory;
      
      public function ObjectPool(param1:IFactory)
      {
         this.instances = [];
         super();
         this.factory = param1;
      }
      
      public function returnInstance(param1:*) : void
      {
         this.instances.push(param1);
      }
      
      public function getInstance() : *
      {
         if(this.instances.length)
         {
            return this.instances.pop();
         }
         return this.factory.getInstance();
      }
   }
}
