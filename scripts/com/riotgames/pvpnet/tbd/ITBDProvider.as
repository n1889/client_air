package com.riotgames.pvpnet.tbd
{
   import com.riotgames.platform.provider.IProvider;
   import mx.core.UIComponent;
   
   public interface ITBDProvider extends IProvider
   {
      
      function enterViewAsCaptain(param1:UIComponent) : void;
      
      function enterViewAsInvitee(param1:UIComponent) : void;
      
      function isModuleActive() : Boolean;
      
      function quit(param1:Function = null, param2:Function = null) : void;
   }
}
