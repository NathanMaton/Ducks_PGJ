package mech {
	import org.flixel.*;
	
	public class MechInput extends FlxSprite {
		protected var outActiveValue : int;
		protected var outTrueFalse : Boolean;
		
		protected var timer_length : Number;
		protected var timer_counter : Number;
		
		protected var frame_output : int;
		
		protected var input_type : int = 0;
		
		override public function update() : void {
			if (input_type == 2){
				if (timer_counter <= 0) { timer_counter = 0; outTrueFalse = false; }
				else { timer_counter -= FlxG.elapsed; }
			}
			
			frame_output = outTrueFalse ? outActiveValue : 1;
			
			if (input_type == 0) { outTrueFalse = false; }
			
			super.update();
		}
		
		 public function trip_touch() : void {
			outTrueFalse = true;
			if (input_type == 2){
				timer_counter = timer_length;
			}
		}
		
		public function set_hold() : void{
			input_type = 0;
		}
		
		public function set_switch() : void{
			input_type = 1;
		}
		
		public function set_timer(_t_dur : int = 1) : void{
			input_type = 2;
			timer_length = _t_dur;
		}
		
		public function setPrime(_prime : int) : void{
			outActiveValue = _prime;
		}
		
		public function pull_output() : int {
			return frame_output;
		}
	}
}