package actors {
	
	import org.flixel.*;
	import Const;
	
	public class Eggers extends Duckling {
		
		[Embed(source='../assets/duck_eggar_sprites.gif')]
		private var animSprites:Class;	
		
		public function Eggers(){
			super();
			this.loadGraphic(animSprites, true, true, 32, 32);
			this.addAnimation("idle", [0,1,2], 5);
			this.addAnimation("walk", [3,4,5,6,7,8,9,10], 10);
			this.addAnimation("flutter", [11,12,13,14], 5);
			this.addAnimation("jump", [11], 5, false);
			this.addAnimation("bounce", [11], 10);
			this.play("idle");
			this.facing = FlxObject.RIGHT;
		}
		
		//EGGERS POWER: FLUTER
		override public function update():void {
			//Update facing
			if (velocity.x < 0) {
				this.facing = FlxObject.LEFT;
			} else {
				this.facing = FlxObject.RIGHT;
			}
			
			if (velocity.y > 0){ isPunt = false; isFlutter = true; }
			
			if (isPunt) {
				this.play("bounce");
			} else if (isJumping) {
				this.play("jump");
			} else if (isFlutter) {
				this.play("flutter");
			} else if (Math.abs(acceleration.x) > Const.ducklingIdleThreshold) {
				this.play("walk");
			} else if (!isAirborne) {
				this.play("idle");
			}
						
			super.update();
		}
		
	}
}