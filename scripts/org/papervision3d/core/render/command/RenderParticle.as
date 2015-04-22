package org.papervision3d.core.render.command
{
   import flash.display.Sprite;
   import org.papervision3d.materials.ParticleMaterial;
   import org.papervision3d.core.geom.renderables.Particle;
   import org.papervision3d.core.render.data.RenderSessionData;
   
   public class RenderParticle extends RenderableListItem implements IRenderListItem
   {
      
      private static var container:Sprite;
      
      public var renderer:ParticleMaterial;
      
      public var particle:Particle;
      
      public function RenderParticle(particle:Particle)
      {
         super();
         this.particle = particle;
      }
      
      override public function render(renderSessionData:RenderSessionData) : void
      {
         container = particle.instance.container;
         if(!container)
         {
            container = renderSessionData.container;
         }
         particle.material.drawParticle(particle,container.graphics,renderSessionData);
      }
   }
}
