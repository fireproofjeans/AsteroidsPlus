package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author fyre
	 */
	public class MyWorld extends World
	{
		private var Player:MyEntity;
		private var DungeonMaster:DM;
		//private var StartScreen:Menu;
		
		//public function MyWorld() 
		//{
		//	add (StartScreen = new Menu(1));
		//}
		
		public function MyWorld()
		{
			this.removeAll();
			add (DungeonMaster = new DM());
			add (Player = new MyEntity);
			//add (new RepairKit(20,20));
		}
		
		public function addScore(inScore:int):void
		{
			DungeonMaster.addPoints(inScore);
		}
		
		public function repair(inHealth:int):void
		{
			Player.repair(inHealth);
		}
		
		public function getHP():int
		{
			return Player.getHP();
		}
		
		public function bumpAway(asteroidPosition:Array):Array
		{
			return Player.bump(asteroidPosition);
		}
	}
}