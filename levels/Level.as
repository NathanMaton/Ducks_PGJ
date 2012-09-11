package levels
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;

	public class Level
	{
		public var _levelNum:uint;
		public var _mapString:String; // string used to create our FlxTilemap
		public var _startPoint:FlxPoint;
		public var _checkPoint:FlxPoint;
		
		public function Level():void
		{
			_startPoint = new FlxPoint(90,240);
		}
		
		public function generateMechGroups(_mech_solid : FlxGroup, _mech_permeable : FlxGroup):void {
			//This function must be overridden to generate BOTH mech groups.
		}
		
		public function generateSpriteGroup(_flavor : FlxGroup):void {
			//Override to set _textGroup.
		}
		
		public function generateTextGroup(_textGroup : FlxGroup):void {
			//Override to set _textGroup.
		}
		
		public function addChix(chix:FlxGroup):void {
			//Override and then call to put one of our kids into the game.
		}

//		public function generateCheckPoint(_checkPoint) {
//			//Input is the reference to the playstate's SPRITE.
//			
//			//Create a new sprite at our FlxPoint.
//			
//		}
		
	}
	
}