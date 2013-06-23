/* - Asteroids clone by Fireproofjeans / Tylor Goudie - *\
 * 
 * This flash game was developed using Flashdevelop and Flashpunk,
 * the source code is entirely free to use under the creative commons license.
 * You do not need my permission to use the assets from this game nor any part of the code.
 * Credit is always appreciated though, and if you do use it I'd like to see what you've made! :D
 * 
\* - Email: Tylorgoudie@gmail.com || Deviantart: fireproofjeans.deviantart.com || Site: fireproofjeans.com - */ 

package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
		
	public class Main extends Engine
	{
		// Easy configuration. You want double speed? bam, edit one line and you have it~
		// All time values are in frames. If operating nominally, each frame is 1/60th of a second.
		public static const ROOM_WIDTH:uint = 800;
		public static const ROOM_HEIGHT:uint = 600;
		public static const FRAMERATE:int = 60;
		public static const PLAYER_SPEED:int = 2;
		public static const PLAYER_ROTATE_SPEED:int = 3;
		public static const PLAYERHIT_INVINCIBILITY:int = 10 //Time the player is invincible after being hit
		public static const GAME_SCALE = 0.4;
		public static const PLAYER_HP:int = 100;
		public static const SHOT_SPEED:int = 8;
		public static const SHOT_LIFE:int = 50;
		public static const SHOT_DELAY:int = 12;
		public static const ASTEROID_MINSPEED:int = 1;
		public static const ASTEROID_MAXSPEED:int = 3;
		public static const ASTEROID_MAXSIZE:int = 1000;
		public static const DAMAGE_MODIFIER:int = 5; //How much damage the player takes
		
		public static var GameSpace:MyWorld;
		
		public function Main()
		{
			//FP.world = new MyWorld();
			FP.world = (GameSpace = new MyWorld());
			super(ROOM_WIDTH, ROOM_HEIGHT, FRAMERATE, false);
		}
		
		override public function init():void 
		{
			FP.console.enable();
		}
	}
}