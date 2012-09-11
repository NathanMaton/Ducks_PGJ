package
{
	public final class Const
	{
		public static var startingLevel:uint = 0;
		public static var levelMax:uint = 5;

		public static var startingX:Number = 90;
		public static var startingY:Number = 240;

		public static var mamaSize_X:uint = 60;
		public static var mamaSize_Y:uint = 60;

		public static var mamaVelocityMax_X:Number = 100;
		public static var mamaVelocityMax_Y:Number = 200;
		public static var mamaJumpImpulse:Number = 180;
		public static var mamaDrag_X : Number = 1;

		public static var ducklingVelocityMax_X : Number = 80;
		public static var ducklingVelocityMax_Y : Number = 400;
		public static var ducklingDrag_X : Number = 3;
		public static var ducklingJumpImpulse:Number = 180;
		public static var ducklingHugFactor : Number = 1/4; //More hug = stays closer to you
		public static var ducklingFollowLeash: Number = 20;
		public static var ducklingFollowX : Number = 3;
		public static var ducklingRandomVelocity_X : Number = 10;
		public static var ducklingIdleThreshold : Number = 16; //For animation, in x-velocity
		public static var ducklingFlutterThreshold : Number = 100;
		public static var ducklingNoFollowTime : Number = 2; //sec

		public static var gravity:Number = 300;
		public static var flutterMod : Number = 0.1;
		public static var flutterVelocityMax_Y:Number = 100;
		
		public static var tinyPuntVelocityMax_X : Number = 30;
		public static var tinyPuntVelocityMax_Y : Number = 20;
		public static var longPuntVelocityMax_X : Number = 190;
		public static var longPuntVelocityMax_Y : Number = 150;
		public static var chubPuntVelocityMax_X : Number = 100;
		
		public static var chubBounciness : Number = 0.5;  //0 - 1, factor of velocity kept

		public static var cameraBufferPx:uint = 40;
		public static var cameraLeftBoundPx:uint = 16;
		public static var cameraUpperBoundPx:uint = 0;
		public static var cameraRightBoundPx:uint = 16;
		public static var cameraLowerBoundPx:uint = 16; //From bottom of screen
		
		public static var exitBufferPx:uint = 10; //px
		public static var exitFudgePx:uint = 4; //px, extra distance into screen on change
												//not necessary if maps line up properly.
		
		public static var kickTimeout:Number = 0.5; //seconds
		
		public static var ducklingCheckBox_W : Number = 600;
		public static var ducklingCheckBox_H : Number = 200;
		
		//Silly enums
		public static var entryCode_Drop:uint = 1;
		public static var entryCode_FromLeft:uint = 2;
		public static var entryCode_FromRight:uint = 3;
		
	}
}