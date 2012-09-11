package levels
{
	import flash.geom.*;
	
	import mech.*;
	
	import org.flixel.*;

	public class Nikko01 extends Level
	{
		[Embed(source = "../assets/nikko_1.txt", mimeType = "application/octet-stream")]
		private var nikko1string : Class;
		
		public function Nikko01():void
		{
			super();
			_mapString = new nikko1string();
			_startPoint = new FlxPoint(350,240);
		}
		
		override public function generateMechGroups(_mech_solid : FlxGroup, _mech_permeable : FlxGroup):void {
//			//This function must be overridden to generate BOTH mech groups.

// 36, 13 GateTrip opens 56, 16-15 GatePlate
// 81,16 opens 85,16-15
// 107,16 opens 112,16-15
// 133,16 opens 138,16

// 153,23 opens 85,112,138
//
			var tmpGate1 : GatePlate;
			var tmpGate2 : GatePlate;
			var tmpPad : PressurePad;
			var tmpSwitch : ToggleSwitch;
			var tmpTrip : GateTrip;

			//Gate in 1 part
			tmpTrip = new GateTrip();
			
			tmpGate1 = new GatePlate(896, 144, FlxObject.RIGHT); //Orientation does what?
			tmpGate2 = new GatePlate(896, 208, FlxObject.RIGHT); //Orientation does what?
			tmpGate1.addMotion(2, new Point(0, 70), 0, new Point(0, 0));
			tmpGate2.addMotion(2, new Point(0, 70), 0, new Point(0, 0));
			tmpGate1.gate_trip = tmpTrip;
			tmpGate2.gate_trip = tmpTrip;
			_mech_solid.add(tmpGate1);
			_mech_solid.add(tmpGate2);
			
			tmpSwitch = new ToggleSwitch(576, 208);
			tmpSwitch.setPrime(2);
			tmpSwitch.set_switch();
			tmpTrip.add(tmpSwitch);
			_mech_permeable.add(tmpSwitch);
			
			// Godly switch
			
			tmpSwitch = new ToggleSwitch(2448, 368);
			tmpSwitch.setPrime(3);
			tmpSwitch.set_switch();
			_mech_permeable.add(tmpSwitch);
			
			// 1st duckling gate
			tmpTrip = new GateTrip();
			
			tmpGate1 = new GatePlate(1360, 144, FlxObject.RIGHT); //Orientation does what?
			tmpGate2 = new GatePlate(1360, 208, FlxObject.RIGHT); //Orientation does what?
			tmpGate1.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate2.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate1.gate_trip = tmpTrip;
			tmpGate2.gate_trip = tmpTrip;
			_mech_solid.add(tmpGate1);
			_mech_solid.add(tmpGate2);
			
			tmpPad = new PressurePad(1296, 265);
			tmpPad.setPrime(2);
			tmpPad.set_hold();
			tmpTrip.add(tmpPad);
			_mech_permeable.add(tmpPad);
			
			tmpTrip.add(tmpSwitch);
			
			// 2nd duckling gate
			tmpTrip = new GateTrip();
			
			tmpGate1 = new GatePlate(1792, 144, FlxObject.RIGHT); //Orientation does what?
			tmpGate2 = new GatePlate(1792, 208, FlxObject.RIGHT); //Orientation does what?
			tmpGate1.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate2.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate1.gate_trip = tmpTrip;
			tmpGate2.gate_trip = tmpTrip;
			_mech_solid.add(tmpGate1);
			_mech_solid.add(tmpGate2);
			
			tmpPad = new PressurePad(1712, 265);
			tmpPad.setPrime(2);
			tmpPad.set_hold();
			tmpTrip.add(tmpPad);
			_mech_permeable.add(tmpPad);
			
			tmpTrip.add(tmpSwitch);
			
			// 3rd duckling gate
			tmpTrip = new GateTrip();
			
			tmpGate1 = new GatePlate(2208, 144, FlxObject.RIGHT); //Orientation does what?
			tmpGate2 = new GatePlate(2208, 208, FlxObject.RIGHT); //Orientation does what?
			tmpGate1.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate2.addMotion(6, new Point(0, 70), 0, new Point(0, 0));
			tmpGate1.gate_trip = tmpTrip;
			tmpGate2.gate_trip = tmpTrip;
			_mech_solid.add(tmpGate1);
			_mech_solid.add(tmpGate2);
			
			tmpPad = new PressurePad(2128, 265);
			tmpPad.setPrime(2);
			tmpPad.set_hold();
			tmpTrip.add(tmpPad);
			_mech_permeable.add(tmpPad);
			
			tmpTrip.add(tmpSwitch);
			
		}
		
		override public function generateSpriteGroup(_flavor : FlxGroup):void {
			_flavor.add(BGLib.bg00);
		}
		
		override public function addChix(chix:FlxGroup) : void {
			var i : int;
			for (i=0; i< chix.length;i+=1){
				chix.members[i].x = _startPoint.x;
				chix.members[i].y = _startPoint.y;
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