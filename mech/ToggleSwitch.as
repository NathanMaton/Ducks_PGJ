package mech {
	import org.flixel.*;
	import mech.MechInput;
	
	public class ToggleSwitch extends MechInput {

		[Embed(source='../assets/toggle_switch.gif')]
		private static var switch_sprite : Class;
	
		public function ToggleSwitch(pos_x : int, pos_y : int):void {
			this.loadGraphic(switch_sprite, true, true, 16, 16);
			
			this.addAnimation("off", [0], 1, false);
			this.addAnimation("on", [1], 1, false);
			
			x = pos_x;
			y = pos_y;
			
			outTrueFalse = false;
			play("off");
		}
		
		override public function update() : void {
			if (!outTrueFalse) {
				play("up");
			}
			super.update();
		}
		
		override public function trip_touch() : void {
			super.trip_touch();
			play("on");
		}
		
		override public function setPrime(_prime : int) : void{
			super.setPrime(_prime);
		}
		
		override public function pull_output() : int {
			return super.pull_output();
		}
	}
}