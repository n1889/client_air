package caurina.transitions
{
   import flash.display.*;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Tweener extends Object
   {
      
      private static var _timeScale:Number = 1;
      
      private static var _specialPropertySplitterList:Object;
      
      private static var _engineExists:Boolean = false;
      
      private static var _specialPropertyModifierList:Object;
      
      private static var _currentTime:Number;
      
      private static var _tweenList:Array;
      
      private static var _specialPropertyList:Object;
      
      private static var _transitionList:Object;
      
      private static var _inited:Boolean = false;
      
      private static var __tweener_controller__:MovieClip;
      
      public function Tweener()
      {
         super();
         trace("Tweener is a static class and should not be instantiated.");
      }
      
      public static function registerSpecialPropertyModifier(p_name:String, p_modifyFunction:Function, p_getFunction:Function) : void
      {
         var spm:SpecialPropertyModifier = null;
         if(!_inited)
         {
            init();
         }
         spm = new SpecialPropertyModifier(p_modifyFunction,p_getFunction);
         _specialPropertyModifierList[p_name] = spm;
      }
      
      public static function registerSpecialProperty(p_name:String, p_getFunction:Function, p_setFunction:Function, p_parameters:Array = null) : void
      {
         var sp:SpecialProperty = null;
         if(!_inited)
         {
            init();
         }
         sp = new SpecialProperty(p_getFunction,p_setFunction,p_parameters);
         _specialPropertyList[p_name] = sp;
      }
      
      public static function addCaller(p_arg1:Object = null, p_arg2:Object = null) : Boolean
      {
         var rScopes:Array = null;
         var i:* = NaN;
         var j:* = NaN;
         var p_obj:Object = null;
         var rTime:* = NaN;
         var rDelay:* = NaN;
         var rTransition:Function = null;
         var nTween:TweenListObj = null;
         var myT:* = NaN;
         var trans:String = null;
         if((arguments.length < 2) || (arguments[0] == undefined))
         {
            return false;
         }
         rScopes = new Array();
         if(arguments[0] is Array)
         {
            i = 0;
            while(i < arguments[0].length)
            {
               rScopes.push(arguments[0][i]);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < arguments.length - 1)
            {
               rScopes.push(arguments[i]);
               i++;
            }
         }
         p_obj = arguments[arguments.length - 1];
         if(!_inited)
         {
            init();
         }
         if((!_engineExists) || (!Boolean(__tweener_controller__)))
         {
            startEngine();
         }
         rTime = isNaN(p_obj.time)?0:p_obj.time;
         rDelay = isNaN(p_obj.delay)?0:p_obj.delay;
         if(typeof p_obj.transition == "string")
         {
            trans = p_obj.transition.toLowerCase();
            rTransition = _transitionList[trans];
         }
         else
         {
            rTransition = p_obj.transition;
         }
         if(!Boolean(rTransition))
         {
            rTransition = _transitionList["easeoutexpo"];
         }
         i = 0;
         while(i < rScopes.length)
         {
            nTween = new TweenListObj(rScopes[i],_currentTime + rDelay * 1000 / _timeScale,_currentTime + (rDelay * 1000 + rTime * 1000) / _timeScale,p_obj.useFrames == true,rTransition);
            nTween.properties = null;
            nTween.onStart = p_obj.onStart;
            nTween.onUpdate = p_obj.onUpdate;
            nTween.onComplete = p_obj.onComplete;
            nTween.onOverwrite = p_obj.onOverwrite;
            nTween.onStartParams = p_obj.onStartParams;
            nTween.onUpdateParams = p_obj.onUpdateParams;
            nTween.onCompleteParams = p_obj.onCompleteParams;
            nTween.onOverwriteParams = p_obj.onOverwriteParams;
            nTween.isCaller = true;
            nTween.count = p_obj.count;
            nTween.waitFrames = p_obj.waitFrames;
            _tweenList.push(nTween);
            if((rTime == 0) && (rDelay == 0))
            {
               myT = _tweenList.length - 1;
               updateTweenByIndex(myT);
               removeTweenByIndex(myT);
            }
            i++;
         }
         return true;
      }
      
      public static function init(p_object:* = null) : void
      {
         _inited = true;
         _transitionList = new Object();
         Equations.init();
         _specialPropertyList = new Object();
         _specialPropertyModifierList = new Object();
         _specialPropertySplitterList = new Object();
         SpecialPropertiesDefault.init();
      }
      
      private static function updateTweens() : Boolean
      {
         var i:* = 0;
         if(_tweenList.length == 0)
         {
            return false;
         }
         i = 0;
         while(i < _tweenList.length)
         {
            if((_tweenList[i] == undefined) || (!_tweenList[i].isPaused))
            {
               if(!updateTweenByIndex(i))
               {
                  removeTweenByIndex(i);
               }
               if(_tweenList[i] == null)
               {
                  removeTweenByIndex(i,true);
                  i--;
               }
            }
            i++;
         }
         return true;
      }
      
      public static function removeTweens(p_scope:Object, ... args) : Boolean
      {
         var properties:Array = null;
         var i:uint = 0;
         properties = new Array();
         i = 0;
         while(i < args.length)
         {
            if((typeof args[i] == "string") && (!AuxFunctions.isInArray(args[i],properties)))
            {
               properties.push(args[i]);
            }
            i++;
         }
         return affectTweens(removeTweenByIndex,p_scope,properties);
      }
      
      public static function pauseAllTweens() : Boolean
      {
         var paused:* = false;
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         paused = false;
         i = 0;
         while(i < _tweenList.length)
         {
            pauseTweenByIndex(i);
            paused = true;
            i++;
         }
         return paused;
      }
      
      public static function splitTweens(p_tween:Number, p_properties:Array) : uint
      {
         var originalTween:TweenListObj = null;
         var newTween:TweenListObj = null;
         var i:uint = 0;
         var pName:String = null;
         var found:* = false;
         originalTween = _tweenList[p_tween];
         newTween = originalTween.clone(false);
         i = 0;
         while(i < p_properties.length)
         {
            pName = p_properties[i];
            if(Boolean(originalTween.properties[pName]))
            {
               originalTween.properties[pName] = undefined;
               delete originalTween.properties[pName];
               true;
            }
            i++;
         }
         for(pName in newTween.properties)
         {
            found = false;
            i = 0;
            while(i < p_properties.length)
            {
               if(p_properties[i] == pName)
               {
                  found = true;
                  break;
               }
               i++;
            }
            if(!found)
            {
               newTween.properties[pName] = undefined;
               delete newTween.properties[pName];
               true;
            }
         }
         _tweenList.push(newTween);
         return _tweenList.length - 1;
      }
      
      public static function resumeTweenByIndex(p_tween:Number) : Boolean
      {
         var tTweening:TweenListObj = null;
         tTweening = _tweenList[p_tween];
         if((tTweening == null) || (!tTweening.isPaused))
         {
            return false;
         }
         tTweening.timeStart = tTweening.timeStart + (_currentTime - tTweening.timePaused);
         tTweening.timeComplete = tTweening.timeComplete + (_currentTime - tTweening.timePaused);
         tTweening.timePaused = undefined;
         tTweening.isPaused = false;
         return true;
      }
      
      public static function debug_getList() : String
      {
         var ttl:String = null;
         var i:uint = 0;
         var k:uint = 0;
         ttl = "";
         i = 0;
         while(i < _tweenList.length)
         {
            ttl = ttl + ("[" + i + "] ::\n");
            k = 0;
            while(k < _tweenList[i].properties.length)
            {
               ttl = ttl + ("  " + _tweenList[i].properties[k].name + " -> " + _tweenList[i].properties[k].valueComplete + "\n");
               k++;
            }
            i++;
         }
         return ttl;
      }
      
      public static function getVersion() : String
      {
         return "AS3 1.26.62";
      }
      
      public static function onEnterFrame(e:Event) : void
      {
         var hasUpdated:* = false;
         updateTime();
         hasUpdated = false;
         hasUpdated = updateTweens();
         if(!hasUpdated)
         {
            stopEngine();
         }
      }
      
      public static function updateTime() : void
      {
         _currentTime = getTimer();
      }
      
      private static function updateTweenByIndex(i:Number) : Boolean
      {
         var tTweening:TweenListObj = null;
         var isOver:Boolean = false;
         var mustUpdate:Boolean = false;
         var nv:Number = NaN;
         var t:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var d:Number = NaN;
         var pName:String = null;
         var tScope:Object = null;
         var tProperty:Object = null;
         var pv:Number = NaN;
         tTweening = _tweenList[i];
         if((tTweening == null) || (!Boolean(tTweening.scope)))
         {
            return false;
         }
         isOver = false;
         if(_currentTime >= tTweening.timeStart)
         {
            tScope = tTweening.scope;
            if(tTweening.isCaller)
            {
               do
               {
                  t = (tTweening.timeComplete - tTweening.timeStart) / tTweening.count * (tTweening.timesCalled + 1);
                  b = tTweening.timeStart;
                  c = tTweening.timeComplete - tTweening.timeStart;
                  d = tTweening.timeComplete - tTweening.timeStart;
                  nv = tTweening.transition(t,b,c,d);
                  if(_currentTime >= nv)
                  {
                     if(Boolean(tTweening.onUpdate))
                     {
                        try
                        {
                           tTweening.onUpdate.apply(tScope,tTweening.onUpdateParams);
                        }
                        catch(e:Error)
                        {
                           handleError(tTweening,e,"onUpdate");
                        }
                     }
                     tTweening.timesCalled++;
                     if(tTweening.timesCalled >= tTweening.count)
                     {
                        isOver = true;
                        break;
                     }
                     if(tTweening.waitFrames)
                     {
                        break;
                     }
                  }
               }
               while(_currentTime >= nv);
               
            }
            else
            {
               mustUpdate = (tTweening.skipUpdates < 1) || (!tTweening.skipUpdates) || (tTweening.updatesSkipped >= tTweening.skipUpdates);
               if(_currentTime >= tTweening.timeComplete)
               {
                  isOver = true;
                  mustUpdate = true;
               }
               if(!tTweening.hasStarted)
               {
                  if(Boolean(tTweening.onStart))
                  {
                     try
                     {
                        tTweening.onStart.apply(tScope,tTweening.onStartParams);
                     }
                     catch(e:Error)
                     {
                        handleError(tTweening,e,"onStart");
                     }
                  }
                  for(pName in tTweening.properties)
                  {
                     pv = getPropertyValue(tScope,pName);
                     tTweening.properties[pName].valueStart = isNaN(pv)?tTweening.properties[pName].valueComplete:pv;
                  }
                  mustUpdate = true;
                  tTweening.hasStarted = true;
               }
               if(mustUpdate)
               {
                  for(pName in tTweening.properties)
                  {
                     tProperty = tTweening.properties[pName];
                     if(isOver)
                     {
                        nv = tProperty.valueComplete;
                     }
                     else if(tProperty.hasModifier)
                     {
                        t = _currentTime - tTweening.timeStart;
                        d = tTweening.timeComplete - tTweening.timeStart;
                        nv = tTweening.transition(t,0,1,d);
                        nv = tProperty.modifierFunction(tProperty.valueStart,tProperty.valueComplete,nv,tProperty.modifierParameters);
                     }
                     else
                     {
                        t = _currentTime - tTweening.timeStart;
                        b = tProperty.valueStart;
                        c = tProperty.valueComplete - tProperty.valueStart;
                        d = tTweening.timeComplete - tTweening.timeStart;
                        nv = tTweening.transition(t,b,c,d);
                     }
                     
                     if(tTweening.rounded)
                     {
                        nv = Math.round(nv);
                     }
                     setPropertyValue(tScope,pName,nv);
                  }
                  tTweening.updatesSkipped = 0;
                  if(Boolean(tTweening.onUpdate))
                  {
                     try
                     {
                        tTweening.onUpdate.apply(tScope,tTweening.onUpdateParams);
                     }
                     catch(e:Error)
                     {
                        handleError(tTweening,e,"onUpdate");
                     }
                  }
               }
               else
               {
                  tTweening.updatesSkipped++;
               }
            }
            if((isOver) && (Boolean(tTweening.onComplete)))
            {
               try
               {
                  tTweening.onComplete.apply(tScope,tTweening.onCompleteParams);
               }
               catch(e:Error)
               {
                  handleError(tTweening,e,"onComplete");
               }
            }
            return !isOver;
         }
         return true;
      }
      
      public static function setTimeScale(p_time:Number) : void
      {
         var i:* = NaN;
         if(isNaN(p_time))
         {
            var p_time:Number = 1;
         }
         if(p_time < 1.0E-5)
         {
            p_time = 1.0E-5;
         }
         if(p_time != _timeScale)
         {
            if(_tweenList != null)
            {
               i = 0;
               while(i < _tweenList.length)
               {
                  _tweenList[i].timeStart = _currentTime - (_currentTime - _tweenList[i].timeStart) * _timeScale / p_time;
                  _tweenList[i].timeComplete = _currentTime - (_currentTime - _tweenList[i].timeComplete) * _timeScale / p_time;
                  if(_tweenList[i].timePaused != undefined)
                  {
                     _tweenList[i].timePaused = _currentTime - (_currentTime - _tweenList[i].timePaused) * _timeScale / p_time;
                  }
                  i++;
               }
            }
            _timeScale = p_time;
         }
      }
      
      public static function resumeAllTweens() : Boolean
      {
         var resumed:* = false;
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         resumed = false;
         i = 0;
         while(i < _tweenList.length)
         {
            resumeTweenByIndex(i);
            resumed = true;
            i++;
         }
         return resumed;
      }
      
      private static function handleError(pTweening:TweenListObj, pError:Error, pCallBackName:String) : void
      {
         if((Boolean(pTweening.onError)) && (pTweening.onError is Function))
         {
            try
            {
               pTweening.onError.apply(pTweening.scope,[pTweening.scope,pError]);
            }
            catch(metaError:Error)
            {
               trace("## [Tweener] Error:",pTweening.scope,"raised an error while executing the \'onError\' handler. Original error:\n",pError.getStackTrace(),"\nonError error:",metaError.getStackTrace());
            }
         }
         else if(!Boolean(pTweening.onError))
         {
            trace("## [Tweener] Error: :",pTweening.scope,"raised an error while executing the\'" + pCallBackName + "\'handler. \n",pError.getStackTrace());
         }
         
      }
      
      private static function startEngine() : void
      {
         _engineExists = true;
         _tweenList = new Array();
         __tweener_controller__ = new MovieClip();
         __tweener_controller__.addEventListener(Event.ENTER_FRAME,Tweener.onEnterFrame);
         updateTime();
      }
      
      public static function removeAllTweens() : Boolean
      {
         var removed:* = false;
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         removed = false;
         i = 0;
         while(i < _tweenList.length)
         {
            removeTweenByIndex(i);
            removed = true;
            i++;
         }
         return removed;
      }
      
      public static function addTween(p_arg1:Object = null, p_arg2:Object = null) : Boolean
      {
         var rScopes:Array = null;
         var i:* = NaN;
         var j:* = NaN;
         var istr:String = null;
         var jstr:String = null;
         var p_obj:Object = null;
         var rTime:* = NaN;
         var rDelay:* = NaN;
         var rProperties:Array = null;
         var restrictedWords:Object = null;
         var modifiedProperties:Object = null;
         var rTransition:Function = null;
         var nProperties:Object = null;
         var nTween:TweenListObj = null;
         var myT:* = NaN;
         var splitProperties:Array = null;
         var tempModifiedProperties:Array = null;
         var trans:String = null;
         if((arguments.length < 2) || (arguments[0] == undefined))
         {
            return false;
         }
         rScopes = new Array();
         if(arguments[0] is Array)
         {
            i = 0;
            while(i < arguments[0].length)
            {
               rScopes.push(arguments[0][i]);
               i++;
            }
         }
         else
         {
            i = 0;
            while(i < arguments.length - 1)
            {
               rScopes.push(arguments[i]);
               i++;
            }
         }
         p_obj = TweenListObj.makePropertiesChain(arguments[arguments.length - 1]);
         if(!_inited)
         {
            init();
         }
         if((!_engineExists) || (!Boolean(__tweener_controller__)))
         {
            startEngine();
         }
         rTime = isNaN(p_obj.time)?0:p_obj.time;
         rDelay = isNaN(p_obj.delay)?0:p_obj.delay;
         rProperties = new Array();
         restrictedWords = {
            "time":true,
            "delay":true,
            "useFrames":true,
            "skipUpdates":true,
            "transition":true,
            "onStart":true,
            "onUpdate":true,
            "onComplete":true,
            "onOverwrite":true,
            "rounded":true,
            "onStartParams":true,
            "onUpdateParams":true,
            "onCompleteParams":true,
            "onOverwriteParams":true
         };
         modifiedProperties = new Object();
         for(istr in p_obj)
         {
            if(!restrictedWords[istr])
            {
               if(_specialPropertySplitterList[istr])
               {
                  splitProperties = _specialPropertySplitterList[istr].splitValues(p_obj[istr],_specialPropertySplitterList[istr].parameters);
                  i = 0;
                  while(i < splitProperties.length)
                  {
                     rProperties[splitProperties[i].name] = {
                        "valueStart":undefined,
                        "valueComplete":splitProperties[i].value
                     };
                     i++;
                  }
               }
               else if(_specialPropertyModifierList[istr] != undefined)
               {
                  tempModifiedProperties = _specialPropertyModifierList[istr].modifyValues(p_obj[istr]);
                  i = 0;
                  while(i < tempModifiedProperties.length)
                  {
                     modifiedProperties[tempModifiedProperties[i].name] = {
                        "modifierParameters":tempModifiedProperties[i].parameters,
                        "modifierFunction":_specialPropertyModifierList[istr].getValue
                     };
                     i++;
                  }
               }
               else
               {
                  rProperties[istr] = {
                     "valueStart":undefined,
                     "valueComplete":p_obj[istr]
                  };
               }
               
            }
         }
         for(istr in modifiedProperties)
         {
            if(rProperties[istr] != undefined)
            {
               rProperties[istr].modifierParameters = modifiedProperties[istr].modifierParameters;
               rProperties[istr].modifierFunction = modifiedProperties[istr].modifierFunction;
            }
         }
         if(typeof p_obj.transition == "string")
         {
            trans = p_obj.transition.toLowerCase();
            rTransition = _transitionList[trans];
         }
         else
         {
            rTransition = p_obj.transition;
         }
         if(!Boolean(rTransition))
         {
            rTransition = _transitionList["easeoutexpo"];
         }
         i = 0;
         while(i < rScopes.length)
         {
            nProperties = new Object();
            for(istr in rProperties)
            {
               nProperties[istr] = new PropertyInfoObj(rProperties[istr].valueStart,rProperties[istr].valueComplete,rProperties[istr].modifierFunction,rProperties[istr].modifierParameters);
            }
            nTween = new TweenListObj(rScopes[i],_currentTime + rDelay * 1000 / _timeScale,_currentTime + (rDelay * 1000 + rTime * 1000) / _timeScale,p_obj.useFrames == true,rTransition);
            nTween.properties = nProperties;
            nTween.onStart = p_obj.onStart;
            nTween.onUpdate = p_obj.onUpdate;
            nTween.onComplete = p_obj.onComplete;
            nTween.onOverwrite = p_obj.onOverwrite;
            nTween.onError = p_obj.onError;
            nTween.onStartParams = p_obj.onStartParams;
            nTween.onUpdateParams = p_obj.onUpdateParams;
            nTween.onCompleteParams = p_obj.onCompleteParams;
            nTween.onOverwriteParams = p_obj.onOverwriteParams;
            nTween.rounded = p_obj.rounded;
            nTween.skipUpdates = p_obj.skipUpdates;
            removeTweensByTime(nTween.scope,nTween.properties,nTween.timeStart,nTween.timeComplete);
            _tweenList.push(nTween);
            if((rTime == 0) && (rDelay == 0))
            {
               myT = _tweenList.length - 1;
               updateTweenByIndex(myT);
               removeTweenByIndex(myT);
            }
            i++;
         }
         return true;
      }
      
      public static function registerTransition(p_name:String, p_function:Function) : void
      {
         if(!_inited)
         {
            init();
         }
         _transitionList[p_name] = p_function;
      }
      
      private static function affectTweens(p_affectFunction:Function, p_scope:Object, p_properties:Array) : Boolean
      {
         var affected:* = false;
         var i:uint = 0;
         var affectedProperties:Array = null;
         var j:uint = 0;
         var objectProperties:uint = 0;
         var slicedTweenIndex:uint = 0;
         affected = false;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         i = 0;
         while(i < _tweenList.length)
         {
            if((_tweenList[i]) && (_tweenList[i].scope == p_scope))
            {
               if(p_properties.length == 0)
               {
                  p_affectFunction(i);
                  affected = true;
               }
               else
               {
                  affectedProperties = new Array();
                  j = 0;
                  while(j < p_properties.length)
                  {
                     if(Boolean(_tweenList[i].properties[p_properties[j]]))
                     {
                        affectedProperties.push(p_properties[j]);
                     }
                     j++;
                  }
                  if(affectedProperties.length > 0)
                  {
                     objectProperties = AuxFunctions.getObjectLength(_tweenList[i].properties);
                     if(objectProperties == affectedProperties.length)
                     {
                        p_affectFunction(i);
                        affected = true;
                     }
                     else
                     {
                        slicedTweenIndex = splitTweens(i,affectedProperties);
                        p_affectFunction(slicedTweenIndex);
                        affected = true;
                     }
                  }
               }
            }
            i++;
         }
         return affected;
      }
      
      public static function getTweens(p_scope:Object) : Array
      {
         var i:uint = 0;
         var pName:String = null;
         var tList:Array = null;
         if(!Boolean(_tweenList))
         {
            return [];
         }
         tList = new Array();
         i = 0;
         while(i < _tweenList.length)
         {
            if(_tweenList[i].scope == p_scope)
            {
               for(pName in _tweenList[i].properties)
               {
                  tList.push(pName);
               }
            }
            i++;
         }
         return tList;
      }
      
      private static function setPropertyValue(p_obj:Object, p_prop:String, p_value:Number) : void
      {
         if(_specialPropertyList[p_prop] != undefined)
         {
            if(Boolean(_specialPropertyList[p_prop].parameters))
            {
               _specialPropertyList[p_prop].setValue(p_obj,p_value,_specialPropertyList[p_prop].parameters);
            }
            else
            {
               _specialPropertyList[p_prop].setValue(p_obj,p_value);
            }
         }
         else
         {
            p_obj[p_prop] = p_value;
         }
      }
      
      private static function getPropertyValue(p_obj:Object, p_prop:String) : Number
      {
         if(_specialPropertyList[p_prop] != undefined)
         {
            if(Boolean(_specialPropertyList[p_prop].parameters))
            {
               return _specialPropertyList[p_prop].getValue(p_obj,_specialPropertyList[p_prop].parameters);
            }
            return _specialPropertyList[p_prop].getValue(p_obj);
         }
         return p_obj[p_prop];
      }
      
      public static function isTweening(p_scope:Object) : Boolean
      {
         var i:uint = 0;
         if(!Boolean(_tweenList))
         {
            return false;
         }
         i = 0;
         while(i < _tweenList.length)
         {
            if(_tweenList[i].scope == p_scope)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public static function getTweenCount(p_scope:Object) : Number
      {
         var i:uint = 0;
         var c:* = NaN;
         if(!Boolean(_tweenList))
         {
            return 0;
         }
         c = 0;
         i = 0;
         while(i < _tweenList.length)
         {
            if(_tweenList[i].scope == p_scope)
            {
               c = c + AuxFunctions.getObjectLength(_tweenList[i].properties);
            }
            i++;
         }
         return c;
      }
      
      private static function stopEngine() : void
      {
         _engineExists = false;
         _tweenList = null;
         _currentTime = 0;
         __tweener_controller__.removeEventListener(Event.ENTER_FRAME,Tweener.onEnterFrame);
         __tweener_controller__ = null;
      }
      
      public static function pauseTweenByIndex(p_tween:Number) : Boolean
      {
         var tTweening:TweenListObj = null;
         tTweening = _tweenList[p_tween];
         if((tTweening == null) || (tTweening.isPaused))
         {
            return false;
         }
         tTweening.timePaused = _currentTime;
         tTweening.isPaused = true;
         return true;
      }
      
      public static function removeTweensByTime(p_scope:Object, p_properties:Object, p_timeStart:Number, p_timeComplete:Number) : Boolean
      {
         var removed:Boolean = false;
         var removedLocally:Boolean = false;
         var i:uint = 0;
         var tl:uint = 0;
         var pName:String = null;
         removed = false;
         tl = _tweenList.length;
         i = 0;
         while(i < tl)
         {
            if((Boolean(_tweenList[i])) && (p_scope == _tweenList[i].scope))
            {
               if((p_timeComplete > _tweenList[i].timeStart) && (p_timeStart < _tweenList[i].timeComplete))
               {
                  removedLocally = false;
                  for(pName in _tweenList[i].properties)
                  {
                     if(Boolean(p_properties[pName]))
                     {
                        if(Boolean(_tweenList[i].onOverwrite))
                        {
                           try
                           {
                              _tweenList[i].onOverwrite.apply(_tweenList[i].scope,_tweenList[i].onOverwriteParams);
                           }
                           catch(e:Error)
                           {
                              handleError(_tweenList[i],e,"onOverwrite");
                           }
                        }
                        _tweenList[i].properties[pName] = undefined;
                        delete _tweenList[i].properties[pName];
                        true;
                        removedLocally = true;
                        removed = true;
                     }
                  }
                  if(removedLocally)
                  {
                     if(AuxFunctions.getObjectLength(_tweenList[i].properties) == 0)
                     {
                        removeTweenByIndex(i);
                     }
                  }
               }
            }
            i++;
         }
         return removed;
      }
      
      public static function registerSpecialPropertySplitter(p_name:String, p_splitFunction:Function, p_parameters:Array = null) : void
      {
         var sps:SpecialPropertySplitter = null;
         if(!_inited)
         {
            init();
         }
         sps = new SpecialPropertySplitter(p_splitFunction,p_parameters);
         _specialPropertySplitterList[p_name] = sps;
      }
      
      public static function removeTweenByIndex(i:Number, p_finalRemoval:Boolean = false) : Boolean
      {
         _tweenList[i] = null;
         if(p_finalRemoval)
         {
            _tweenList.splice(i,1);
         }
         return true;
      }
      
      public static function resumeTweens(p_scope:Object, ... args) : Boolean
      {
         var properties:Array = null;
         var i:uint = 0;
         properties = new Array();
         i = 0;
         while(i < args.length)
         {
            if((typeof args[i] == "string") && (!AuxFunctions.isInArray(args[i],properties)))
            {
               properties.push(args[i]);
            }
            i++;
         }
         return affectTweens(resumeTweenByIndex,p_scope,properties);
      }
      
      public static function pauseTweens(p_scope:Object, ... args) : Boolean
      {
         var properties:Array = null;
         var i:uint = 0;
         properties = new Array();
         i = 0;
         while(i < args.length)
         {
            if((typeof args[i] == "string") && (!AuxFunctions.isInArray(args[i],properties)))
            {
               properties.push(args[i]);
            }
            i++;
         }
         return affectTweens(pauseTweenByIndex,p_scope,properties);
      }
   }
}
