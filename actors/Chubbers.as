package actors {

	import org.flixel.*;
	
	public class Chubbers extends Duckling {

		[Embed(source='../assets/duck_chubbers_sprites.gif')]
		private var animSprites:Class;	
		
		public function Chubbers(){
			super();
//			this.makeGraphic(32, 32, 0xffff0000);
			this.loadGraphic(animSprites, true, true, 32, 32);
			this.addAnimation("idle", [0,1], 5);
			this.addAnimation("walk", [2,3], 10);
			this.addAnimation("flutter", [4,5], 5);
			this.addAnimation("jump", [5], 5, false);
			this.addAnimation("bounce", [6,7,6,8], 10);
			this.play("idle");
			this.facing = FlxObject.RIGHT;

//			//Fix the bounding box
//			this.height = 42;
//			this.width = 29;
//			this.offset = new FlxPoint(17,22);
		}
		
		override public function update():void {
			//ANIMATIONS
			//Bounce/punt if punted
			//Jump if jumping
			//Flutter if fluttering
			//Walk when velocity x above thresh and you're not airborne
			//Idle if none of the above _nor_ airborne.
			
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

		//CHUBBERS POWER: SUPERBOUNCINESS WITH OTHER CHIX
		//(And also quick fall, as a fatass?  Only in Sam's mind.)
		//(Maybe he bounces extra high after hitting ground?  Later?)
		
		override public function chickOverlap(chickOther:Duckling):void {
			//If he's not attached, then the other guy gets high.
			if (chickOther.isPunt) {
				trace("Chick punt!!!");
				chickOther.velocity.y -= 2* Const.ducklingJumpImpulse;
			}
		}

		
	}
}