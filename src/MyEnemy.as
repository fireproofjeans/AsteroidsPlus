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
	public class MyEnemy extends Entity
	{
		private var dirChangeDelay:int;
		private var destx:int;
		private var desty:int;
		private var offset:int;
		
		[Embed(source = 'assets/enemy.png')] private const ENEMY1:Class;
		
		public function MyEnemy()
		{
			graphic = new Image(ENEMY1);
			setHitbox(16, 16);
			type = "enemy";
			dirChangeDelay = FP.random * 100;
			x = y = 500;
			offset = FP.random;
		}
		
		override public function update():void
		{
			if (dirChangeDelay <= 0)
			{
				destx = (FP.random * 784);
				//if (destx > 784) { destx = destx / 2; }
				desty = (FP.random * 584);
				//if (desty > 584) { desty = desty / 2; }
				dirChangeDelay = FP.random * 200;
			}
			moveTowards(destx, desty, 2);
			dirChangeDelay -= 1;
		}
		
	}

}