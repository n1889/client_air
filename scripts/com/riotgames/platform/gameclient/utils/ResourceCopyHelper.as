package com.riotgames.platform.gameclient.utils
{
   import flash.filesystem.File;
   
   public class ResourceCopyHelper extends Object
   {
      
      public var from:File;
      
      public var to:File;
      
      public function ResourceCopyHelper()
      {
         super();
         this.to = File.applicationDirectory;
         this.from = File.applicationDirectory;
      }
      
      public function copyResources() : void
      {
         var current:FilePair = null;
         var listing:Array = null;
         var subFile:File = null;
         var newPair:FilePair = null;
         var relativePath:String = null;
         var pendingFiles:Array = [new FilePair(this.from,this.to)];
         while(pendingFiles.length > 0)
         {
            current = pendingFiles.shift();
            if(current.from.isDirectory)
            {
               listing = current.from.getDirectoryListing();
               for each(subFile in listing)
               {
                  relativePath = current.from.getRelativePath(subFile);
                  newPair = new FilePair(subFile,File.applicationStorageDirectory.resolvePath(current.to.resolvePath(relativePath).nativePath));
                  pendingFiles.push(newPair);
               }
            }
            else
            {
               try
               {
                  current.from.copyTo(current.to,true);
               }
               catch(e:Error)
               {
                  continue;
               }
            }
         }
      }
   }
}

import flash.filesystem.File;

class FilePair extends Object
{
   
   public var from:File;
   
   public var to:File;
   
   function FilePair(param1:File, param2:File)
   {
      super();
      this.from = param1;
      this.to = param2;
   }
}
