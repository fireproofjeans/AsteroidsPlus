package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class RepairKit extends Entity
	{
		[Embed(source = 'assets/Repairkit.png')] private const KIT:Class;
		public var value:int;
		
		public function RepairKit(inX:int, inY:int,inValue:int = 10) 
		{
			value = inValue;
			x = inX;
			y = inY;
			
			graphic = new Image(KIT);
			Image(graphic).scale = Main.GAME_SCALE/1.5;
			Image(graphic).centerOrigin();
			setHitbox(Main.GAME_SCALE * 115, Main.GAME_SCALE * 115, -(Image(graphic).width/2 - Image(graphic).scaledWidth/2.2), -(Image(graphic).height/2 - Image(graphic).scaledHeight/2.2));
		}
		
		override public function update():void
		{
			if (collide("player", x, y)) {
				Main.GameSpace.repair(value);
				world.remove(this);
			}
			Image(graphic).angle += 1;
		}
		
	}

}