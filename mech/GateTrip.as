package mech {
	import org.flixel.*;
	import mech.MechInput;
	
	public class GateTrip {
		private var totalOut : int;
		public var mech_arry : Array;
	
		public function GateTrip() {
			mech_arry = [];
		}
		
		public function pull_total_output() : int {
			var i : int = 0;
			
//			trace("Started pull_total");
			totalOut = 1;
			for (i = 0; i < mech_arry.length; i += 1){
				totalOut *= mech_arry[i].pull_output();
//				trace("totalout=" + totalOut);
			}
			// for (i = 0; i < _target_arry.length; i += 1) _target_arry[i].incite_total *= totalOut;
//			trace("Pull_total_output produced " + totalOut);
			return totalOut;
		}
		
		public function add(_nu_mech : MechInput) : void{
			mech_arry.push(_nu_mech);
		}
		
		
		public function trip_len() : int {
			return mech_arry.length;
		}
	}
}