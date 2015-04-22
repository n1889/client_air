package blix.util.math
{
   public function snapNumber(param1:Number, param2:Number, param3:Number = 0) : Number
   {
      var param1:Number = param1 - param3;
      param1 = param1 / param2;
      param1 = Math.round(param1);
      param1 = param1 * param2;
      param1 = param1 + param3;
      return param1;
   }
}
