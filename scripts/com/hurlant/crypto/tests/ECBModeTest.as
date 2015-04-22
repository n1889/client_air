package com.hurlant.crypto.tests
{
   import com.hurlant.util.Hex;
   import flash.utils.ByteArray;
   import com.hurlant.crypto.symmetric.ECBMode;
   import com.hurlant.crypto.symmetric.AESKey;
   import com.hurlant.crypto.symmetric.NullPad;
   import com.hurlant.crypto.symmetric.XTeaKey;
   
   public class ECBModeTest extends TestCase
   {
      
      public function ECBModeTest(param1:ITestHarness)
      {
         super(param1,"ECBMode Test");
         runTest(this.testAES,"ECB AES Test Vectors");
         runTest(this.testXTea,"ECB XTea Test Vectors");
         runTest(this.testECB_AES128,"ECB AES-128 Test Vectors");
         runTest(this.testECB_AES192,"ECB AES-192 Test Vectors");
         runTest(this.testECB_AES256,"ECB AES-256 Test Vectors");
         param1.endTestCase();
      }
      
      public function testECB_AES128() : void
      {
         var _loc1_:ByteArray = Hex.toArray("2b7e151628aed2a6abf7158809cf4f3c");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("3ad77bb40d7a3660a89ecaf32466ef97" + "f5d3d58503b9699de785895a96fdbaaf" + "43b1cd7f598ece23881b00e3ed030688" + "7b0c785e27e8ad3f8223207104725dd4");
         var _loc4_:ECBMode = new ECBMode(new AESKey(_loc1_),new NullPad());
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("ECB_AES128 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("ECB_AES128 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testECB_AES192() : void
      {
         var _loc1_:ByteArray = Hex.toArray("8e73b0f7da0e6452c810f32b809079e562f8ead2522c6b7b");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("bd334f1d6e45f25ff712a214571fa5cc" + "974104846d0ad3ad7734ecb3ecee4eef" + "ef7afd2270e2e60adce0ba2face6444e" + "9a4b41ba738d6c72fb16691603c18e0e");
         var _loc4_:ECBMode = new ECBMode(new AESKey(_loc1_),new NullPad());
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("ECB_AES192 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("ECB_AES192 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testECB_AES256() : void
      {
         var _loc1_:ByteArray = Hex.toArray("603deb1015ca71be2b73aef0857d7781" + "1f352c073b6108d72d9810a30914dff4");
         var _loc2_:ByteArray = Hex.toArray("6bc1bee22e409f96e93d7e117393172a" + "ae2d8a571e03ac9c9eb76fac45af8e51" + "30c81c46a35ce411e5fbc1191a0a52ef" + "f69f2445df4f9b17ad2b417be66c3710");
         var _loc3_:ByteArray = Hex.toArray("f3eed1bdb5d2a03c064b5a7e3db181f8" + "591ccb10d410ed26dc5ba74a31362870" + "b6ed21b99ca6f4f9f153e7b1beafed1d" + "23304b7a39f9f3ff067d8d8f9e24ecc7");
         var _loc4_:ECBMode = new ECBMode(new AESKey(_loc1_),new NullPad());
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeBytes(_loc2_);
         _loc4_.encrypt(_loc5_);
         assert("ECB_AES256 test 1",Hex.fromArray(_loc5_) == Hex.fromArray(_loc3_));
         _loc4_.decrypt(_loc5_);
         assert("ECB_AES256 test 2",Hex.fromArray(_loc5_) == Hex.fromArray(_loc2_));
      }
      
      public function testAES() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:AESKey = null;
         var _loc8_:ECBMode = null;
         var _loc9_:String = null;
         var _loc1_:Array = ["00010203050607080A0B0C0D0F101112","14151617191A1B1C1E1F202123242526"];
         var _loc2_:Array = ["506812A45F08C889B97F5980038B8359506812A45F08C889B97F5980038B8359506812A45F08C889B97F5980038B8359","5C6D71CA30DE8B8B00549984D2EC7D4B5C6D71CA30DE8B8B00549984D2EC7D4B5C6D71CA30DE8B8B00549984D2EC7D4B"];
         var _loc3_:Array = ["D8F532538289EF7D06B506A4FD5BE9C9D8F532538289EF7D06B506A4FD5BE9C9D8F532538289EF7D06B506A4FD5BE9C96DE5F607AB7EB8202F3957703B04E8B5","59AB30F4D4EE6E4FF9907EF65B1FB68C59AB30F4D4EE6E4FF9907EF65B1FB68C59AB30F4D4EE6E4FF9907EF65B1FB68C2993487785CB1CFDA6BB4F0F345F76C7"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc2_[_loc4_]);
            _loc7_ = new AESKey(_loc5_);
            _loc8_ = new ECBMode(_loc7_);
            _loc8_.encrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc9_,_loc3_[_loc4_] == _loc9_);
            _loc8_.decrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_).toUpperCase();
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc9_,_loc2_[_loc4_] == _loc9_);
            _loc4_++;
         }
      }
      
      public function testXTea() : void
      {
         var _loc5_:ByteArray = null;
         var _loc6_:ByteArray = null;
         var _loc7_:XTeaKey = null;
         var _loc8_:ECBMode = null;
         var _loc9_:String = null;
         var _loc1_:Array = ["00000000000000000000000000000000","2b02056806144976775d0e266c287843"];
         var _loc2_:Array = ["0000000000000000000000000000000000000000000000000000000000000000","74657374206d652e74657374206d652e74657374206d652e74657374206d652e"];
         var _loc3_:Array = ["2dc7e8d3695b05382dc7e8d3695b05382dc7e8d3695b05382dc7e8d3695b053820578a874233632d","79095821381987837909582138198783790958213819878379095821381987830e4dc3c48b2edf32"];
         var _loc4_:uint = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc5_ = Hex.toArray(_loc1_[_loc4_]);
            _loc6_ = Hex.toArray(_loc2_[_loc4_]);
            _loc7_ = new XTeaKey(_loc5_);
            _loc8_ = new ECBMode(_loc7_);
            _loc8_.encrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc3_[_loc4_] + " to " + _loc9_,_loc3_[_loc4_] == _loc9_);
            _loc8_.decrypt(_loc6_);
            _loc9_ = Hex.fromArray(_loc6_);
            assert("comparing " + _loc2_[_loc4_] + " to " + _loc9_,_loc2_[_loc4_] == _loc9_);
            _loc4_++;
         }
      }
   }
}
