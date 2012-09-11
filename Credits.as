package
{
	import org.flixel.*;
	
	public class Credits extends FlxState
	{				
		[Embed(source="assets/bgPainting_03.png")]
		public static var ImgBG:Class;
		
		override public function create():void
		{
			super.create();
			//BG
			this.add(new FlxSprite(0,0,ImgBG));
			
			var b:FlxButton;
			b = new FlxButton(FlxG.width/2 - 50,FlxG.height*1/2-50,"Replay!",OnClickStart);
			add(b);			
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE"))
				OnClickStart();
			super.update();
		}		
		
		private function OnClickStart():void
		{
			FlxG.switchState(new PlayState());			
		}
	}
}