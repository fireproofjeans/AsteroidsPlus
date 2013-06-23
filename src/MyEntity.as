package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author fyre
	 */
	public class MyEntity extends Entity
	{
		[Embed(source = 'assets/ship.png')] private const SHIP:Class;
		[Embed(source = 'assets/shipminordamage.png')] private const SHIPMDAM:Class;
		[Embed(source = 'assets/shipdamaged.png')] private const SHIPDAM:Class;
		[Embed(source = 'assets/shipcritical.png')] private const SHIPCRIT:Class;
		
		private var HP:int = Main.PLAYER_HP;
		private var delay:int = 0;
		private var hitRedInvincibility:int = 0;
		
		public function MyEntity() 
		{
			graphic = new Image(SHIP);
			type = "player";
			Image(graphic).scale = Main.GAME_SCALE;
			Image(graphic).centerOrigin();
			setHitbox(Main.GAME_SCALE * 225, Main.GAME_SCALE * 225, -(Image(graphic).width/2 - Image(graphic).scaledWidth/3), -(Image(graphic).height/2 - Image(graphic).scaledHeight/3));
			x = Main.ROOM_WIDTH / 2 -Image(graphic).width/2;
			y = Main.ROOM_HEIGHT / 2 - Image(graphic).height/2;
			
			// Multiple control configurations means left-handed gamers don't get trashed with WSAD controls. Also some right handed people legitimately
			// use Arrow keys. Like my sister. and my mom. and probably more than just those two :P.
			Input.define("up", Key.W, Key.UP, Key.NUMPAD_8);
			Input.define("down", Key.S, Key.DOWN, Key.NUMPAD_2);
			Input.define("rleft", Key.A, Key.LEFT, Key.NUMPAD_4);
			Input.define("rright", Key.D, Key.RIGHT, Key.NUMPAD_6);
			Input.define("shoot", Key.SPACE, Key.NUMPAD_0);
		}
		
		public function bump(astPos:Array):Array
		{
			return Array[x, y];
			astX = astPos[0];
			astY = astPos[1];
			if (astX > x + 25) {
				x -= 50;
			} else if (astX < x - 25) {
				x += 50;
			}
			if (astY > y + 25) {
				x -= 50;
			} else if (astY < y - 25) {
				x += 50;
			}
		}
		
		private function spriteUpdate():void
		{
			var tempAngl:int = Image(graphic).angle;// Without this, current ship angle is not retained when switching sprites.
			if (HP <= 0) {							// Serious case of Dedz
				//world.add(Menu);
				world.remove(this);
			} else if (HP < Main.PLAYER_HP/4) {		// 25% HP
				graphic = new Image(SHIPCRIT);
				Image(graphic).scale = Main.GAME_SCALE;
				Image(graphic).centerOrigin();
				Image(graphic).angle = tempAngl;
			} else if (HP < Main.PLAYER_HP/2) {		// 50% HP
				graphic = new Image(SHIPDAM);
				Image(graphic).scale = Main.GAME_SCALE;
				Image(graphic).centerOrigin();
				Image(graphic).angle = tempAngl;
			} else if (HP < Main.PLAYER_HP/1.33) {	// 75% HP
				graphic = new Image(SHIPMDAM);
				Image(graphic).scale = Main.GAME_SCALE;
				Image(graphic).centerOrigin();
				Image(graphic).angle = tempAngl;
			} else if (HP >= Main.PLAYER_HP/1.33) {	// 75% HP
				graphic = new Image(SHIP);
				Image(graphic).scale = Main.GAME_SCALE;
				Image(graphic).centerOrigin();
				Image(graphic).angle = tempAngl;
			}
		}
		
		public function repair(inHealth:int):void
		{
			HP += inHealth;							// how much to repair by. Allowing variable amounts leaves 
			spriteUpdate();							// room for multiple types of repair kits.
			
		}
		
		public function getHP():int
		{
			return HP;
		}
		
		override public function update():void
		{
			
			// - Code I shamelessly grabbed off Newgrounds.com's forums to move along a sprites rotation - \\
			// http://www.newgrounds.com/bbs/topic/1139369 \\			
			/*var rot = obj.rotation;
			var radians = obj.rotation / (180/Math.PI);
			var speed = 5;
	
			obj.x += (Math.cos(radians)*speed);
			obj.y += (Math.sin(radians) * speed); */
	
			
			// - Old controls. Obscenely basic, no rotation, and the ship moved twice as fast on diagonals - \\
			//if ((Input.check(Key.W) || Input.check(Key.UP)) 	&& y >= 0) 						{ y -= Main.PLAYER_SPEED; }
			//if ((Input.check(Key.S) || Input.check(Key.DOWN)) 	&& y <= Main.ROOM_HEIGHT - 285) 	{ y += Main.PLAYER_SPEED; }
			//if ((Input.check(Key.A) || Input.check(Key.LEFT)) 	&& x >= 0) 						{ Image(graphic).angle -= 2; } //x -= Main.PLAYER_SPEED; }
			//if ((Input.check(Key.D) || Input.check(Key.RIGHT)) 	&& x <= Main.ROOM_WIDTH - 285) 	{ Image(graphic).angle += 2; } //x += Main.PLAYER_SPEED; }
			
			
			// New controls. Uses the defined controls in the constructor above for easy addition/removal of certain keys
			if (Input.check("up")) { 
				y +=  Math.sin((Image(graphic).angle - 90) * Math.PI / 180) * Main.PLAYER_SPEED; 
				x -= Math.cos((Image(graphic).angle - 90) * Math.PI / 180) * Main.PLAYER_SPEED;  
			}
			if (Input.check("down")) {
				y -=  Math.sin((Image(graphic).angle - 90) * Math.PI / 180) * Main.PLAYER_SPEED;
				x += Math.cos((Image(graphic).angle - 90) * Math.PI / 180) * Main.PLAYER_SPEED; 
			}
			
			// rright and rleft stand for rotate right/left. I was planning on adding strafing.
			if (Input.check("rleft"))	{ Image(graphic).angle += 2; } //x -= Main.PLAYER_SPEED; }
			if (Input.check("rright")) 	{ Image(graphic).angle -= 2; } //x += Main.PLAYER_SPEED; }
			
			if (x > Main.ROOM_WIDTH - 120) { x = -220; } // PAIN
			if (x < -220) { x = Main.ROOM_WIDTH - 120; } // IN
			if (y > Main.ROOM_WIDTH - 320) { y = -220; } // THE
			if (y < -220) { y = Main.ROOM_WIDTH - 320; } // ASS
			
			// I don't know why (Noob alert), but the hitbox and sprite had a very real difference in x,y values. Go to Main.as, uncomment FP.console.enable();,
			// - run the game, hit "`" (Grave, located right above tab, left of 1) click the wrench and play buttons, and look at the red and green boxes.
			// - red box is the hitbox, almost perfectly placed on the sprite. Green is the X,Y coordinates the game *thinks* the ship is (and the hitbox).
			
			// Upon further research, it may have something to do with the scaling of the original image.
			
			// Upon further further research and several attempts to make the graphic's center at the Origin of the object, I can 100% confirm that it's
			// due to scaling the image. There does not seem to be an easy way to center the sprite on the origin. Fuck.
			
			if (Input.check("shoot")) {
				if (delay == 0) {
					world.add(new Shot(Image(graphic).angle, x + 142, y + 142)); //offsets the shot so it spawns just in front of the players cannon
					delay += Main.SHOT_DELAY;
				}				
			}
			if (hitRedInvincibility <=0) {
				Image(graphic).color = 0xFFFFFF;
				try 
				{ 
					var thingHit = collide("enemy", x, y);
				}
				catch ( e:Error )
				{
					//ignore it
				}
				if (thingHit) {
					hitRedInvincibility = Main.PLAYERHIT_INVINCIBILITY;
					HP -= Main.DAMAGE_MODIFIER;
					spriteUpdate();
					
					thingHit.bounce();
				}
			}
			if (delay > 0) {
				delay -= 1;
			}
			if (hitRedInvincibility > 0) {
				Image(graphic).color = 0xFF0000;
				hitRedInvincibility -= 1;
			}
			
			FP.console.log(HP);
		}
		
	}

}