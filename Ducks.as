package
{
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#00000000")]
	[Frame(factoryClass="Preloader")]

	public class Ducks extends FlxGame
	{
		public function Ducks()
		{
			super(640,480,TitleState,1);
			trace('Main function start!');
		}
	}
}