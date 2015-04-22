package com.riotgames.pvpnet.spells
{
   import com.riotgames.platform.provider.ProviderLookup;
   
   public class SpellsProviderProxy extends Object
   {
      
      public function SpellsProviderProxy()
      {
         super();
      }
      
      public static function get instance() : ISpellsProvider
      {
         return ProviderLookup.getProviderProxy(ISpellsProvider);
      }
   }
}
