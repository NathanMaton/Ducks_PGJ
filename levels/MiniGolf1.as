package levels
{
	import flash.geom.*;
	
	import mech.*;
	
	import org.flixel.*;

	public class MiniGolf1 extends Level
	{
		[Embed(source = "../assets/easyMinigolf.txt", mimeType = "application/octet-stream")]
		private var levelString : Class;
		
		public function MiniGolf1():void
		{
			super();
			//_startPoint = new FlxPoint(55,140); //Start-ish
			//			_startPoint = new FlxPoint(655,440);
						_startPoint = new FlxPoint(955,440);
			_mapString = new levelString();
		}
		
		override public function generateSpriteGroup(_flavor : FlxGroup):void {
			var myBG:FlxSprite = new FlxSprite(0,0,BGLib.bgImg01);
			myBG.scale = new FlxPoint(5,2);
			_flavor.add(myBG);
		}
		
		override public function generateMechGroups(_mech_solid : FlxGroup, _mech_permeable : FlxGroup):void {

			var tmpGate : GatePlate;
			var tmpPad : PressurePad;
			var tmpToggle : ToggleSwitch;
			var tmpTrip : GateTrip;
			
			tmpGate = new GatePlate(500, 350, FlxObject.RIGHT);
			_mech_solid.add(tmpGate);
			
			tmpTrip = new GateTrip();
			
			tmpGate.addMotion(3, new Point(0, 50), 0, new Point(0, 0));
			
			tmpPad = new PressurePad(100, 350);
			tmpPad.setPrime(3);
			tmpPad.set_hold();
			tmpTrip.add(tmpPad);
			_mech_permeable.add(tmpPad);
			
			tmpToggle = new ToggleSwitch(450, 350);
			tmpToggle.setPrime(3);
			tmpToggle.set_switch();
			tmpTrip.add(tmpToggle);
			_mech_permeable.add(tmpToggle);
			
			tmpGate.gate_trip = tmpTrip;
		}
		
		
		override public function generateTextGroup(_text : FlxGroup):void {
			//Override to set _textGroup.
			
			var blarText:FlxText = new FlxText(FlxG.width/2,FlxG.height*1/4,400);
			blarText.alignment="center";
			blarText.shadow = 0xff000000;
			blarText.text = "MINI GOLF 4 LIFE YO";
			_text.add(blarText);

			var blarText1:FlxText = new FlxText(1500,240,400);
			blarText1.alignment="center";
			blarText1.shadow = 0xff000000;
			blarText1.text = "created by:";
			_text.add(blarText1);
			
			var blarText2:FlxText = new FlxText(1500,270,400);
			blarText2.alignment="center";
			blarText2.shadow = 0xff000000;
			blarText2.text = "Nikkolai Davenport";			
			_text.add(blarText2);
			
			var blarText3:FlxText = new FlxText(1500,300,400);
			blarText3.alignment="center";
			blarText3.shadow = 0xff000000;
			blarText3.text = "Sam Levine";
			_text.add(blarText3);
			
			var blarText4:FlxText = new FlxText(1500,330,400);
			blarText4.alignment="center";
			blarText4.shadow = 0xff000000;
			blarText4.text = "Zaal Tonia";
			_text.add(blarText4);
			
			var blarText5:FlxText = new FlxText(1500,360,400);
			blarText5.alignment="center";
			blarText5.shadow = 0xff000000;
			blarText5.text = "Nathan Maton";
			_text.add(blarText5);

			var blarText6:FlxText = new FlxText(1500,390,400);
			blarText6.alignment="center";
			blarText6.shadow = 0xff000000;
			blarText6.text = "some sounds from http://soundbible.com/";
			_text.add(blarText6);

			var blarText7:FlxText = new FlxText(1500,420,400);
			blarText7.alignment="center";
			blarText7.shadow = 0xff000000;
			blarText7.text = "Thank you!";
			_text.add(blarText7);

		}
	}
	
}