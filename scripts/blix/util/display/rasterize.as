package blix.util.display
{
   public function rasterize(param1:DisplayObject, param2:Boolean = true, param3:Number = 1, param4:Number = 1) : Sprite
   {
      var target:DisplayObject = param1;
      var useAlpha:Boolean = param2;
      var scaleX:Number = param3;
      var scaleY:Number = param4;
      var bounds:Rectangle = target.getBounds(target);
      var bmpd:BitmapData = new BitmapData(target.width * scaleX,target.height * scaleY,useAlpha,0);
      var mat:Matrix = new Matrix();
      mat.translate(-bounds.left,-bounds.top);
      mat.scale(scaleX,scaleY);
      try
      {
         bmpd.draw(target,mat);
      }
      catch(error:SecurityError)
      {
         return null;
      }
      var bmp:Bitmap = new Bitmap(bmpd,PixelSnapping.AUTO,true);
      bmp.x = bounds.left;
      bmp.y = bounds.top;
      var container:Sprite = new Sprite();
      container.cacheAsBitmap = true;
      container.transform.matrix = target.transform.matrix;
      container.addChild(bmp);
      return container;
   }
}
