package mech {
	import org.flixel.*;
	import flash.geom.Point;
	
	public class GatePlate extends FlxSprite {
		public var incite_total : int;
		public var motion_array : Array;
		public var gate_trip: GateTrip;
		
		public var debug_text : FlxText;
		
		private var base_x : Number;
		private var base_y : Number;
		private var base_theta : Number;
		
		private static var pnt_zero : Point = new Point(0, 0);
		
		[Embed(source="../assets/gate_plate.gif")]
		private var plate_img : Class;
	
		public function GatePlate(pos_x : int, pos_y : int, facing_ : uint) {
			motion_array = [];
			
			this.loadGraphic(plate_img, true, true, 16, 48);
			this.facing = facing_;
			
			base_x = pos_x;
			base_y = pos_y;
			
			debug_text = new FlxText(10, 60, 150);
		}
		
		public function defineMotion(str_in : String) : void {
			var i : uint;
			var tmp_motion_arry : Array = [];
			
			tmp_motion_arry = str_in.split('\n');
			
			for ( i=0; i< tmp_motion_arry.length; i +=1 ){
				
			}
		}
		
		public function addMotion(_prime : int, tran_in : Point, rot_in : Number, scal_in : Point) : void {
			motion_array.push( new MotorHandler( _prime, tran_in, rot_in, scal_in ) );
		}
		
		public function addTranslate(_prime : int, _delt_x : int, _delt_y : int) : void{
			motion_array.push( new MotorHandler(_prime, new Point(_delt_x, _delt_y), 0, pnt_zero ) );
		}
		
		override public function destroy() : void {
			gate_trip = null;
			super.destroy();
		}
		
		override public function update():void{
			var i : uint;
			var tmp_check : Boolean;
			var offset_x : int = 0;
			var offset_y : int = 0;
			
			
			
			incite_total = gate_trip.pull_total_output();
			
			debug_text.text = ""+incite_total + "\n" + gate_trip.mech_arry.length;
			
			for (i = 0; i < motion_array.length; i += 1){
				tmp_check = (incite_total % motion_array[i].prime_identifier == 0 && incite_total != 0);
				motion_array[i].scale_motion(tmp_check, FlxG.elapsed);
				offset_x += motion_array[i].translation_point.x * motion_array[i].progress_percent;
				offset_y += motion_array[i].translation_point.y * motion_array[i].progress_percent;
			}
			
			x = base_x + offset_x;
			y = base_y + offset_y;
			
			velocity.x = 0;
			velocity.y = 0;
		
			super.update();
		}
	}
}