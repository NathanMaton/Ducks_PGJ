package mech {
	import org.flixel.*;
	import mech.MechInput;
	
	public class PressurePad extends MechInput {
		
		[Embed(source="../assets/pressure_pad.gif")]
		protected static var switch_sprite : Class;
	
		public function PressurePad(pos_x : int, pos_y : int):void {
			this.loadGraphic(switch_sprite, true, true, 48, 8);
			
			this.addAnimation("up", [0], 1, false);
			this.addAnimation("down", [1], 1, false);
			
			x = pos_x;
			y = pos_y;
		}
		
		override public function update():void {
			if (!outTrueFalse) {
				play("up");
			}
			super.update();
		}
		
		override public function setPrime(_prime : int) : void{
			super.setPrime(_prime);
		}
		
		override public function trip_touch() : void {
			super.trip_touch();
			play("down");
		}
		
		override public function pull_output() : int {
			return super.pull_output();
		}
	}
}