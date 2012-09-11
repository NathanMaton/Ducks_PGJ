package actors {

	import org.flixel.*;
	
	public class Generic extends Duckling {

		[Embed(source='../assets/duckling_sprites.gif')]
		private var animSprites:Class;
		
		public function Generic() {
			super();
			this.loadGraphic(animSprites, true, true, 32, 32);
			this.addAnimation("idle", [0,0,1,0,0,0,0,2], 5);
			this.addAnimation("walk", [2,3,4,5,6,5,3], 10);
			this.addAnimation("flutter", [8,9,10,9], 5);
			this.addAnimation("jump", [7], 5, false);
			this.addAnimation("bounce", [11,12,13,12], 10);
			this.play("idle");
			this.facing = FlxObject.RIGHT;

//			//Fix the bounding box
//			this.height = 42;
//			this.width = 29;
//			this.offset = new FlxPoint(17,22);
		}
		
		override public function update():void {
			//Update facing
			if (velocity.x < 0) {
				this.facing = FlxObject.LEFT;
			} else {
				this.facing = FlxObject.RIGHT;
			}
			
			if (isPunt) {
				this.play("bounce");
				//trace('bounce');
			} else if (isJumping) {
				this.play("jump");
				//trace('jump');
			} else if (isFlutter) {
				this.play("flutter");
				//trace('flutter');
			} else if (Math.abs(acceleration.x) > Const.ducklingIdleThreshold) {
				this.play("walk");
				//trace('walk');
			} else if (!isAirborne) {
				this.play("idle");
				//trace('idle');
			}
			
			//Do normal physics, and then...
			super.update();
		}
	}
}