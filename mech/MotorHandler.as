package mech {
	import flash.geom.Point;

	public class MotorHandler{
		public var prime_identifier :uint;
		public var rotation_angle : Number;
		public var translation_point : Point;
		public var scale_point : Point;
		
		public var progress_percent : Number;
		
		public function MotorHandler( prime_in : uint, tran_in : Point, rot_in : Number, scal_in : Point ){
			prime_identifier = prime_in;
			rotation_angle = rot_in;
			translation_point = tran_in;
			scale_point = scal_in;
			
			progress_percent = 0;
		}
		
		public function scale_motion(isWaxing : Boolean, update_elapsed : Number) : void{
			if (isWaxing){
				if (progress_percent >= 1) { progress_percent = 1; }
				else { progress_percent += update_elapsed; }
			}
			else
			{
				if (progress_percent <= 0) { progress_percent = 0; }
				else { progress_percent -= update_elapsed; }
			}
		}
	}
}