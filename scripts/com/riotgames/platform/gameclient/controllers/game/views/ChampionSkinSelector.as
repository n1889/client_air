package com.riotgames.platform.gameclient.controllers.game.views
{
   import mx.containers.Canvas;
   import mx.collections.ArrayCollection;
   import mx.effects.Fade;
   import mx.events.FlexEvent;
   import mx.controls.Image;
   import com.riotgames.platform.gameclient.components.button.SoundEffectButton;
   import mx.events.PropertyChangeEvent;
   import mx.controls.Text;
   import mx.binding.*;
   import flash.accessibility.*;
   import flash.data.*;
   import flash.debugger.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filesystem.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.html.*;
   import flash.html.script.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.styles.*;
   import com.riotgames.platform.common.utils.RiotResourceLoader;
   import com.riotgames.pvpnet.system.config.SkinsConfig;
   import blix.signals.Signal;
   import mx.containers.HBox;
   import com.riotgames.platform.gameclient.controllers.game.model.PlayerSelection;
   import com.riotgames.platform.gameclient.domain.ChampionSkin;
   import blix.signals.ISignal;
   import com.riotgames.platform.gameclient.controllers.game.mediators.ChromaMediator;
   import mx.core.mx_internal;
   import mx.core.IDataRenderer;
   import com.riotgames.platform.common.provider.IChampionDetailProvider;
   import com.riotgames.platform.common.provider.ChampionDetailProviderProxy;
   import com.riotgames.platform.common.module.championdetail.ChampionDetailContext;
   import mx.core.UIComponentDescriptor;
   
   public class ChampionSkinSelector extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _195285075championSkins:ArrayCollection;
      
      private var _1282133823fadeIn:Fade;
      
      private var _skinDisplayModel:ISkinDisplayModel;
      
      private var _621071059championSkinDisabled_txt:Text;
      
      private var _1261026587championSkinUnlock_txt:Text;
      
      private var _1091436750fadeOut:Fade;
      
      private var _onSkinNavigated:Signal;
      
      private var _1187329020chromaButtonContainerHBox:HBox;
      
      var _bindingsByDestination:Object;
      
      private var _playerSelection:PlayerSelection;
      
      private var _33968542championSkinName_txt:Text;
      
      private var _renderers:Array;
      
      var _watchers:Array;
      
      private var _1116990188previous_btn:SoundEffectButton;
      
      private var _1962022921chromaPreviewImage:Image;
      
      private var _chromaMediator:ChromaMediator;
      
      private var _672824249skinNameContainer:Canvas;
      
      private var _1424721680next_btn:SoundEffectButton;
      
      private var _202312817skinsCoverFlow:SkinFlow;
      
      var _bindingsBeginWithWord:Object;
      
      var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function ChampionSkinSelector()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":SkinFlow,
                  "id":"skinsCoverFlow",
                  "events":{"creationComplete":"__skinsCoverFlow_creationComplete"},
                  "stylesFactory":function():void
                  {
                     this.horizontalCenter = "0";
                     this.horizontalSpacing = 165;
                     this.disabledOverlayAlpha = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "y":-15,
                        "width":600,
                        "height":300,
                        "reflectionEnabled":false,
                        "rotationAngle":50
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Image,
                  "id":"chromaPreviewImage",
                  "stylesFactory":function():void
                  {
                     this.left = "284";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "scaleX":1.5,
                        "scaleY":1.5,
                        "width":100,
                        "height":300
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"skinNameContainer",
                  "stylesFactory":function():void
                  {
                     this.backgroundAlpha = 0.5;
                     this.backgroundColor = 0;
                     this.bottom = "5";
                     this.left = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "cacheAsBitmap":false,
                        "verticalScrollPolicy":"off",
                        "horizontalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"chromaButtonContainerHBox",
                           "stylesFactory":function():void
                           {
                              this.horizontalCenter = "0";
                              this.horizontalAlign = "center";
                              this.top = "2";
                              this.paddingTop = 5;
                              this.paddingBottom = 5;
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"championSkinName_txt",
                           "stylesFactory":function():void
                           {
                              this.horizontalCenter = "0";
                              this.textAlign = "center";
                              this.fontSize = 14;
                              this.color = 16777215;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"championSelectionBody",
                                 "selectable":false,
                                 "mouseChildren":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"championSkinUnlock_txt",
                           "events":{"click":"__championSkinUnlock_txt_click"},
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                              this.fontSize = 14;
                              this.color = 16711680;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"championSelectionBody",
                                 "percentWidth":100,
                                 "useHandCursor":true,
                                 "buttonMode":true,
                                 "selectable":false,
                                 "visible":false,
                                 "mouseChildren":false
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Text,
                           "id":"championSkinDisabled_txt",
                           "stylesFactory":function():void
                           {
                              this.textAlign = "center";
                              this.fontSize = 14;
                              this.color = 16711680;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"championSelectionBody",
                                 "percentWidth":100,
                                 "selectable":false,
                                 "visible":false,
                                 "mouseChildren":false
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":SoundEffectButton,
                  "id":"previous_btn",
                  "events":{"click":"__previous_btn_click"},
                  "stylesFactory":function():void
                  {
                     this.verticalCenter = "0";
                     this.left = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "useHandCursor":true,
                        "buttonMode":true,
                        "styleName":"arrowLeftBlue"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":SoundEffectButton,
                  "id":"next_btn",
                  "events":{"click":"__next_btn_click"},
                  "stylesFactory":function():void
                  {
                     this.verticalCenter = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "useHandCursor":true,
                        "buttonMode":true,
                        "styleName":"arrowRightBlue"
                     };
                  }
               })]};
            }
         });
         this._renderers = [];
         this._onSkinNavigated = new Signal();
         this._bindings = [];
         this._watchers = [];
         this._bindingsByDestination = {};
         this._bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.disabledOverlayAlpha = 0;
         };
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.cacheAsBitmap = true;
         this._ChampionSkinSelector_Fade1_i();
         this._ChampionSkinSelector_Fade2_i();
         this.addEventListener("initialize",this.___ChampionSkinSelector_Canvas1_initialize);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ChampionSkinSelector._watcherSetupUtil = param1;
      }
      
      private function _ChampionSkinSelector_Fade1_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeIn = _loc1_;
         _loc1_.alphaTo = 1;
         _loc1_.alphaFrom = 0;
         _loc1_.duration = 400;
         return _loc1_;
      }
      
      public function __skinsCoverFlow_creationComplete(param1:FlexEvent) : void
      {
         this.onSkinsCoverFlowCreationComplete();
      }
      
      public function get chromaPreviewImage() : Image
      {
         return this._1962022921chromaPreviewImage;
      }
      
      public function get next_btn() : SoundEffectButton
      {
         return this._1424721680next_btn;
      }
      
      public function set chromaPreviewImage(param1:Image) : void
      {
         var _loc2_:Object = this._1962022921chromaPreviewImage;
         if(_loc2_ !== param1)
         {
            this._1962022921chromaPreviewImage = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chromaPreviewImage",_loc2_,param1));
         }
      }
      
      private function _ChampionSkinSelector_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return fadeIn;
         },function(param1:*):void
         {
            chromaPreviewImage.setStyle("showEffect",param1);
         },"chromaPreviewImage.showEffect");
         result[0] = binding;
         binding = new Binding(this,function():*
         {
            return fadeOut;
         },function(param1:*):void
         {
            chromaPreviewImage.setStyle("hideEffect",param1);
         },"chromaPreviewImage.hideEffect");
         result[1] = binding;
         binding = new Binding(this,function():Number
         {
            return championSkinUnlock_txt.y + championSkinUnlock_txt.height;
         },function(param1:Number):void
         {
            skinNameContainer.height = param1;
         },"skinNameContainer.height");
         result[2] = binding;
         binding = new Binding(this,function():*
         {
            return fadeIn;
         },function(param1:*):void
         {
            chromaButtonContainerHBox.setStyle("showEffect",param1);
         },"chromaButtonContainerHBox.showEffect");
         result[3] = binding;
         binding = new Binding(this,function():*
         {
            return fadeOut;
         },function(param1:*):void
         {
            chromaButtonContainerHBox.setStyle("hideEffect",param1);
         },"chromaButtonContainerHBox.hideEffect");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = chromaButtonContainerHBox.y + chromaButtonContainerHBox.height + chromaButtonContainerHBox.getStyle("paddingBottom");
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            championSkinName_txt.setStyle("top",param1);
         },"championSkinName_txt.top");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = championSkinName_txt.y + championSkinName_txt.height;
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            championSkinUnlock_txt.setStyle("top",param1);
         },"championSkinUnlock_txt.top");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = RiotResourceLoader.getString("championSelection_skinBrowser_champion_unlock","**Click To Unlock");
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            championSkinUnlock_txt.htmlText = param1;
         },"championSkinUnlock_txt.htmlText");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = championSkinName_txt.y + championSkinName_txt.height;
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            championSkinDisabled_txt.setStyle("top",param1);
         },"championSkinDisabled_txt.top");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = RiotResourceLoader.getString("championSelection_skinBrowser_disabled_skin","**Selected");
            var _loc2_:* = _loc1_ == undefined?null:String(_loc1_);
            return _loc2_;
         },function(param1:String):void
         {
            championSkinDisabled_txt.htmlText = param1;
         },"championSkinDisabled_txt.htmlText");
         result[9] = binding;
         return result;
      }
      
      public function get championSkinUnlock_txt() : Text
      {
         return this._1261026587championSkinUnlock_txt;
      }
      
      public function set skinsCoverFlow(param1:SkinFlow) : void
      {
         var _loc2_:Object = this._202312817skinsCoverFlow;
         if(_loc2_ !== param1)
         {
            this._202312817skinsCoverFlow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinsCoverFlow",_loc2_,param1));
         }
      }
      
      public function set next_btn(param1:SoundEffectButton) : void
      {
         var _loc2_:Object = this._1424721680next_btn;
         if(_loc2_ !== param1)
         {
            this._1424721680next_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"next_btn",_loc2_,param1));
         }
      }
      
      public function get previous_btn() : SoundEffectButton
      {
         return this._1116990188previous_btn;
      }
      
      public function initializeSkinSelector(param1:ISkinDisplayModel) : void
      {
         this.removeDisplayModelListeners();
         this._skinDisplayModel = param1;
         this._skinDisplayModel.isGameQueuedToStartChanged.add(this.onGameQueuedToStartChanged);
         this._skinDisplayModel.teamSkinRentalChanged.add(this.onAllSkinsRentalUnlocked);
         this._skinDisplayModel.skinFulfillmentNotified.add(this.onSkinFulfillmentNotified);
         SkinsConfig.instance.getLastSelectedSkinChanged().add(this.onLastSelectedSkinChanged);
      }
      
      public function set previous_btn(param1:SoundEffectButton) : void
      {
         var _loc2_:Object = this._1116990188previous_btn;
         if(_loc2_ !== param1)
         {
            this._1116990188previous_btn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"previous_btn",_loc2_,param1));
         }
      }
      
      public function set championSkinUnlock_txt(param1:Text) : void
      {
         var _loc2_:Object = this._1261026587championSkinUnlock_txt;
         if(_loc2_ !== param1)
         {
            this._1261026587championSkinUnlock_txt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championSkinUnlock_txt",_loc2_,param1));
         }
      }
      
      private function playerSelectedSkin() : void
      {
         if((!(this.skinsCoverFlow == null)) && (!(this.skinsCoverFlow.selectedSkin == null)))
         {
            this.navigateToSkin(this.skinsCoverFlow.selectedSkin);
         }
      }
      
      private function onPreviousButtonClicked() : void
      {
         if(this.skinsCoverFlow.selectedIndex > 0)
         {
            this.skinsCoverFlow.selectedIndex--;
         }
      }
      
      public function cleanupSkinSelector() : void
      {
         this.removeDisplayModelListeners();
         this.playerSelection = null;
         SkinsConfig.instance.getLastSelectedSkinChanged().remove(this.onLastSelectedSkinChanged);
      }
      
      public function get fadeOut() : Fade
      {
         return this._1091436750fadeOut;
      }
      
      private function onNextButtonClicked() : void
      {
         if(this.skinsCoverFlow.selectedIndex < this.skinsCoverFlow.numChildren - 1)
         {
            this.skinsCoverFlow.selectedIndex++;
         }
      }
      
      public function __championSkinUnlock_txt_click(param1:MouseEvent) : void
      {
         this.showChampionCDP();
      }
      
      public function ___ChampionSkinSelector_Canvas1_initialize(param1:FlexEvent) : void
      {
         this.onInitialized();
      }
      
      private function updateChampion(... rest) : void
      {
         if((this.playerSelection) && (!(this.skinsCoverFlow == null)) && (this.skinsCoverFlow.initialized))
         {
            this.championSkins = ChampionSkinSelectorRendererSupport.createSkinsData(this.playerSelection);
            ChampionSkinSelectorRendererSupport.createSkinRenderers(this._renderers,this.championSkins,this.skinsCoverFlow,this._skinDisplayModel);
            this.addEventListener(FlexEvent.UPDATE_COMPLETE,this.onRenderersUpdated,false,0,true);
            this.invalidateProperties();
         }
      }
      
      private function removeDisplayModelListeners() : void
      {
         if(this._skinDisplayModel)
         {
            this._skinDisplayModel.isGameQueuedToStartChanged.remove(this.onGameQueuedToStartChanged);
            this._skinDisplayModel.teamSkinRentalChanged.remove(this.onAllSkinsRentalUnlocked);
            this._skinDisplayModel.skinFulfillmentNotified.remove(this.onSkinFulfillmentNotified);
         }
      }
      
      public function set playerSelection(param1:PlayerSelection) : void
      {
         if(this._playerSelection == param1)
         {
            return;
         }
         if(this._playerSelection)
         {
            this._playerSelection.removeEventListener("championChanged",this.updateChampion);
         }
         this.championSkins = null;
         this._playerSelection = param1;
         if(this._playerSelection)
         {
            this.updateChampion();
            this._playerSelection.addEventListener("championChanged",this.updateChampion,false,0,true);
         }
      }
      
      private function set championSkins(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._195285075championSkins;
         if(_loc2_ !== param1)
         {
            this._195285075championSkins = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championSkins",_loc2_,param1));
         }
      }
      
      public function get championSkinName_txt() : Text
      {
         return this._33968542championSkinName_txt;
      }
      
      public function set fadeOut(param1:Fade) : void
      {
         var _loc2_:Object = this._1091436750fadeOut;
         if(_loc2_ !== param1)
         {
            this._1091436750fadeOut = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeOut",_loc2_,param1));
         }
      }
      
      private function initializeSelectedSkin() : void
      {
         ChampionSkinSelectorRendererSupport.initializeSelectedSkin(this.skinsCoverFlow,this.playerSelection);
         this.updateSkinVisuals();
         if((this._chromaMediator) && (this.playerSelection))
         {
            this._chromaMediator.updatePlayerSelection(this.playerSelection.champion);
         }
      }
      
      public function navigateToSkin(param1:ChampionSkin) : void
      {
         ChampionSkinSelectorRendererSupport.initializeForSkin(this.skinsCoverFlow,param1);
         this.updateSkinVisuals();
         this._chromaMediator.updateSkinSelection(param1);
         if((this._skinDisplayModel) && (this._skinDisplayModel.canSelectSkins()))
         {
            this.dispatchSkinNavigation(param1);
         }
      }
      
      private function updateSkinVisuals() : void
      {
         this.updateSkinName();
         this.updateOwnedText();
         this.updateButtons();
         ChampionSkinSelectorRendererSupport.updateFocusedSkin(this.skinsCoverFlow);
      }
      
      private function onGameQueuedToStartChanged(param1:ISignal, param2:Boolean) : void
      {
         this.updateButtons();
      }
      
      public function set skinNameContainer(param1:Canvas) : void
      {
         var _loc2_:Object = this._672824249skinNameContainer;
         if(_loc2_ !== param1)
         {
            this._672824249skinNameContainer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"skinNameContainer",_loc2_,param1));
         }
      }
      
      private function _ChampionSkinSelector_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.fadeIn;
         _loc1_ = this.fadeOut;
         _loc1_ = this.championSkinUnlock_txt.y + this.championSkinUnlock_txt.height;
         _loc1_ = this.fadeIn;
         _loc1_ = this.fadeOut;
         _loc1_ = this.chromaButtonContainerHBox.y + this.chromaButtonContainerHBox.height + this.chromaButtonContainerHBox.getStyle("paddingBottom");
         _loc1_ = this.championSkinName_txt.y + this.championSkinName_txt.height;
         _loc1_ = RiotResourceLoader.getString("championSelection_skinBrowser_champion_unlock","**Click To Unlock");
         _loc1_ = this.championSkinName_txt.y + this.championSkinName_txt.height;
         _loc1_ = RiotResourceLoader.getString("championSelection_skinBrowser_disabled_skin","**Selected");
      }
      
      private function onInitialized() : void
      {
         this._chromaMediator = new ChromaMediator(this.chromaButtonContainerHBox,this.chromaPreviewImage);
         this._chromaMediator.onChromaSelected.add(this.dispatchSkinNavigation);
         this._chromaMediator.onUpdateChromaDisplay.add(this.updateLocalizedSkinName);
      }
      
      public function get onSkinNavigated() : ISignal
      {
         return this._onSkinNavigated;
      }
      
      private function updateButtons() : void
      {
         if((this._skinDisplayModel) && (this._skinDisplayModel.isGameQueuedToStart))
         {
            this.enabled = false;
         }
         else
         {
            this.enabled = true;
         }
         if((this.previous_btn && this.next_btn) && (this._skinDisplayModel) && (this._skinDisplayModel.isGameQueuedToStart))
         {
            this.previous_btn.enabled = false;
            this.next_btn.enabled = false;
         }
         else
         {
            if((this.previous_btn) && (this.skinsCoverFlow))
            {
               this.previous_btn.enabled = this.skinsCoverFlow.selectedIndex > 0;
            }
            else if(this.previous_btn)
            {
               this.previous_btn.enabled = false;
            }
            
            if((this.next_btn) && (this.skinsCoverFlow) && (this.championSkins))
            {
               this.next_btn.enabled = this.skinsCoverFlow.selectedIndex < this.championSkins.length - 1;
            }
            else if(this.next_btn)
            {
               this.next_btn.enabled = false;
            }
            
         }
      }
      
      public function __next_btn_click(param1:MouseEvent) : void
      {
         this.onNextButtonClicked();
      }
      
      private function updateLocalizedSkinName(param1:ChampionSkin) : void
      {
         if(this.championSkinName_txt)
         {
            if((!(param1.getLocalizedSkinName() == "")) || (!(param1.getLocalizedSkinName() == null)))
            {
               this.championSkinName_txt.htmlText = param1.getLocalizedSkinName();
            }
         }
      }
      
      public function __previous_btn_click(param1:MouseEvent) : void
      {
         this.onPreviousButtonClicked();
      }
      
      public function set fadeIn(param1:Fade) : void
      {
         var _loc2_:Object = this._1282133823fadeIn;
         if(_loc2_ !== param1)
         {
            this._1282133823fadeIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fadeIn",_loc2_,param1));
         }
      }
      
      private function onLastSelectedSkinChanged() : void
      {
         if(!ChampionSkinSelectorRendererSupport.isNavigating(this.skinsCoverFlow,this.playerSelection))
         {
            this.initializeSelectedSkin();
         }
      }
      
      private function onRenderersUpdated(param1:FlexEvent) : void
      {
         this.removeEventListener(FlexEvent.UPDATE_COMPLETE,this.onRenderersUpdated);
         this.initializeSelectedSkin();
      }
      
      private function dispatchSkinNavigation(param1:ChampionSkin) : void
      {
         this._onSkinNavigated.dispatch(this._onSkinNavigated,param1);
      }
      
      public function get skinsCoverFlow() : SkinFlow
      {
         return this._202312817skinsCoverFlow;
      }
      
      override public function initialize() : void
      {
         var target:ChampionSkinSelector = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         var bindings:Array = this._ChampionSkinSelector_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_com_riotgames_platform_gameclient_controllers_game_views_ChampionSkinSelectorWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         var i:uint = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      private function updateSkinName() : void
      {
         if(!((this.skinsCoverFlow) && (this.skinsCoverFlow.selectedChild) && IDataRenderer(this.skinsCoverFlow.selectedChild).data))
         {
            return;
         }
         var _loc1_:ChampionSkin = IDataRenderer(this.skinsCoverFlow.selectedChild).data as ChampionSkin;
         this.updateLocalizedSkinName(_loc1_);
      }
      
      private function onSkinsCoverFlowCreationComplete() : void
      {
         this.updateChampion();
         this.skinsCoverFlow.getSelectedIndexChange().add(this.playerSelectedSkin);
      }
      
      private function updateOwnedText() : void
      {
         if((!this.skinsCoverFlow) || (!this.skinsCoverFlow.selectedChild) || (!this.championSkinUnlock_txt))
         {
            return;
         }
         var _loc1_:ChampionSkin = IDataRenderer(this.skinsCoverFlow.selectedChild).data as ChampionSkin;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:Boolean = (this._skinDisplayModel) && (this._skinDisplayModel.availableForTeamSkinRental(_loc1_.skinId));
         this.championSkinDisabled_txt.visible = false;
         this.championSkinUnlock_txt.visible = (!_loc1_.isAvailable()) && (!_loc2_) && (!_loc1_.skinDisabled);
         if(SkinsConfig.instance.isSkinLastSelected(_loc1_))
         {
            this.championSkinUnlock_txt.visible = false;
         }
         if(_loc1_.skinDisabled)
         {
            this.championSkinDisabled_txt.visible = true;
         }
      }
      
      public function get playerSelection() : PlayerSelection
      {
         return this._playerSelection;
      }
      
      public function set championSkinDisabled_txt(param1:Text) : void
      {
         var _loc2_:Object = this._621071059championSkinDisabled_txt;
         if(_loc2_ !== param1)
         {
            this._621071059championSkinDisabled_txt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championSkinDisabled_txt",_loc2_,param1));
         }
      }
      
      private function get championSkins() : ArrayCollection
      {
         return this._195285075championSkins;
      }
      
      public function get skinNameContainer() : Canvas
      {
         return this._672824249skinNameContainer;
      }
      
      private function onAllSkinsRentalUnlocked(param1:ISignal, param2:*) : void
      {
         if(param2)
         {
            this.playerSelectedSkin();
         }
      }
      
      public function get fadeIn() : Fade
      {
         return this._1282133823fadeIn;
      }
      
      public function set championSkinName_txt(param1:Text) : void
      {
         var _loc2_:Object = this._33968542championSkinName_txt;
         if(_loc2_ !== param1)
         {
            this._33968542championSkinName_txt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"championSkinName_txt",_loc2_,param1));
         }
      }
      
      private function _ChampionSkinSelector_Fade2_i() : Fade
      {
         var _loc1_:Fade = new Fade();
         this.fadeOut = _loc1_;
         _loc1_.alphaTo = 0;
         _loc1_.alphaFrom = 1;
         _loc1_.duration = 300;
         return _loc1_;
      }
      
      private function showChampionCDP() : void
      {
         var _loc1_:ChampionSkin = null;
         var _loc2_:IChampionDetailProvider = null;
         if((this.playerSelection) && (!(this.playerSelection.champion == null)))
         {
            _loc1_ = IDataRenderer(this.skinsCoverFlow.selectedChild).data as ChampionSkin;
            _loc2_ = ChampionDetailProviderProxy.instance;
            _loc2_.displayChampionDetailView(ChampionDetailContext.CHAMPION_SELECT,this.playerSelection.champion,_loc1_.skinId,true);
         }
      }
      
      public function get championSkinDisabled_txt() : Text
      {
         return this._621071059championSkinDisabled_txt;
      }
      
      public function set chromaButtonContainerHBox(param1:HBox) : void
      {
         var _loc2_:Object = this._1187329020chromaButtonContainerHBox;
         if(_loc2_ !== param1)
         {
            this._1187329020chromaButtonContainerHBox = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chromaButtonContainerHBox",_loc2_,param1));
         }
      }
      
      private function onSkinFulfillmentNotified() : void
      {
         this.playerSelectedSkin();
      }
      
      public function get chromaButtonContainerHBox() : HBox
      {
         return this._1187329020chromaButtonContainerHBox;
      }
   }
}
