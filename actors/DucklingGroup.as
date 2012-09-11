package actors {
	import org.flixel.*;
	import flash.geom.Point;
	import actors.Duckling;
	
	public class DucklingGroup extends FlxGroup {
		
		override public function update():void {
			super.update();			
		}
		
		public function centerAllAtPoint(x:Number, y:Number):void {
			var i : uint;
			for (i = 0; i < this.length; i+= 1){
				members[i].x = x + members[i].width/2; //No type guarantee here...
				members[i].y = y + members[i].height/2;			
			}
		}
				
		public function peckingOrder(_mama : MamaDuck):void {
			var tmp_order_by_dist : Array = [];
			var tmp_next_duckling : int = -1;
			var i : uint;
			
			// get duckling order by distance
			tmp_order_by_dist = getDucklingOrder(_mama.x + _mama.width/2, _mama.y + _mama.height/2);
			
			// set follow order by skipping ducks without follow condition
			for (i=0; i < tmp_order_by_dist.length; i+=1){
				if (members[tmp_order_by_dist[i]].isFollowing)
				{
					if (tmp_next_duckling == -1){
						members[tmp_order_by_dist[i]].follow_duck = _mama;
					} else {
						members[tmp_order_by_dist[i]].follow_duck = members[tmp_next_duckling];
					}
					tmp_next_duckling = tmp_order_by_dist[i];
				}
			}
			//trace('Order is now: ' + tmp_order_by_dist);
		}
		
		public function getNearestDuckling(point_x : Number, point_y : Number) : Duckling{
			var ref_point : Point = new Point(point_x, point_y);
			var tmp_point : Point;
			var tmp_duckling : Duckling = null;
			var i : uint;
			
			var tmp_dist : Number;
			var min_dist : Number = -1;
			
			for (i = 0; i < this.length; i+= 1){
				tmp_point = new Point(members[i].x + members[i].width / 2, members[i].y + members[i].height / 2);
				tmp_dist = Point.distance(ref_point, tmp_point);
				
				if (min_dist == -1) 
				{ 
					min_dist = tmp_dist; 
					tmp_duckling = members[i]; 
				} else if (tmp_dist < min_dist) {
					min_dist = tmp_dist; 
					tmp_duckling = members[i];
				}
			}
			
			return tmp_duckling;
		}
		
		public function getDucklingOrder(point_x : Number, point_y : Number) : Array{
			var ref_point : Point = new Point(point_x, point_y); //Mama's center, probably
			var dist_arry : Array = [];
			var tmp_point : Point;
			var tmp_ducklings : Array = [];
			var i : uint;
			var j : uint;
			
			var swapper : Number;
			
			var tmp_dist : Number;
			var min_dist : Number = -1;
			
			for (i = 0; i < this.length; i+= 1){
				tmp_point = new Point(members[i].x + members[i].width/2, members[i].y + members[i].height/2);
				tmp_dist = Point.distance(ref_point, tmp_point);
				//trace('Distance is: ' + tmp_dist);
				dist_arry[i] = tmp_dist;
				tmp_ducklings[i] = i;
			}
			
			for (i = 0; i < this.length; i+= 1){               //0, 1, 2
				for (j = i + 1; j < this.length; j += 1){      //1, 2,   then 2
					
					if (dist_arry[i] > dist_arry[j]) { 
						//trace('Swapping ' + i + ' and ' + j);
						//trace('Dists are ' + dist_arry[i] + ' and ' + dist_arry[j]);
						swapper = dist_arry[i];
						dist_arry[i] = dist_arry[j];
						dist_arry[j] = swapper;
						swapper = tmp_ducklings[i];
						tmp_ducklings[i] = tmp_ducklings[j];
						tmp_ducklings[j] = swapper;
					}
				
				}
			}
			
			//trace ('Order is: ' + tmp_ducklings);
			return tmp_ducklings;
		}
	}
}