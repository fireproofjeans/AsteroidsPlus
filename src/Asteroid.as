package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author fyre
	 */
	public class Asteroid extends Entity
	{

		private var x1:int;
		private var y1:int;
		private var spin:int;
		private var vel:int;
		private var bounceTimer:int;
		
		[Embed(source = 'assets/asteroid.png')] private const ENEMY1:Class;
		
		public function Asteroid(size:int, inColor:int = 0xFFFFFF, inX:int = 350, inY:int = 25 )
		{
			bounceTimer = 150;
			graphic = new Image(ENEMY1);
			setHitbox(size/5, size/5, -(Image(graphic).scaledWidth/2 - size/10), -(Image(graphic).scaledHeight/2 - size/10));
			Image(graphic).scale = size / 1000;
			Image(graphic).color = inColor;
			Image(graphic).centerOrigin();
			type = "enemy";
			x = inX;
			y = inY;
			spin = (FP.random * 10) -5;
			x1 = FP.random * 360;
			y1 = FP.random * 360;
			vel = FP.random * Main.ASTEROID_MAXSPEED;
			if (vel > Main.ASTEROID_MAXSPEED) { vel = Main.ASTEROID_MAXSPEED; }
			if (vel < Main.ASTEROID_MINSPEED) { vel = Main.ASTEROID_MINSPEED; }
		}
		
		public function bounce():void
		{
			y1 += 180;
			x1 += 180;
			
			
			//y += Math.sin(y1 * Math.PI / 180) * 15; 
			//x -= Math.cos(x1 * Math.PI / 180) * 15;
			
		}
		
		public function getX():int
		{
			return x;
		}
		
		public function getY():int
		{
			return y;
		}
		
		override public function update():void
		{
			if (Image(graphic).scale < 0.1) { world.remove(this); }
			
			y += Math.sin(y1 * Math.PI / 180) * vel; 
			x -= Math.cos(x1 * Math.PI / 180) * vel;
			Image(graphic).angle += spin;
			
			if (collide("bullet", x, y)) {
				world.remove(collide("bullet", x, y));
				world.add(new Asteroid((Image(graphic).scale * 500), Image(graphic).color, x, y));
				world.add(new Asteroid((Image(graphic).scale * 500), Image(graphic).color, x, y));
				Main.GameSpace.addScore(10);
				if (Math.random() < 0.05) {
					world.add(new RepairKit(x,y));
				}
				world.remove(this);
			}
			
			bounceTimer -= 1;
			
			try 
				{ 
					var asteroidHit = collide("enemy", x, y);
				}
				catch ( e:Error )
				{
					//ignore it
				}
			if (asteroidHit && bounceTimer <= 0) {
				bounce();
				bounceTimer = 15;
				//collide("enemy", x, y)
			}
			/*	Resets asteroid to one of four corners. Moved all collision details to 
			 * player class to reduce code in asteroid class for efficiency, and also 
			 * to solve a bug where the Asteroid would detect collision before the player
			 * did. The asteroid would simply jump to a corner before the player's ship
			 * detected a collision, making the player invincible if they didn't move.
			 * 
			 * Replaced with Asteroid.move(x,y)
			 */
			/*
				if (collide("player", x, y)) {
				var newX:int;
				var newY:int;
				if (Math.random() < 0.5)
				{
					newX = -175;
				} else {
					newX = Main.ROOM_WIDTH + 50;
				}
				if (Math.random() < 0.5)
				{
					newY = -175;
				} else {
					newY = Main.ROOM_WIDTH + 50;
				}
				x = newX;
				y = newY;
			}
			*/
			
			if (x > Main.ROOM_WIDTH - Image(graphic).width/2) { x = -Image(graphic).width/2; } // PAIN
			if (x < (-Image(graphic).width/2)) { x = Main.ROOM_WIDTH - Image(graphic).width/2; } // IN
			if (y > Main.ROOM_HEIGHT - Image(graphic).height/2) { y = 0 - Image(graphic).height/2; } // THE
			if (y < 0 - Image(graphic).height/2) { y = Main.ROOM_HEIGHT - Image(graphic).height/2; } // ASS
			
		}
		
	}

}