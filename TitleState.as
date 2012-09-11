package
{
	//import flash.ui.Mouse;
	import org.flixel.*;
	
	public class TitleState extends FlxState
	{				
		override public function create():void
		{
			
			super.create();
			FlxG.mute = false;  // WHAT THE FUCK

			//Show mouse
			//flash.ui.Mouse.show();
			FlxG.mouse.show();
			
			//BG
			this.add(BGLib.bgIntro);
			
			//Button
			var b:FlxButton;
			b = new FlxButton(FlxG.width/2 - 50,FlxG.height*1/2 - 90,"START GAME",OnClickStart);
			//b.makeGraphic(60,40,0xffaa1111);		
			add(b);	
			
			SoundLib.music_motherly_sound.play();
			//SoundTest1
			b = new FlxButton(FlxG.width/2 - 50,FlxG.height*1/2 - 60,"MUSIC ON",SoundLib.music_motherly_sound.play);
			add(b);	
			//SoundTest2
			b = new FlxButton(FlxG.width/2 - 50,FlxG.height*1/2 - 30,"MUSIC OFF",SoundLib.music_motherly_sound.stop);
			add(b);	
			
			
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.justPressed("SPACE")) {
				OnClickStart();
			}
		}		
		
		private function OnClickStart():void
		{
			SoundLib.music_motherly_sound.stop();
			FlxG.switchState(new PlayState());			
		}
	}
}