package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import blix.action.IAction;
   import mx.core.Singleton;
   import flash.utils.getQualifiedClassName;
   import mx.managers.ICursorManager;
   import com.riotgames.pvpnet.system.cursor.FlexCursorManagerDelegate;
   import com.riotgames.pvpnet.system.cursor.NativeCursors;
   
   public class InitializeCursorManagerAction extends BasicAction implements IAction
   {
      
      public function InitializeCursorManagerAction()
      {
         super(false);
      }
      
      override protected function doInvocation() : void
      {
         Singleton.registerClass(getQualifiedClassName(ICursorManager),FlexCursorManagerDelegate);
         NativeCursors.initialize();
         complete();
      }
   }
}
