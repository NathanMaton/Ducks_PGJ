package actors {
	import org.flixel.*;
	
	public class Duckling extends FlxSprite {
		public var isFollowing : Boolean;
		public var follow_duck : FlxSprite;
		public var puntTimer : Number;

		public var isAirborne : Boolean;
		public var isJumping : Boolean
		public var isPunt : Boolean;		
		public var isFlutter : Boolean = false;
	
		public function Duckling() {
			super();
			this.maxVelocity.x = Const.ducklingVelocityMax_X;
			this.maxVelocity.y = Const.ducklingVelocityMax_Y;
			isFollowing = false;
		
			isAirborne = true;
			isJumping = false;
			isFlutter = false;
			isPunt = false;
			puntTimer = 0;
		}

		//Used only once - when ducklings initiated
		public function setFollowDuck(duck : FlxSprite):void {
			follow_duck = duck;
		}
		
		override public function update():void {
			//Duckling gets custom position code.
			//Change in pos between you and followee
			var delta_pos : int;
			
			//Set accel
			acceleration.x = 0;
			acceleration.y = Const.gravity;
			
			//Do a little random motion? (or not)
			//if (isFollowing) velocity.x += 2*(Math.random() - 0.5) * Const.ducklingRandomVelocity_X;

			//Flutter affects downward accel.
			if (isFlutter) { acceleration.y *= .5; }			
			
			//Normal follow behavior:
			if (isFollowing && !isPunt){
				maxVelocity.x =  Const.ducklingVelocityMax_X;
				
				//Center to center in X
				delta_pos = x + width/2 - (follow_duck.x + follow_duck.width/2);
				if ( FlxU.abs(delta_pos) > Const.ducklingFollowLeash ) {
					acceleration.x -= delta_pos * Const.ducklingFollowX;
					//trace(this + ' delta pos: ' + delta_pos);
				}
				else {
					//If distance is not large enough, slow down
					drag.x = FlxU.abs(velocity.x) * Const.ducklingDrag_X;
				}
				
				//Reuse variable for y
				delta_pos = y+height/2 - (follow_duck.y+follow_duck.height/2);
				var jumpValue:Number = (50 - FlxU.abs(velocity.x) * 0.2);
				
				//Shall we jump?
				if (!isAirborne && (delta_pos > jumpValue)) {
					//trace("My dist=" + delta_pos +", jump value = " + jumpValue);
					//Jump trigger linked to distance and your speed
					velocity.y -= Const.ducklingJumpImpulse;
					isAirborne = true;
					isJumping = true;
				}
				//If we ARE airborne, shall we flutter?
				else if (isAirborne) {
					if (velocity.y > Const.ducklingFlutterThreshold) {
						isFlutter = true;
					}
				}
				
			}
			
			//Extra drag if just chilling lonely
			if (!isFollowing && !isPunt && !isFlutter){
				maxVelocity.x = Const.ducklingVelocityMax_X;
				drag.x = Const.ducklingDrag_X * FlxU.abs(velocity.x);
			} 
			if (isPunt || isFlutter){ 
				maxVelocity.x =  Const.longPuntVelocityMax_X; 
				drag.x = Const.ducklingDrag_X;
			} 
			
			//Before we leave, decrement the puntTimer.
			if (puntTimer > 0) {
				//trace(puntTimer);
				puntTimer -= FlxG.elapsed;
			}
			
			super.update();
		}
		
		public function bePunted(longPunt:Boolean, facingLeft:Boolean):void {
			drag.x = 0;
			if (longPunt) { trace("Long punt!");
			} else { trace("Tiny punt!");
			}
			//Actually do the physical punt.
			velocity.x = (longPunt) ? Const.longPuntVelocityMax_X : Const.tinyPuntVelocityMax_X;
			velocity.y = (longPunt) ? -1 * Const.longPuntVelocityMax_Y : -1 * Const.tinyPuntVelocityMax_Y;
			if (facingLeft) velocity.x *= -1;
			//Now stay put for ducklingNoFollowTime, regardless of long or short punt.
			puntTimer = Const.ducklingNoFollowTime;
			isPunt = true;
			isFollowing = false;
			isFlutter = false;
		}
		
		public function tileCollision(floorTile:FlxObject):void {
			if (this.isTouching(FlxObject.FLOOR)) {
				this.isPunt = false;
				this.isAirborne = false;
				this.isJumping = false;
				this.isFlutter = false;
			}
		}
		public function chickOverlap(chickOther:Duckling):void {
			//Do nothing!  Unless you are fat maybe.
		}
	}
}