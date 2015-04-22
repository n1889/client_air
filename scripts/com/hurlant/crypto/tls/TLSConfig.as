package com.hurlant.crypto.tls
{
   import flash.utils.ByteArray;
   import com.hurlant.crypto.rsa.RSAKey;
   import com.hurlant.crypto.cert.X509CertificateCollection;
   import com.hurlant.crypto.cert.X509Certificate;
   import com.hurlant.util.der.PEM;
   import com.hurlant.crypto.cert.MozillaRootCertificates;
   
   public class TLSConfig extends Object
   {
      
      public var entity:uint;
      
      public var certificate:ByteArray;
      
      public var privateKey:RSAKey;
      
      public var cipherSuites:Array;
      
      public var compressions:Array;
      
      public var CAStore:X509CertificateCollection;
      
      public var expectedCertificate:X509Certificate;
      
      protected var _acceptSelfSignedCert:Boolean;
      
      public function TLSConfig(param1:uint, param2:Array = null, param3:Array = null, param4:ByteArray = null, param5:RSAKey = null, param6:X509CertificateCollection = null)
      {
         super();
         this.entity = param1;
         this.cipherSuites = param2;
         this.compressions = param3;
         this.certificate = param4;
         this.privateKey = param5;
         this.CAStore = param6;
         if(param2 == null)
         {
            this.cipherSuites = CipherSuites.getDefaultSuites();
         }
         if(param3 == null)
         {
            this.compressions = [TLSSecurityParameters.COMPRESSION_NULL];
         }
         if(param6 == null)
         {
            this.CAStore = new MozillaRootCertificates();
         }
      }
      
      public function setPEMCertificate(param1:String, param2:String = null) : void
      {
         if(param2 == null)
         {
            var param2:String = param1;
         }
         this.certificate = PEM.readCertIntoArray(param1);
         this.privateKey = PEM.readRSAPrivateKey(param2);
      }
      
      public function get acceptSelfSignedCert() : Boolean
      {
         return this._acceptSelfSignedCert;
      }
      
      public function set acceptSelfSignedCert(param1:Boolean) : void
      {
         this._acceptSelfSignedCert = param1;
      }
   }
}
