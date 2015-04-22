package caurina.transitions
{
   public class TweenListObj extends Object
   {
      
      public var onUpdate:Function;
      
      public var useFrames:Boolean;
      
      public var hasStarted:Boolean;
      
      public var onOverwriteParams:Array;
      
      public var timeStart:Number;
      
      public var count:Number;
      
      public var auxProperties:Object;
      
      public var timeComplete:Number;
      
      public var onStartParams:Array;
      
      public var rounded:Boolean;
      
      public var properties:Object;
      
      public var onUpdateParams:Array;
      
      public var onComplete:Function;
      
      public var updatesSkipped:Number;
      
      public var onStart:Function;
      
      public var skipUpdates:Number;
      
      public var scope:Object;
      
      public var isCaller:Boolean;
      
      public var timePaused:Number;
      
      public var transition:Function;
      
      public var onCompleteParams:Array;
      
      public var onError:Function;
      
      public var timesCalled:Number;
      
      public var onOverwrite:Function;
      
      public var isPaused:Boolean;
      
      public var waitFrames:Boolean;
      
      public function TweenListObj(p_scope:Object, p_timeStart:Number, p_timeComplete:Number, p_useFrames:Boolean, p_transition:Function)
      {
         super();
         scope = p_scope;
         timeStart = p_timeStart;
         timeComplete = p_timeComplete;
         useFrames = p_useFrames;
         transition = p_transition;
         auxProperties = new Object();
         properties = new Object();
         isPaused = false;
         timePaused = undefined;
         isCaller = false;
         updatesSkipped = 0;
         timesCalled = 0;
         skipUpdates = 0;
         hasStarted = false;
      }
      
      public static function makePropertiesChain(p_obj:Object) : Object
      {
         var baseObject:Object = null;
         var chainedObject:Object = null;
         var chain:Object = null;
         var currChainObj:Object = null;
         var len:* = NaN;
         var i:* = NaN;
         var k:* = NaN;
         baseObject = p_obj.base;
         if(baseObject)
         {
            chainedObject = {};
            if(baseObject is Array)
            {
               chain = [];
               k = 0;
               while(k < baseObject.length)
               {
                  chain.push(baseObject[k]);
                  k++;
               }
            }
            else
            {
               chain = [baseObject];
            }
            chain.push(p_obj);
            len = chain.length;
            i = 0;
            while(i < len)
            {
               if(chain[i]["base"])
               {
                  currChainObj = AuxFunctions.concatObjects(makePropertiesChain(chain[i]["base"]),chain[i]);
               }
               else
               {
                  currChainObj = chain[i];
               }
               chainedObject = AuxFunctions.concatObjects(chainedObject,currChainObj);
               i++;
            }
            if(chainedObject["base"])
            {
               delete chainedObject["base"];
               true;
            }
            return chainedObject;
         }
         return p_obj;
      }
      
      public function clone(omitEvents:Boolean) : TweenListObj
      {
         var nTween:TweenListObj = null;
         var pName:String = null;
         nTween = new TweenListObj(scope,timeStart,timeComplete,useFrames,transition);
         nTween.properties = new Array();
         for(pName in properties)
         {
            nTween.properties[pName] = properties[pName].clone();
         }
         nTween.skipUpdates = skipUpdates;
         nTween.updatesSkipped = updatesSkipped;
         if(!omitEvents)
         {
            nTween.onStart = onStart;
            nTween.onUpdate = onUpdate;
            nTween.onComplete = onComplete;
            nTween.onOverwrite = onOverwrite;
            nTween.onError = onError;
            nTween.onStartParams = onStartParams;
            nTween.onUpdateParams = onUpdateParams;
            nTween.onCompleteParams = onCompleteParams;
            nTween.onOverwriteParams = onOverwriteParams;
         }
         nTween.rounded = rounded;
         nTween.isPaused = isPaused;
         nTween.timePaused = timePaused;
         nTween.isCaller = isCaller;
         nTween.count = count;
         nTween.timesCalled = timesCalled;
         nTween.waitFrames = waitFrames;
         nTween.hasStarted = hasStarted;
         return nTween;
      }
      
      public function toString() : String
      {
         var returnStr:String = null;
         var i:uint = 0;
         returnStr = "\n[TweenListObj ";
         returnStr = returnStr + ("scope:" + String(scope));
         returnStr = returnStr + ", properties:";
         i = 0;
         while(i < properties.length)
         {
            if(i > 0)
            {
               returnStr = returnStr + ",";
            }
            returnStr = returnStr + ("[name:" + properties[i].name);
            returnStr = returnStr + (",valueStart:" + properties[i].valueStart);
            returnStr = returnStr + (",valueComplete:" + properties[i].valueComplete);
            returnStr = returnStr + "]";
            i++;
         }
         returnStr = returnStr + (", timeStart:" + String(timeStart));
         returnStr = returnStr + (", timeComplete:" + String(timeComplete));
         returnStr = returnStr + (", useFrames:" + String(useFrames));
         returnStr = returnStr + (", transition:" + String(transition));
         if(skipUpdates)
         {
            returnStr = returnStr + (", skipUpdates:" + String(skipUpdates));
         }
         if(updatesSkipped)
         {
            returnStr = returnStr + (", updatesSkipped:" + String(updatesSkipped));
         }
         if(Boolean(onStart))
         {
            returnStr = returnStr + (", onStart:" + String(onStart));
         }
         if(Boolean(onUpdate))
         {
            returnStr = returnStr + (", onUpdate:" + String(onUpdate));
         }
         if(Boolean(onComplete))
         {
            returnStr = returnStr + (", onComplete:" + String(onComplete));
         }
         if(Boolean(onOverwrite))
         {
            returnStr = returnStr + (", onOverwrite:" + String(onOverwrite));
         }
         if(Boolean(onError))
         {
            returnStr = returnStr + (", onError:" + String(onError));
         }
         if(onStartParams)
         {
            returnStr = returnStr + (", onStartParams:" + String(onStartParams));
         }
         if(onUpdateParams)
         {
            returnStr = returnStr + (", onUpdateParams:" + String(onUpdateParams));
         }
         if(onCompleteParams)
         {
            returnStr = returnStr + (", onCompleteParams:" + String(onCompleteParams));
         }
         if(onOverwriteParams)
         {
            returnStr = returnStr + (", onOverwriteParams:" + String(onOverwriteParams));
         }
         if(rounded)
         {
            returnStr = returnStr + (", rounded:" + String(rounded));
         }
         if(isPaused)
         {
            returnStr = returnStr + (", isPaused:" + String(isPaused));
         }
         if(timePaused)
         {
            returnStr = returnStr + (", timePaused:" + String(timePaused));
         }
         if(isCaller)
         {
            returnStr = returnStr + (", isCaller:" + String(isCaller));
         }
         if(count)
         {
            returnStr = returnStr + (", count:" + String(count));
         }
         if(timesCalled)
         {
            returnStr = returnStr + (", timesCalled:" + String(timesCalled));
         }
         if(waitFrames)
         {
            returnStr = returnStr + (", waitFrames:" + String(waitFrames));
         }
         if(hasStarted)
         {
            returnStr = returnStr + (", hasStarted:" + String(hasStarted));
         }
         returnStr = returnStr + "]\n";
         return returnStr;
      }
   }
}
