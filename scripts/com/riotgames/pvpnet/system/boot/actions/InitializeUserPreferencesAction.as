package com.riotgames.pvpnet.system.boot.actions
{
   import blix.action.BasicAction;
   import flash.filesystem.File;
   import blix.action.FileStreamAction;
   import com.riotgames.platform.gameclient.domain.GlobalPrefs;
   import flash.utils.ByteArray;
   import flash.errors.EOFError;
   import com.riotgames.pvpnet.system.config.UserPreferencesManager;
   import com.riotgames.riot_internal;
   import blix.action.IAction;
   import flash.net.registerClassAlias;
   
   public class InitializeUserPreferencesAction extends BasicAction
   {
      
      private var _globalPrefsFile:File;
      
      var _fileStreamAction:FileStreamAction;
      
      public function InitializeUserPreferencesAction(param1:File)
      {
         this._fileStreamAction = new FileStreamAction();
         super(false);
         this._globalPrefsFile = param1;
         registerClassAlias("com.riotgames.platform.gameclient.domain.GlobalPrefs",GlobalPrefs);
      }
      
      override protected function doInvocation() : void
      {
         this._fileStreamAction.file = this._globalPrefsFile;
         this._fileStreamAction.unmarshallDataFunction = this.unmarshallGlobalPrefsObject;
         this._fileStreamAction.getCompleted().add(this.applyGlobalPrefs);
         this._fileStreamAction.getErred().add(this.fileStreamErredHandler);
         this._fileStreamAction.invoke();
      }
      
      private function unmarshallGlobalPrefsObject(param1:ByteArray) : GlobalPrefs
      {
         var obj:GlobalPrefs = null;
         var data:ByteArray = param1;
         try
         {
            obj = data.readObject() as GlobalPrefs;
         }
         catch(e:EOFError)
         {
            obj = new GlobalPrefs();
         }
         return obj;
      }
      
      private function applyGlobalPrefs(param1:FileStreamAction) : void
      {
         var _loc2_:GlobalPrefs = param1.unmarshalledData;
         if(_loc2_ == null)
         {
            _loc2_ = new GlobalPrefs();
         }
         UserPreferencesManager.riot_internal::setGlobalPrefs(_loc2_);
         complete();
      }
      
      private function fileStreamErredHandler(param1:IAction) : void
      {
         UserPreferencesManager.riot_internal::setGlobalPrefs(new GlobalPrefs());
         complete();
      }
   }
}
