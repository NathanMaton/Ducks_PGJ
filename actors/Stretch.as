package actors {

	import org.flixel.*;
	import Const;
	
	public class Stretch extends Duckling {

		[Embed(source='../assets/duck_stretch_sprites.gif')]
		private var animSprites:Class;	
		
		public function Stretch(){
			super();
//			this.makeGraphic(32, 32, 0xff0000ff);
			this.loadGraphic(animSprites, true, true, 32, 32);
			this.addAnimation("idle", [0,0,0,1,0,0,2,2,2,0,0], 5);
			this.addAnimation("flutter", [3,4,3,5], 5);
			this.addAnimation("jump", [4], 5, false);
			this.addAnimation("walk", [6,7,8,9,10,11,12,13], 10);
			this.addAnimation("bounce", [4], 10);
			this.play("idle");
			this.facing = FlxObject.RIGHT;
	}
		
		//STRETCH POWER: SUPERPUNT
		override public function update():void {	
			//Maybe should override bePunted, rather than this function?			
			// during a punt, the chick should go crazy fast

			//Update facing
			if (velocity.x < 0) {
				this.facing = FlxObject.LEFT;
			} else {
				this.facing = FlxObject.RIGHT;
			}
			
			if (isPunt) {
				this.play("bounce");
//				trace('bounce');
			} else if (isJumping) {
				this.play("jump");
//				trace('jump');
			} else if (isFlutter) {
				this.play("flutter");
//				trace('flutter');
			} else if (Math.abs(acceleration.x) > Const.ducklingIdleThreshold) {
				this.play("walk");
//				trace('walk');
			} else if (!isAirborne) {
				this.play("idle");
//				trace('idle');
			}

			super.update();
		}
		
		override public function bePunted(longPunt:Boolean, facingLeft:Boolean):void {
			super.bePunted(longPunt, facingLeft);
			//This guy is SUPERPUNT.  Just re-do the velocity part.		
			velocity.x = (longPunt) ? 0.28 * Const.longPuntVelocityMax_X : Const.tinyPuntVelocityMax_X;
			velocity.y = (longPunt) ? -1.8 * Const.longPuntVelocityMax_Y : Const.tinyPuntVelocityMax_Y;
			if (facingLeft) velocity.x *= -1;

		}
		
	}
}