package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author fyre
	 */
	public class Shot extends Entity
	{
		[Embed(source = 'assets/shot.png')] private const SHOT:Class;
		private var life:int;
		private var speed;
		
		public function Shot(inAngle:int, inX:int, inY:int) 
		{
			graphic = new Image(SHOT);
			type = "bullet";
			speed = Main.SHOT_SPEED;
			Image(graphic).scale = Main.GAME_SCALE;
			Image(graphic).angle = inAngle;
			Image(graphic).centerOrigin();
			x = inX;
			y = inY;
			setHitbox(12, 12, -(Image(graphic).scaledWidth/2)-8, -(Image(graphic).scaledHeight/2)-8);
			life = Main.SHOT_LIFE;
			y +=  Math.sin((Image(graphic).angle - 90) * Math.PI / 180) * Main.GAME_SCALE * 175; 
			x -= Math.cos((Image(graphic).angle - 90) * Math.PI / 180) * Main.GAME_SCALE * 175; 
			
		}
		
		override public function update():void
		{
			
			y +=  Math.sin((Image(graphic).angle - 90) * Math.PI / 180) * speed; 
			x -= Math.cos((Image(graphic).angle - 90) * Math.PI / 180) * speed;  
			
			if (life < 0) { 
				try {
					world.remove(this); 
				} catch (e) { };
			}
			life = life - 1;
			speed = speed - 0.05;			
		}
		
	}

}