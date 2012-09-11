package
{
	import org.flixel.*;
	
	public class WinState extends FlxState
	{				
		override public function create():void
		{
			super.create();
			this.add(BGLib.bgOutro);		
			SoundLib.music_crickets_sound.play();
		}		
	}
}