package levels
{
	import flash.geom.*;
	
	import mech.*;
	
	import org.flixel.*;

	public class Level02 extends Level
	{
		[Embed(source = "../assets/sam_level2.txt", mimeType = "application/octet-stream")]
		private var levelString : Class;
		
		public function Level02():void
		{
			super();
			_mapString = new levelString();
		}
		
		override public function generateSpriteGroup(_flavor : FlxGroup):void {
			var myBG:FlxSprite = new FlxSprite(0,0,BGLib.bgImg04);
			myBG.scale = new FlxPoint(3,1);
			_flavor.add(myBG);
		}
		override public function generateMechGroups(_mech_solid : FlxGroup, _mech_permeable : FlxGroup):void {
			var tmp_gate1:GatePlate = new GatePlate(704, 256, FlxObject.RIGHT);
			var tmp_gate2:GatePlate = new GatePlate(704, 304, FlxObject.RIGHT);
			//var tmp_gate3 = new GatePlate(640, 348, FlxObject.RIGHT);
			var tmp_trip1:GateTrip = new GateTrip();
			
			tmp_gate1.addMotion(3, new Point(0, 70), 0, new Point(0, 0));
			tmp_gate2.addMotion(3, new Point(0, 70), 0, new Point(0, 0));
			tmp_gate1.gate_trip = tmp_trip1;
			tmp_gate2.gate_trip = tmp_trip1;
			
			_mech_solid.add(tmp_gate1);
			_mech_solid.add(tmp_gate2);
			
			var tmp_pad:PressurePad = new PressurePad(560, 408);
			tmp_pad.setPrime(3);
			tmp_pad.set_hold();
			tmp_trip1.add(tmp_pad);
			_mech_permeable.add(tmp_pad);
			
			var tmp_switch:ToggleSwitch = new ToggleSwitch(760, 328);
			tmp_switch.setPrime(3);
			tmp_switch.set_switch();
			tmp_trip1.add(tmp_switch);
			_mech_permeable.add(tmp_switch);
			
			
		}
		
		override public function addChix(chix:FlxGroup):void {
			var i : int;
			for (i=0; i< chix.length;i+=1){
				chix.members[i].x= 200;
				chix.members[i].x= 200;
			}
		}

		
		override public function generateTextGroup(_text : FlxGroup):void {
			//Override to set _textGroup.
			
			var text1:FlxText = new FlxText(200,FlxG.height*1/4,FlxG.width/2);
			text1.setFormat(null,16,0xFFFFFFFF,"center")
			text1.shadow = 0xff000000;
			text1.text = "Once she had to leave her child to sit on a button for a short while.  She did this by pressing Space.";

			_text.add(text1);
		}
	}
	
}