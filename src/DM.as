package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;

	public class DM extends Entity
	{
		private var level:int = 0;
		private var delay:int = 10;
		private var i:int;
		private var points:int = 0;
		
		public function DM() 
		{
			graphic = new Text("Score: " + points + "          ");
			y += 25;
			width = 50;
		}
		
		public function addPoints(inPoints:int):void
		{
			points += inPoints;
		}
		
		override public function update():void
		{
			if(delay <= 0){
				if (FP.world.classCount(Asteroid) <= 0) {
					level += 1;
					//FP.console.log(level);
					for (i = 0; i < level; i++) {
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
						world.add (new Asteroid(Math.random() * Main.ASTEROID_MAXSIZE, FP.choose(0x77AA88, 0x7788AA, 0xAA6655, 0xCCCCCC, 0xAAAAAA, 0x888888), newX, newY));
					}
				}
			}
			delay -= 1;
			Text(graphic).text = "Score: " + points + "          ";
		}
	}
}