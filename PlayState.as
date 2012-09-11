package
{
	
	import actors.*;
	
	import flash.geom.Point;
	
	import levels.*;
	
	import mech.*;
	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public var _curLevel:Number;
		private var _levelArray:Array;
		
		//The PLAYSTATE holds the following ITEMS/GROUPS at all times:
		public var _mama : MamaDuck;
		public var _curTiles : FlxTilemap;
		public var _chix : DucklingGroup;
		public var _mech_solid : FlxGroup;
		public var _mech_permeable : FlxGroup;
		public var _text : FlxGroup;
		public var _flavor : FlxGroup;
		
		//		[Embed(source="assets/nikko_tiles_01.png")]
		[Embed(source="assets/tiles_01.png")]
		public static var ImgTiles:Class;
		
		override public function create():void
		{
			super.create();
			
			//Set the background color (0xAARRGGBB)
			FlxG.bgColor = 0xff66cccc;
			
			//Create MAMA DUCK (a red box)
			_mama = new MamaDuck();
			
			//Set up the groups.
			generateDucklingGroup();  // _chix = new DucklingGroup(); //Empty!
			_mech_solid = new FlxGroup();
			_mech_permeable = new FlxGroup();
			_text = new FlxGroup();
			_flavor = new FlxGroup();
			
			//Pop the level array
			generateLevelArray();
			
			//"Change" to starting level, which sets Mama position,
			//and puts all of the groups into the state...
			_curLevel = Const.startingLevel;
			changeLevel(_curLevel, Const.entryCode_Drop);	
			
			//Now we can set the camera...
			resetCamera();
			
		}
		
		override public function update():void
		{
			//Updates all the objects appropriatelyes
			super.update();	
			
			//Collision madness... how everything happens in flixel...
			FlxG.collide(_curTiles,_mama, resetMamaJump);
			FlxG.collide(_curTiles, _chix, tileChickCollision);
			FlxG.overlap(_chix, _chix, chickChickOverlap);
			FlxG.overlap(_mama, _chix, mamaChickOverlap);
			FlxG.collide(_mech_solid, _chix);
			FlxG.collide(_mech_solid, _mama, resetMamaJump);
			FlxG.overlap(_mech_permeable, _chix, tripMechInput);
			FlxG.overlap(_mech_permeable, _mama, tripMechInput);
			
			//Update chix position
			_chix.peckingOrder(_mama);

			//Check for mama leaving level boundaries.
			var rightBound:Number = _curTiles.width - _mama.width + Const.exitBufferPx;
			var leftBound:Number = -1 * Const.exitBufferPx;
			if(_mama.x > rightBound) {
				trace("Touching right bound: x=" + _mama.x + ", bound=" + rightBound);
				_mama.x = rightBound; // Snap back
				//IF the ducklings are with you, attempt to change levels.
				if (checkForDuckUnity(_mama)) {
					changeLevel(_curLevel+1, Const.entryCode_FromLeft);
				}
			} else if(_mama.x < leftBound) {
				trace("Touching left bound: x=" + _mama.x + ", bound=" + leftBound);
				_mama.x = leftBound;
				//Try changing levels left.  This tends to kill puppies.
				if (checkForDuckUnity(_mama)) {
					changeLevel(_curLevel-1, Const.entryCode_FromRight);
				}				
			}
			
			//Check for DUCKLINGS leaving level boundaries.
			var i : int;
			for (i=0; i < _chix.length; i+=1){
				rightBound = _curTiles.width - _chix.members[i].width;
				leftBound = 0;
				if(_chix.members[i].x > rightBound) {
					//trace("DUCKLING touching right bound: x=" + _chix.members[i].x + ", bound=" + rightBound);
					_chix.members[i].x = rightBound;//If duckling touches edge
				} else if(_chix.members[i].x < leftBound) {
					//trace("DUCKLING touching left bound: x=" + _chix.members[i].x + ", bound=" + leftBound);
					_chix.members[i].x = leftBound;
				}
			}
			
			//DEBUGGING AREA
			//Test the checkForDuckUnity function and change the sky text accordingly.
			//_text.members[0].text = checkForDuckUnity(_mama) ? "YES" : "NO!!!!!";
		}
		
		private function checkForDuckUnity(mama : MamaDuck): Boolean {
			//Get bounding box around current Mama center.
			var rightBound:Number = mama.x + mama.width/2 + Const.ducklingCheckBox_W/2;
			var leftBound:Number = mama.x + mama.width/2 - Const.ducklingCheckBox_W/2;			
			var upperBound:Number = mama.y + mama.height/2 - Const.ducklingCheckBox_H/2;
			var lowerBound:Number = mama.y + mama.height/2 + Const.ducklingCheckBox_H/2;
			
			//For every duckling, check to see if in box.
			var i : int;
			for (i=0; i < _chix.length; i+=1){
				var chickX : int = _chix.members[i].x + _chix.members[i].width/2;
				var chickY : int  = _chix.members[i].y + _chix.members[i].height/2;
				if ((chickX < leftBound) ||
					(chickX > rightBound) ||
					(chickY < upperBound) ||
					(chickY > lowerBound)) {
					return false;					
				}
			}			
			return true;			
		}
		
		private function generateLevelArray():void {
			_levelArray = new Array();
			_levelArray.push(new Level01());
			_levelArray.push(new Level02());
			_levelArray.push(new MiniGolf1());
			_levelArray.push(new Nikko01());
		}
		
		//This function creates/populates ducklings
		private function generateDucklingGroup():void {
			_chix = new DucklingGroup();

//			var i : Number;
//			var maxChix : Number = 10;
//			for (i=0; i < maxChix; i++) {
//				var generic:Generic = new Generic();
//				generic.setFollowDuck(_mama);
//				_chix.add(generic);	
//			}
			
			var chubchub:Chubbers = new Chubbers();
			chubchub.setFollowDuck(_mama);
			_chix.add(chubchub);
			
			var stretch:Stretch = new Stretch();
			stretch.setFollowDuck(_mama);
			_chix.add(stretch);
			
			var eggegg:Eggers = new Eggers();
			eggegg.setFollowDuck(_mama);
			_chix.add(eggegg);									
		}		
		
		private function changeLevel(whichLevel:Number, entryCode:uint):void
		{
			_curLevel = whichLevel;			
			if (_curLevel > Const.levelMax) {
				_curLevel = Const.levelMax;
				trace("Attempted to change to level max+1!");
				winGame();
				return
			}
			
//			//SOUND HACK
//			switch (whichLevel) {
//				case 0:
//					SoundLib.music_duckinwater_sound.play();
//					break;
//				case 1:
//					SoundLib.music_duckinwater_sound.stop();
//					SoundLib.music_bass1_sound.play();
//					break;
//				case 2:
//					SoundLib.music_bass1_sound.stop();
//					SoundLib.music_panic_sound.play();
//					break;
//				
//			}

			//Cleanup.  Vicious...
			this.clear(); //WIPES STATE.. but doesn't actually destroy anything!
			//Will maybe have to do a lot of shit by HAND else face crazy memory problems
			remove(_mech_solid);
			remove(_mech_permeable);
			remove(_flavor);
			remove(_text);
			_mech_solid.destroy();
			_mech_permeable.destroy();
			_flavor.destroy();
			_text.destroy();
			_mech_solid = new FlxGroup();
			_mech_permeable = new FlxGroup();
			_text = new FlxGroup();
			_flavor = new FlxGroup();
			
			//Grab the new LEVEL and call its generate functions.
			var newLevel:Level = _levelArray[_curLevel];
			
			//Create new tilemap
			_curTiles = new FlxTilemap();
			_curTiles.loadMap(newLevel._mapString,ImgTiles,16,16);
			
			//Generate whatever groups the level has
			newLevel.generateMechGroups(_mech_solid, _mech_permeable);
			newLevel.generateSpriteGroup(_flavor);
			newLevel.generateTextGroup(_text);
			
			//Have to add those groups back to the state:
			add(_flavor);
			add(_mama);
			add(_curTiles);
			add(_chix);
			add(_mech_solid);
			add(_mech_permeable);
			add(_text);
			
			//UPDATE THE F'ING WORLD BOUNDS WHICH NO ONE TOLD ME ABOUT
			FlxG.worldBounds = new FlxRect(0,0,_curTiles.width, _curTiles.height);
			
			//Call this mystical function.
			resetCamera();
			
			//Finally, move the player and d-lings.			
			switch (whichLevel) {
				//HAX
				case 2:
					_mama.y -= 130;
					break;
			}
			var mamaButtPos:Number;
			switch(entryCode) {
				case Const.entryCode_Drop:
					// Move the player... to the center of the screen?  In the sky?
					_mama.x = newLevel._startPoint.x;
					_mama.y = newLevel._startPoint.y;
					_chix.centerAllAtPoint(_mama.x + _mama.width/2, _mama.y);
					break;
				case Const.entryCode_FromLeft:
					_mama.x = (-1 * Const.exitBufferPx) + Const.exitFudgePx; //Somewhat offscreen
					mamaButtPos = _mama.x+_mama.width/2; 
					_chix.centerAllAtPoint(mamaButtPos, _mama.y);
					trace("Placed Mama at x=" + _mama.x);
					break;
			}
			
			trace("Changed to level " + _curLevel);
		}
		
		//------------COLLISION FUNCTIONS------------
		
		private function chickChickOverlap(_chick_A : Duckling, _chick_B :Duckling) :void {
			_chick_A.chickOverlap(_chick_B);
			_chick_B.chickOverlap(_chick_A);
		}
		
		private function tileChickCollision(floor_tile : FlxObject, _chick_landed : Duckling):void
		{
			_chick_landed.tileCollision(floor_tile);
		}
		
		private function mamaChickOverlap(_mama_overlap : MamaDuck, _chick_overlap : Duckling):void {
			//FIRST check for possible kick.
			if (_mama_overlap.kickFlag || _mama_overlap.dropduckFlag){
				//Define the kickbox.
				var facingLeft : Boolean = (_mama_overlap.facing == FlxObject.LEFT);
				var kickBox: FlxRect;
				if (facingLeft) {
					kickBox = new FlxRect(_mama_overlap.x - _mama_overlap.width/2, _mama_overlap.y + _mama_overlap.height/2, _mama_overlap.width, _mama_overlap.height/2);
				} else {
					kickBox = new FlxRect(_mama_overlap.x + _mama_overlap.width/2, _mama_overlap.y + _mama_overlap.height/2, _mama_overlap.width, _mama_overlap.height/2);
				}
				//If in the kickbox, decide what to do.
				if (kickBox.overlaps(new FlxRect(_chick_overlap.x, _chick_overlap.y, _chick_overlap.width, _chick_overlap.height))) {
					var tmp_duckling : Duckling;
					//Which kick?
					//If both flags are up, do the longer punt.
					if (_mama_overlap.kickFlag) {
						_chick_overlap.bePunted(true, facingLeft);		
					} else if (_mama_overlap.dropduckFlag) {
						_chick_overlap.bePunted(false, facingLeft);
					}
				}
				//Regardless of whether you kick or not, you're sure not kicking now.
				_mama_overlap.kickFlag = false;
				_mama_overlap.dropduckFlag = false;
				
			} else if (!_chick_overlap.isFollowing && (_chick_overlap.puntTimer <= 0)) {
				//THEN check for chick gathering.
				trace("Mama Chick collision... chick aquired!")
				_chick_overlap.isFollowing = true;
				_chick_overlap.follow_duck = _mama;
			}
		}
		
		//------------OTHER FUNCTIONS------------
		
		private function resetCamera():void {
			FlxG.camera.follow(_mama,FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(Const.cameraLeftBoundPx,
				Const.cameraUpperBoundPx,
				_curTiles.width - Const.cameraRightBoundPx,
				_curTiles.height - Const.cameraLowerBoundPx);
		}
		
		private function resetMamaJump( unused1 : FlxObject, unused2 :MamaDuck):void {
			//Mama probably shoulda handled this herself.  No time to refactor!
			if (_mama.isTouching(FlxObject.FLOOR)) {
				_mama.isAirborne = false;
			}
		}
		
		public function tripMechInput(_mech_overlap : MechInput, _unused : FlxSprite) : void{
			_mech_overlap.trip_touch();
		}
		
		private function winGame():void {
			FlxG.switchState(new WinState());
		}		
		
	}
}
