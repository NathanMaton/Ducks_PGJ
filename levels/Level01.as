package levels
{
	import flash.geom.*;
	
	import mech.*;
	
	import org.flixel.*;

	public class Level01 extends Level
	{
		[Embed(source = "../assets/sam_level1.txt", mimeType = "application/octet-stream")]
		private var levelString : Class;
		
		public function Level01():void
		{
			super();
			_mapString = new levelString();
		}
		
		override public function generateMechGroups(_mech_solid : FlxGroup, _mech_permeable : FlxGroup):void {
			//This function must be overridden to generate BOTH mech groups.

			var tmpGate1 : GatePlate;
			var tmpGate2 : GatePlate;
			var tmpPad : PressurePad;
			var tmpTrip : GateTrip;
			
			tmpTrip = new GateTrip();

			//Gate in 2 parts
			tmpGate1 = new GatePlate(500, 300, FlxObject.RIGHT); //Orientation does what?
			tmpGate2 = new GatePlate(500, 346, FlxObject.RIGHT); //Orientation does what?
			tmpGate1.addMotion(3, new Point(0, 70), 0, new Point(0, 0));
			tmpGate2.addMotion(3, new Point(0, 70), 0, new Point(0, 0));
			tmpGate1.gate_trip = tmpTrip;
			tmpGate2.gate_trip = tmpTrip;
			_mech_solid.add(tmpGate1);
			_mech_solid.add(tmpGate2);
			
			tmpPad = new PressurePad(250, 360);
			tmpPad.setPrime(3);
			tmpPad.set_switch();
			tmpTrip.add(tmpPad);
			_mech_permeable.add(tmpPad);
		}
		
		override public function generateSpriteGroup(_flavor : FlxGroup):void {
			_flavor.add(BGLib.bg00);
		}
		
		override public function addChix(chix:FlxGroup) : void {
			var i : int;
			for (i=0; i< chix.length;i+=1){
				chix.members[i].x= 50;
				chix.members[i].x= 200;
			}
		}
		
		override public function generateTextGroup(_text : FlxGroup):void {
			//Override to set _textGroup.
			var introText:FlxText = new FlxText(0,FlxG.height*1/4,FlxG.width/2);
			introText.setFormat(null,16,0xFFFFFFFF,"center")
			introText.shadow = 0xff000000;
			introText.text = "A matronly duck gathers her children to guide them to safety.";
			var exitText:FlxText = new FlxText(FlxG.width - 120,FlxG.height*2/3 - 20,100);
			exitText.setFormat(null,24,0xFFFFFFFF,"center")
			exitText.shadow = 0xff000000;
			exitText.text = "EXIT";
			_text.add(introText);
			_text.add(exitText);
		}
	}
	
}