package blix.util.string.format
{
   public function bytesToStr(param1:Number) : String
   {
      if(param1 < 1024)
      {
         return param1 + " B";
      }
      if(param1 < 1048576)
      {
         return (param1 / 1024).toFixed(2) + " KB";
      }
      if(param1 < 1073741824)
      {
         return (param1 / 1048576).toFixed(2) + " MB";
      }
      if(param1 < 1.099511627776E12)
      {
         return (param1 / 1073741824).toFixed(2) + " GB";
      }
      if(param1 < 1.125899906842624E15)
      {
         return (param1 / 1.099511627776E12).toFixed(2) + " TB";
      }
      if(param1 < 1.15292150460684698E18)
      {
         return (param1 / 1.125899906842624E15).toFixed(2) + " PB";
      }
      if(param1 < 1.1805916207174113E21)
      {
         return (param1 / 1.15292150460684698E18).toFixed(2) + " EB";
      }
      if(param1 < 1.2089258196146292E24)
      {
         return (param1 / 1.1805916207174113E21).toFixed(2) + " ZB";
      }
      return (param1 / 1.2089258196146292E24).toFixed(2) + " YB";
   }
}
