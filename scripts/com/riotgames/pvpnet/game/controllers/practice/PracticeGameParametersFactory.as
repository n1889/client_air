package com.riotgames.pvpnet.game.controllers.practice
{
   import com.riotgames.pvpnet.system.game.PracticeGameParameters;
   import com.riotgames.pvpnet.system.game.GameFlowVariant;
   import com.riotgames.pvpnet.game.variants.GameFlowVariantFactory;
   import com.riotgames.pvpnet.system.config.cdc.ConfigurationModel;
   import com.riotgames.pvpnet.system.config.cdc.DynamicClientConfigManager;
   import com.riotgames.pvpnet.system.game.MutatorsConfiguration;
   
   public class PracticeGameParametersFactory extends Object
   {
      
      public static const CUSTOM_MODE_ID:String = "custom";
      
      private static var _instance:PracticeGameParametersFactory;
      
      private var _currentPracticeGameParameters:PracticeGameParameters;
      
      public function PracticeGameParametersFactory(param1:SingletonEnforcer)
      {
         var enforcer:SingletonEnforcer = param1;
         super();
         var modesConfigModel:ConfigurationModel = DynamicClientConfigManager.getConfiguration(MutatorsConfiguration.NAMESPACE,MutatorsConfiguration.ENABLED_MODES,false);
         modesConfigModel.getChangedSignal().add(function():*
         {
            _currentPracticeGameParameters = null;
         });
      }
      
      public static function get instance() : PracticeGameParametersFactory
      {
         if(_instance == null)
         {
            _instance = new PracticeGameParametersFactory(new SingletonEnforcer());
         }
         return _instance;
      }
      
      public function getPracticeGameParameters(param1:String) : PracticeGameParameters
      {
         if(param1 == null)
         {
            var param1:String = CUSTOM_MODE_ID;
         }
         if((this._currentPracticeGameParameters == null) || (!(this._currentPracticeGameParameters.customGameType == param1)))
         {
            this._currentPracticeGameParameters = this.create(param1);
         }
         return this._currentPracticeGameParameters;
      }
      
      public function isCustomGame(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.indexOf(CUSTOM_MODE_ID) == 0;
      }
      
      private function create(param1:String) : PracticeGameParameters
      {
         var _loc4_:Array = null;
         var _loc2_:GameFlowVariant = null;
         if(param1.indexOf(CUSTOM_MODE_ID + "_") == 0)
         {
            _loc4_ = param1.split("_");
            if(_loc4_.length == 2)
            {
               _loc2_ = GameFlowVariantFactory.instance.getVariantForGameKey(_loc4_[1]);
            }
         }
         if(_loc2_ == null)
         {
            _loc2_ = GameFlowVariantFactory.instance.getVariantForGameKey(null);
         }
         var _loc3_:PracticeGameParameters = _loc2_.createPracticeGameParameters();
         _loc3_.build();
         return _loc3_;
      }
   }
}

class SingletonEnforcer extends Object
{
   
   function SingletonEnforcer()
   {
      super();
   }
}
