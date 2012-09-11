package actors
{
	import org.flixel.*;
	import org.flixel.FlxSprite;
	
	public class MamaDuck extends FlxSprite
	{
		public static var main:MamaDuck;
		public var isAirborne : Boolean;
		public var kickCycle : Number;
		public var kickFlag : Boolean;
		public var dropduckFlag : Boolean;

		[Embed(source='../assets/duck_mama_sprites.gif')]
		private var animSprites:Class;	
		
		public function MamaDuck() {
			super(FlxG.width/2 - this.width); //Starting x
			main = this;
			this.maxVelocity.x = Const.mamaVelocityMax_X;
			this.maxVelocity.y = Const.mamaVelocityMax_Y;
			this.acceleration.y = Const.gravity;
			this.drag.x = this.maxVelocity.x* Const.mamaDrag_X;
			this.isAirborne = false;
			
			this.loadGraphic(animSprites, true, true, 64, 64);
			this.addAnimation("idle", [0,0,1,0,0,2], 5);
			this.addAnimation("flutter", [19,18,17,16], 5);
			this.addAnimation("jump", [13,14,15], 5, false);
			this.addAnimation("walk", [3,4,5,6,7,8,9,10,11,12], 10);
			this.addAnimation("kick", [20,21,22,23,24,25,25,26,26,27,27,27], 10, false);
			this.play("idle");
			this.facing = FlxObject.RIGHT;
			//Fix the bounding box
			this.height = 42;
			this.width = 29;
			this.offset = new FlxPoint(17,22);
			kickCycle = 0;
		}
		
		override public function update():void
		{
			this.acceleration.x = 0;
			this.acceleration.y = Const.gravity;

			if(FlxG.keys.UP || FlxG.keys.W){
				if ((!isAirborne) && this.isTouching(FlxObject.FLOOR)) {
					this.velocity.y = -1*Const.mamaJumpImpulse;
					this.play("jump");
					isAirborne = true;
				}
				if ((velocity.y > 0) && (kickCycle <= 0)) {
//					trace("Fluttering!");
					this.play("flutter");
					acceleration.y = Const.gravity * Const.flutterMod;
					if (velocity.y > Const.flutterVelocityMax_Y) {
						velocity.y = Const.flutterVelocityMax_Y;
					}
				}
			}
			if (FlxG.keys.LEFT || FlxG.keys.A) {
				SoundLib.music_footstep_sound.play();
				this.acceleration.x = -this.maxVelocity.x*4;
				this.facing = FlxObject.LEFT;	
				if ((!isAirborne) && (kickCycle <= 0)) this.play("walk");
			}
			if (FlxG.keys.RIGHT || FlxG.keys.D) {
				SoundLib.music_footstep_sound.play();
				
				this.acceleration.x = this.maxVelocity.x*4;
				this.facing = FlxObject.RIGHT;
				if ((!isAirborne) && (kickCycle <= 0)) this.play("walk");
			}
						
			//Deal with kick.
			kickFlag = false;
			dropduckFlag = false;
			//if(FlxG.keys.SPACE && !isAirborne){
			if(FlxG.keys.SPACE){  //Mid-air kicking is fun!
				if (kickCycle <= 0) {
					kickCycle = Const.kickTimeout;
					kickFlag = true;
					this.play("kick");
					SoundLib.music_longkick_sound.play();
				}
			}
			if(FlxG.keys.DOWN){
				if (kickCycle <= 0) {
					kickCycle = Const.kickTimeout;
					dropduckFlag = true;
					this.play("kick");
					SoundLib.music_longkick_sound.play();
				}
			}
			
			if (kickCycle > 0) {
				kickCycle -= FlxG.elapsed;
			}
			
			//Finally, if you haven't pressed _shit_,
			//AND you're not airborne,
			//AND you're not kicking,
			//play the idle.
			var anyOfAbove:Boolean = FlxG.keys.UP || FlxG.keys.W || FlxG.keys.LEFT || FlxG.keys.A || FlxG.keys.RIGHT || FlxG.keys.D;
			if(!anyOfAbove && !isAirborne && kickCycle <= 0) {
				this.play("idle");
			}

			super.update(); //Fizzix
		}		

	}
}