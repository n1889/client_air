package
{
   import mx.flash.UIMovieClip;
   import flash.display.MovieClip;
   import mx.core.IUIComponent;
   
   public class SlotItem extends UIMovieClip
   {
      
      public var championImg:MyContainer;
      
      public var spellImg0:MyContainer;
      
      public var spellImg1:MyContainer;
      
      public var sheen_left_finish:MovieClip;
      
      public var sheen_right_finish:MovieClip;
      
      public function SlotItem()
      {
         super();
      }
      
      public function setComp(container:MyContainer, flexComp:IUIComponent) : IUIComponent
      {
         container.content = flexComp;
         return flexComp;
      }
      
      public function setSlotItem(champImg:IUIComponent, img0:IUIComponent, img1:IUIComponent) : SlotItem
      {
         this.setComp(this.championImg,champImg);
         this.setComp(this.spellImg0,img0);
         this.setComp(this.spellImg1,img1);
         return this;
      }
      
      override public function set currentState(value:String) : void
      {
         switch(value)
         {
            case ChampionSelect.STATE_BLUE:
            case ChampionSelect.STATE_BLUE_ARROWS_LEFT:
            case ChampionSelect.STATE_BLUE_ARROWS_RIGHT:
               this.championImg.overlay_mc.gotoAndStop("blue");
               this.spellImg0.overlay_mc.gotoAndStop("blue");
               this.spellImg1.overlay_mc.gotoAndStop("blue");
               break;
            case ChampionSelect.STATE_DARK_GREY:
               this.championImg.overlay_mc.gotoAndStop("grey");
               this.spellImg0.overlay_mc.gotoAndStop("grey");
               this.spellImg1.overlay_mc.gotoAndStop("grey");
               break;
            case ChampionSelect.STATE_ORANGE_ARROWS_LEFT:
            case ChampionSelect.STATE_ORANGE_ARROWS_RIGHT:
               this.championImg.overlay_mc.gotoAndStop("orange");
               this.spellImg0.overlay_mc.gotoAndStop("orange");
               this.spellImg1.overlay_mc.gotoAndStop("orange");
               break;
            case ChampionSelect.STATE_LIGHT_GREY:
            case ChampionSelect.STATE_LIGHT_GREY_ARROWS_LEFT:
            case ChampionSelect.STATE_LIGHT_GREY_ARROWS_RIGHT:
               this.championImg.overlay_mc.gotoAndStop("grey");
               this.spellImg0.overlay_mc.gotoAndStop("grey");
               this.spellImg1.overlay_mc.gotoAndStop("grey");
               break;
         }
      }
   }
}
