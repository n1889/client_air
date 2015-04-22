package de.polygonal.math
{
   public final class PRNG extends Object
   {
      
      public var seed:uint;
      
      public function PRNG()
      {
         super();
         this.seed = 1;
      }
      
      public function nextInt() : uint
      {
         return this.gen();
      }
      
      public function nextDouble() : Number
      {
         return this.gen() / 2147483647;
      }
      
      public function nextIntRange(param1:Number, param2:Number) : uint
      {
         var param1:Number = param1 - 0.4999;
         var param2:Number = param2 + 0.4999;
         return Math.round(param1 + (param2 - param1) * this.nextDouble());
      }
      
      public function nextDoubleRange(param1:Number, param2:Number) : Number
      {
         return param1 + (param2 - param1) * this.nextDouble();
      }
      
      private function gen() : uint
      {
         return this.seed = this.seed * 16807 % 2147483647;
      }
   }
}
