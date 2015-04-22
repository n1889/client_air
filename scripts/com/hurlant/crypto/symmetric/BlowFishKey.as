package com.hurlant.crypto.symmetric
{
   import flash.utils.ByteArray;
   import com.hurlant.util.Memory;
   
   public class BlowFishKey extends Object implements ISymmetricKey
   {
      
      private static const KP:Array = [608135816,2.242054355E9,320440878,57701188,2.752067618E9,698298832,137296536,3.964562569E9,1160258022,953160567,3.193202383E9,887688300,3.232508343E9,3.380367581E9,1065670069,3.041331479E9,2.450970073E9,2.306472731E9];
      
      private static const KS0:Array = [3.50965239E9,2.564797868E9,805139163,3.491422135E9,3.101798381E9,1780907670,3.128725573E9,4.046225305E9,614570311,3.012652279E9,134345442,2.240740374E9,1667834072,1901547113,2.757295779E9,4.103290238E9,227898511,1921955416,1904987480,2.182433518E9,2069144605,3.260701109E9,2.620446009E9,720527379,3.318853667E9,677414384,3.393288472E9,3.101374703E9,2.390351024E9,1614419982,1822297739,2.954791486E9,3.608508353E9,3.174124327E9,2024746970,1432378464,3.864339955E9,2.857741204E9,1464375394,1676153920,1439316330,715854006,3.033291828E9,289532110,2.706671279E9,2087905683,3.018724369E9,1668267050,732546397,1947742710,3.462151702E9,2.609353502E9,2.950085171E9,1814351708,2050118529,680887927,999245976,1800124847,3.300911131E9,1713906067,1641548236,4.213287313E9,1216130144,1575780402,4.018429277E9,3.917837745E9,3.69348685E9,3.949271944E9,596196993,3.549867205E9,258830323,2.213823033E9,772490370,2.760122372E9,1774776394,2.652871518E9,566650946,4.142492826E9,1728879713,2.882767088E9,1783734482,3.629395816E9,2.517608232E9,2.874225571E9,1861159788,326777828,3.12449032E9,2130389656,2.716951837E9,967770486,1724537150,2.185432712E9,2.364442137E9,1164943284,2105845187,998989502,3.765401048E9,2.244026483E9,1075463327,1455516326,1322494562,910128902,469688178,1117454909,936433444,3.490320968E9,3.675253459E9,1240580251,122909385,2.157517691E9,634681816,4.142456567E9,3.825094682E9,3.061402683E9,2.540495037E9,79693498,3.249098678E9,1084186820,1583128258,426386531,1761308591,1047286709,322548459,995290223,1845252383,2.603652396E9,3.43102394E9,2.942221577E9,3.202600964E9,3.727903485E9,1712269319,422464435,3.234572375E9,1170764815,3.523960633E9,3.117677531E9,1434042557,442511882,3.600875718E9,1076654713,1738483198,4.213154764E9,2.393238008E9,3.677496056E9,1014306527,4.251020053E9,793779912,2.902807211E9,842905082,4.246964064E9,1395751752,1040244610,2.656851899E9,3.396308128E9,445077038,3.742853595E9,3.577915638E9,679411651,2.892444358E9,2.354009459E9,1767581616,3.150600392E9,3.791627101E9,3.102740896E9,284835224,4.246832056E9,1258075500,768725851,2.589189241E9,3.069724005E9,3.532540348E9,1274779536,3.789419226E9,2.764799539E9,1660621633,3.471099624E9,4.011903706E9,913787905,3.497959166E9,737222580,2.514213453E9,2.92871004E9,3.937242737E9,1804850592,3.499020752E9,2.94906416E9,2.386320175E9,2.390070455E9,2.415321851E9,4.061277028E9,2.290661394E9,2.41683254E9,1336762016,1754252060,3.520065937E9,3.014181293E9,791618072,3.188594551E9,3.93354803E9,2.332172193E9,3.852520463E9,3.04398052E9,413987798,3.465142937E9,3.030929376E9,4.245938359E9,2093235073,3.534596313E9,375366246,2.157278981E9,2.479649556E9,555357303,3.870105701E9,2008414854,3.344188149E9,4.221384143E9,3.956125452E9,2067696032,3.594591187E9,2.921233993E9,2428461,544322398,577241275,1471733935,610547355,4.027169054E9,1432588573,1507829418,2025931657,3.646575487E9,545086370,48609733,2.20030655E9,1653985193,298326376,1316178497,3.007786442E9,2064951626,458293330,2.589141269E9,3.591329599E9,3.164325604E9,727753846,2.17936384E9,146436021,1461446943,4.069977195E9,705550613,3.059967265E9,3.887724982E9,4.281599278E9,3.313849956E9,1404054877,2.845806497E9,146425753,1854211946];
      
      private static const KS1:Array = [1266315497,3.048417604E9,3.681880366E9,3.289982499E9,2.90971E9,1235738493,2.632868024E9,2.41471959E9,3.970600049E9,1771706367,1449415276,3.266420449E9,422970021,1963543593,2.690192192E9,3.826793022E9,1062508698,1531092325,1804592342,2.583117782E9,2.714934279E9,4.024971509E9,1294809318,4.028980673E9,1289560198,2.221992742E9,1669523910,35572830,157838143,1052438473,1016535060,1802137761,1753167236,1386275462,3.080475397E9,2.857371447E9,1040679964,2145300060,2.390574316E9,1461121720,2.956646967E9,4.031777805E9,4.028374788E9,33600511,2.920084762E9,1018524850,629373528,3.691585981E9,3.515945977E9,2091462646,2.486323059E9,586499841,988145025,935516892,3.367335476E9,2.599673255E9,2.839830854E9,265290510,3.972581182E9,2.759138881E9,3.795373465E9,1005194799,847297441,406762289,1314163512,1332590856,1866599683,4.127851711E9,750260880,613907577,1450815602,3.165620655E9,3.734664991E9,3.650291728E9,3.01227573E9,3.704569646E9,1427272223,778793252,1343938022,2.676280711E9,2052605720,1946737175,3.164576444E9,3.914038668E9,3.967478842E9,3.682934266E9,1661551462,3.294938066E9,4.011595847E9,840292616,3.712170807E9,616741398,312560963,711312465,1351876610,322626781,1910503582,271666773,2.175563734E9,1594956187,70604529,3.617834859E9,1007753275,1495573769,4.069517037E9,2.549218298E9,2.663038764E9,504708206,2.263041392E9,3.941167025E9,2.249088522E9,1514023603,1998579484,1312622330,694541497,2.582060303E9,2.151582166E9,1382467621,776784248,2.618340202E9,3.323268794E9,2.497899128E9,2.784771155E9,503983604,4.076293799E9,907881277,423175695,432175456,1378068232,4.145222326E9,3.954048622E9,3.938656102E9,3.820766613E9,2.793130115E9,2.977904593E9,26017576,3.274890735E9,3.194772133E9,1700274565,1756076034,4.006520079E9,3.677328699E9,720338349,1533947780,354530856,688349552,3.973924725E9,1637815568,332179504,3.949051286E9,53804574,2.852348879E9,3.044236432E9,1282449977,3.583942155E9,3.41697282E9,4.006381244E9,1617046695,2.628476075E9,3.002303598E9,1686838959,431878346,2.686675385E9,1700445008,1080580658,1009431731,832498133,3.223435511E9,2.605976345E9,2.271191193E9,2.51603187E9,1648197032,4.164389018E9,2.548247927E9,300782431,375919233,238389289,3.353747414E9,2.531188641E9,2019080857,1475708069,455242339,2.609103871E9,448939670,3.451063019E9,1395535956,2.41338186E9,1841049896,1491858159,885456874,4.264095073E9,4.001119347E9,1565136089,3.898914787E9,1108368660,540939232,1173283510,2.745871338E9,3.681308437E9,4.20762824E9,3.34305389E9,4.016749493E9,1699691293,1103962373,3.62587587E9,2.256883143E9,3.83013873E9,1031889488,3.479347698E9,1535977030,4.236805024E9,3.251091107E9,2132092099,1774941330,1199868427,1452454533,157007616,2.904115357E9,342012276,595725824,1480756522,206960106,497939518,591360097,863170706,2.375253569E9,3.596610801E9,1814182875,2094937945,3.421402208E9,1082520231,3.46391819E9,2.785509508E9,435703966,3.908032597E9,1641649973,2.842273706E9,3.305899714E9,1510255612,2.148256476E9,2.655287854E9,3.276092548E9,4.258621189E9,236887753,3.681803219E9,274041037,1734335097,3.815195456E9,3.317970021E9,1899903192,1026095262,4.050517792E9,356393447,2.410691914E9,3.873677099E9,3.682840055E9];
      
      private static const KS2:Array = [3.913112168E9,2.491498743E9,4.132185628E9,2.489919796E9,1091903735,1979897079,3.17013483E9,3.567386728E9,3.557303409E9,857797738,1136121015,1342202287,507115054,2.535736646E9,337727348,3.21359264E9,1301675037,2.528481711E9,1895095763,1721773893,3.216771564E9,62756741,2142006736,835421444,2.531993523E9,1442658625,3.659876326E9,2.882144922E9,676362277,1392781812,170690266,3.921047035E9,1759253602,3.611846912E9,1745797284,664899054,1329594018,3.9012059E9,3.045908486E9,2062866102,2.86563494E9,3.543621612E9,3.464012697E9,1080764994,553557557,3.656615353E9,3.996768171E9,991055499,499776247,1265440854,648242737,3.94078405E9,980351604,3.713745714E9,1749149687,3.396870395E9,4.211799374E9,3.640570775E9,1161844396,3.125318951E9,1431517754,545492359,4.268468663E9,3.499529547E9,1437099964,2.702547544E9,3.433638243E9,2.581715763E9,2.787789398E9,1060185593,1593081372,2.418618748E9,4.26094797E9,69676912,2.159744348E9,86519011,2.51245908E9,3.838209314E9,1220612927,3.339683548E9,133810670,1090789135,1078426020,1569222167,845107691,3.583754449E9,4.072456591E9,1091646820,628848692,1613405280,3.757631651E9,526609435,236106946,48312990,2.942717905E9,3.402727701E9,1797494240,859738849,992217954,4.005476642E9,2.243076622E9,3.870952857E9,3.732016268E9,765654824,3.490871365E9,2.511836413E9,1685915746,3.8889692E9,1414112111,2.273134842E9,3.281911079E9,4.080962846E9,172450625,2.5699941E9,980381355,4.109958455E9,2.819808352E9,2.71658956E9,2.568741196E9,3.681446669E9,3.329971472E9,1835478071,660984891,3.704678404E9,4.045999559E9,3.422617507E9,3.040415634E9,1762651403,1719377915,3.470491036E9,2.693910283E9,3.642056355E9,3.138596744E9,1364962596,2073328063,1983633131,926494387,3.423689081E9,2.150032023E9,4.096667949E9,1749200295,3.328846651E9,309677260,2016342300,1779581495,3.079819751E9,111262694,1274766160,443224088,298511866,1025883608,3.806446537E9,1145181785,168956806,3.64150283E9,3.58481361E9,1689216846,3.666258015E9,3.2002482E9,1692713982,2.646376535E9,4.042768518E9,1618508792,1610833997,3.523052358E9,4.130873264E9,2001055236,3.6107051E9,2.202168115E9,4.028541809E9,2.961195399E9,1006657119,2006996926,3.186142756E9,1430667929,3.210227297E9,1314452623,4.074634658E9,4.10130412E9,2.27395117E9,1399257539,3.367210612E9,3.027628629E9,1190975929,2062231137,2.333990788E9,2.221543033E9,2.43896061E9,1181637006,548689776,2.362791313E9,3.372408396E9,3.104550113E9,3.14586056E9,296247880,1970579870,3.078560182E9,3.769228297E9,1714227617,3.291629107E9,3.89822029E9,166772364,1251581989,493813264,448347421,195405023,2.709975567E9,677966185,3.703036547E9,1463355134,2.715995803E9,1338867538,1343315457,2.802222074E9,2.684532164E9,233230375,2.599980071E9,2000651841,3.277868038E9,1638401717,4.02807044E9,3.23731632E9,6314154,819756386,300326615,590932579,1405279636,3.267499572E9,3.150704214E9,2.428286686E9,3.959192993E9,3.461946742E9,1862657033,1266418056,963775037,2089974820,2.263052895E9,1917689273,448879540,3.55039462E9,3.981727096E9,150775221,3.627908307E9,1303187396,508620638,2.975983352E9,2.726630617E9,1817252668,1876281319,1457606340,908771278,3.720792119E9,3.617206836E9,2.455994898E9,1729034894,1080033504];
      
      private static const KS3:Array = [976866871,3.556439503E9,2.881648439E9,1522871579,1555064734,1336096578,3.548522304E9,2.579274686E9,3.574697629E9,3.205460757E9,3.593280638E9,3.338716283E9,3.079412587E9,564236357,2.99359891E9,1781952180,1464380207,3.163844217E9,3.332601554E9,1699332808,1393555694,1183702653,3.581086237E9,1288719814,691649499,2.8475572E9,2.895455976E9,3.19388954E9,2.717570544E9,1781354906,1676643554,2.59253405E9,3.230253752E9,1126444790,2.770207658E9,2.63315882E9,2.210423226E9,2.615765581E9,2.414155088E9,3.127139286E9,673620729,2.805611233E9,1269405062,4.015350505E9,3.341807571E9,4.149409754E9,1057255273,2012875353,2.162469141E9,2.276492801E9,2.601117357E9,993977747,3.91859337E9,2.654263191E9,753973209,36408145,2.530585658E9,25011837,3.520020182E9,2088578344,530523599,2.918365339E9,1524020338,1518925132,3.760827505E9,3.759777254E9,1202760957,3.985898139E9,3.906192525E9,674977740,4.174734889E9,2031300136,2019492241,3.983892565E9,4.153806404E9,3.822280332E9,352677332,2.29772025E9,60907813,90501309,3.286998549E9,1016092578,2.535922412E9,2.839152426E9,457141659,509813237,4.120667899E9,652014361,1966332200,2.975202805E9,55981186,2.327461051E9,676427537,3.255491064E9,2.882294119E9,3.433927263E9,1307055953,942726286,933058658,2.468411793E9,3.933900994E9,4.215176142E9,1361170020,2001714738,2.830558078E9,3.274259782E9,1222529897,1679025792,2.72931432E9,3.714953764E9,1770335741,151462246,3.013232138E9,1682292957,1483529935,471910574,1539241949,458788160,3.436315007E9,1807016891,3.71840883E9,978976581,1043663428,3.165965781E9,1927990952,4.200891579E9,2.37227691E9,3.208408903E9,3.533431907E9,1412390302,2.931980059E9,4.1323324E9,1947078029,3.881505623E9,4.168226417E9,2.941484381E9,1077988104,1320477388,886195818,18198404,3.786409E9,2.509781533E9,112762804,3.463356488E9,1866414978,891333506,18488651,661792760,1628790961,3.885187036E9,3.141171499E9,876946877,2.693282273E9,1372485963,791857591,2.686433993E9,3.759982718E9,3.167212022E9,3.472953795E9,2.716379847E9,445679433,3.561995674E9,3.504004811E9,3.574258232E9,54117162,3.331405415E9,2.381918588E9,3.769707343E9,4.154350007E9,1140177722,4.074052095E9,668550556,3.21435294E9,367459370,261225585,2.610173221E9,4.209349473E9,3.468074219E9,3.265815641E9,314222801,3.066103646E9,3.80878286E9,282218597,3.406013506E9,3.773591054E9,379116347,1285071038,846784868,2.669647154E9,3.771962079E9,3.550491691E9,2.305946142E9,453669953,1268987020,3.317592352E9,3.279303384E9,3.744833421E9,2.610507566E9,3.859509063E9,266596637,3.847019092E9,517658769,3.462560207E9,3.443424879E9,370717030,4.247526661E9,2.224018117E9,4.143653529E9,4.112773975E9,2.788324899E9,2.477274417E9,1456262402,2.901442914E9,1517677493,1846949527,2.29549358E9,3.734397586E9,2.17640392E9,1280348187,1908823572,3.871786941E9,846861322,1172426758,3.287448474E9,3.383383037E9,1655181056,3.139813346E9,901632758,1897031941,2.986607138E9,3.066810236E9,3.447102507E9,1393639104,373351379,950779232,625454576,3.12424054E9,4.148612726E9,2007998917,544563296,2.244738638E9,2.330496472E9,2058025392,1291430526,424198748,50039436,29584100,3.605783033E9,2.429876329E9,2.79110416E9,1057563949,3.255363231E9,3.075367218E9,3.463963227E9,1469046755,985887462];
      
      private static const ROUNDS:uint = 16;
      
      private static const BLOCK_SIZE:uint = 8;
      
      private static const SBOX_SK:uint = 256;
      
      private static const P_SZ:uint = ROUNDS + 2;
      
      private var S0:Array;
      
      private var S1:Array;
      
      private var S2:Array;
      
      private var S3:Array;
      
      private var P:Array;
      
      private var key:ByteArray = null;
      
      public function BlowFishKey(param1:ByteArray)
      {
         super();
         this.key = param1;
         this.setKey(param1);
      }
      
      public function getBlockSize() : uint
      {
         return BLOCK_SIZE;
      }
      
      public function decrypt(param1:ByteArray, param2:uint = 0) : void
      {
         this.decryptBlock(param1,param2,param1,param2);
      }
      
      public function dispose() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < this.S0.length)
         {
            this.S0[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.S1.length)
         {
            this.S1[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.S2.length)
         {
            this.S2[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.S3.length)
         {
            this.S3[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.P.length)
         {
            this.P[_loc1_] = 0;
            _loc1_++;
         }
         this.S0 = null;
         this.S1 = null;
         this.S2 = null;
         this.S3 = null;
         this.P = null;
         _loc1_ = 0;
         while(_loc1_ < this.key.length)
         {
            this.key[_loc1_] = 0;
            _loc1_++;
         }
         this.key.length = 0;
         this.key = null;
         Memory.gc();
      }
      
      public function encrypt(param1:ByteArray, param2:uint = 0) : void
      {
         this.encryptBlock(param1,param2,param1,param2);
      }
      
      private function F(param1:uint) : uint
      {
         return (this.S0[param1 >>> 24] + this.S1[param1 >>> 16 & 255] ^ this.S2[param1 >>> 8 & 255]) + this.S3[param1 & 255];
      }
      
      private function processTable(param1:uint, param2:uint, param3:Array) : void
      {
         var _loc6_:uint = 0;
         var _loc4_:uint = param3.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            var param1:uint = param1 ^ this.P[0];
            _loc6_ = 1;
            while(_loc6_ < ROUNDS)
            {
               var param2:uint = param2 ^ this.F(param1) ^ this.P[_loc6_];
               param1 = param1 ^ this.F(param2) ^ this.P[_loc6_ + 1];
               _loc6_ = _loc6_ + 2;
            }
            param2 = param2 ^ this.P[ROUNDS + 1];
            param3[_loc5_] = param2;
            param3[_loc5_ + 1] = param1;
            param2 = param1;
            param1 = param3[_loc5_];
            _loc5_ = _loc5_ + 2;
         }
      }
      
      private function setKey(param1:ByteArray) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.S0 = KS0.concat();
         this.S1 = KS1.concat();
         this.S2 = KS2.concat();
         this.S3 = KS3.concat();
         this.P = KP.concat();
         var _loc2_:uint = param1.length;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < P_SZ)
         {
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               _loc5_ = _loc5_ << 8 | param1[_loc3_++] & 255;
               if(_loc3_ >= _loc2_)
               {
                  _loc3_ = 0;
               }
               _loc6_++;
            }
            this.P[_loc4_] = this.P[_loc4_] ^ _loc5_;
            _loc4_++;
         }
         this.processTable(0,0,this.P);
         this.processTable(this.P[P_SZ - 2],this.P[P_SZ - 1],this.S0);
         this.processTable(this.S0[SBOX_SK - 2],this.S0[SBOX_SK - 1],this.S1);
         this.processTable(this.S1[SBOX_SK - 2],this.S1[SBOX_SK - 1],this.S2);
         this.processTable(this.S2[SBOX_SK - 2],this.S2[SBOX_SK - 1],this.S3);
      }
      
      private function encryptBlock(param1:ByteArray, param2:uint, param3:ByteArray, param4:uint) : void
      {
         var _loc5_:uint = this.BytesTo32bits(param1,param2);
         var _loc6_:uint = this.BytesTo32bits(param1,param2 + 4);
         _loc5_ = _loc5_ ^ this.P[0];
         var _loc7_:uint = 1;
         while(_loc7_ < ROUNDS)
         {
            _loc6_ = _loc6_ ^ this.F(_loc5_) ^ this.P[_loc7_];
            _loc5_ = _loc5_ ^ this.F(_loc6_) ^ this.P[_loc7_ + 1];
            _loc7_ = _loc7_ + 2;
         }
         _loc6_ = _loc6_ ^ this.P[ROUNDS + 1];
         this.Bits32ToBytes(_loc6_,param3,param4);
         this.Bits32ToBytes(_loc5_,param3,param4 + 4);
      }
      
      private function decryptBlock(param1:ByteArray, param2:uint, param3:ByteArray, param4:uint) : void
      {
         var _loc5_:uint = this.BytesTo32bits(param1,param2);
         var _loc6_:uint = this.BytesTo32bits(param1,param2 + 4);
         _loc5_ = _loc5_ ^ this.P[ROUNDS + 1];
         var _loc7_:uint = ROUNDS;
         while(_loc7_ > 0)
         {
            _loc6_ = _loc6_ ^ this.F(_loc5_) ^ this.P[_loc7_];
            _loc5_ = _loc5_ ^ this.F(_loc6_) ^ this.P[_loc7_ - 1];
            _loc7_ = _loc7_ - 2;
         }
         _loc6_ = _loc6_ ^ this.P[0];
         this.Bits32ToBytes(_loc6_,param3,param4);
         this.Bits32ToBytes(_loc5_,param3,param4 + 4);
      }
      
      private function BytesTo32bits(param1:ByteArray, param2:uint) : uint
      {
         return (param1[param2] & 255) << 24 | (param1[param2 + 1] & 255) << 16 | (param1[param2 + 2] & 255) << 8 | param1[param2 + 3] & 255;
      }
      
      private function Bits32ToBytes(param1:uint, param2:ByteArray, param3:uint) : void
      {
         param2[param3 + 3] = param1;
         param2[param3 + 2] = param1 >> 8;
         param2[param3 + 1] = param1 >> 16;
         param2[param3] = param1 >> 24;
      }
      
      public function toString() : String
      {
         return "blowfish";
      }
   }
}
