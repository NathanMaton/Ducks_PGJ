package
{
	import org.flixel.*;
	
	public class BGLib
	{
		[Embed(source="/assets/TitleScreen.png")]
		public static var bgImgIntro : Class;		
		[Embed(source="/assets/EndScreen.png")]
		public static var bgImgOutro : Class;		
		[Embed(source = "/assets/bgPainting_00.png")]
		public static var bgImg00:Class;
		[Embed(source = "/assets/bgPainting_01.png")]
		public static var bgImg01:Class;
		[Embed(source = "/assets/bgPainting_04.png")]
		public static var bgImg04:Class;
		
		public static var bgIntro:FlxSprite;
		public static var bgOutro:FlxSprite;
		public static var bg00:FlxSprite;
		public static var bg01:FlxSprite;
		public static var bg04:FlxSprite;
		
		/*STATIC BLOCK FOR LIFE BABY*/
		{			
			bgIntro = new FlxSprite(0,0,bgImgIntro);
			bgOutro = new FlxSprite(0,0,bgImgOutro);
			bg00 = new FlxSprite(0,0,bgImg00);
			bg01 = new FlxSprite(0,0,bgImg01);
			bg04 = new FlxSprite(0,0,bgImg04);
		}
	}
}