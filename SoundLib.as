package
{
	import org.flixel.FlxSound;
	
	public class SoundLib
	{
		//1) The CLASS is the embedded thing, needs to be turned into a FlxSound
		[Embed(source = "assets/sounds/music_motherly.mp3")]
		private static var music_motherly:Class;
		//COPY AND EDIT THE TWO LINES ABOVE TO CREATE A NEW FILE		
		[Embed(source = "assets/sounds/music_electronic_bass_panic.mp3")]
		private static var music_panic:Class;
		[Embed(source = "assets/sounds/LowBuntSound.mp3")]
		private static var music_longkick:Class;
		[Embed(source = "assets/sounds/DuckinWater1.mp3")]
		private static var music_duckinwater:Class;
		[Embed(source = "assets/sounds/Bass1.mp3")]
		private static var music_bass1:Class;
		[Embed(source = "assets/sounds/ambient_cricketsandnoise.mp3")]
		private static var music_crickets:Class;
		[Embed(source = "assets/sounds/footstep.mp3")]
		private static var music_footstep:Class;
		
		//DUCKLING NOISES
		[Embed(source = "assets/sounds/chubbers.mp3")]
		private static var music_chubbers:Class;
		[Embed(source = "assets/sounds/eggar.mp3")]
		private static var music_eggar:Class;
		[Embed(source = "assets/sounds/stretch.mp3")]
		private static var music_stretch:Class;
		
		//2) The SOUND is something you can start/stop from wherever,
		//via SoundLib.blar_sound.play() or SoundLib.blar.stop(), copy the line below and paste to add
		public static var music_motherly_sound:FlxSound;
		public static var music_panic_sound:FlxSound;
		public static var music_shortkick_sound:FlxSound;
		public static var music_longkick_sound:FlxSound;
		public static var music_duckinwater_sound:FlxSound;
		public static var music_bass1_sound:FlxSound;
		public static var music_crickets_sound:FlxSound;
		public static var music_footstep_sound:FlxSound;
		
		
		//duckling noises
		public static var music_chubbers_sound:FlxSound;
		public static var music_eggar_sound:FlxSound;
		public static var music_stretch_sound:FlxSound;
		
		
		
		/*STATIC BLOCK FOR LIFE BITCHES*/
		
		{
			//3) On creation, turns the embedded classes into FlxSounds,
			// COPY THE TWO LINES BELOW AND PASTE THEM IN THIS FUNCTION.  THEN GO TO PROPER FILE AND PLACE SOUNDLIB.BAR_SOUND.PLAY();
			music_motherly_sound = new FlxSound();
			music_motherly_sound.loadEmbedded(music_motherly);
			music_motherly_sound.volume = 0.8;
			
			music_panic_sound = new FlxSound();
			music_panic_sound.loadEmbedded(music_panic, true);
			music_panic_sound.volume = 0.8;
			
			music_longkick_sound = new FlxSound();
			music_longkick_sound.loadEmbedded(music_longkick);
			music_longkick_sound.volume = 1.0;
			
			music_duckinwater_sound = new FlxSound();
			music_duckinwater_sound.loadEmbedded(music_duckinwater, true); // true makes the piece loop
			music_duckinwater_sound.volume = 0.5;
			
			music_bass1_sound = new FlxSound();
			music_bass1_sound.loadEmbedded(music_bass1, true);
			music_bass1_sound.volume = 0.3;
			
			music_crickets_sound = new FlxSound();
			music_crickets_sound.loadEmbedded(music_crickets, true);
			music_bass1_sound.volume = 0.5;
			
			music_footstep_sound = new FlxSound();
			music_footstep_sound.loadEmbedded(music_footstep, true);
			
			//DUCKLING NOISES
			music_chubbers_sound = new FlxSound();
			music_chubbers_sound.loadEmbedded(music_chubbers);
			music_eggar_sound = new FlxSound();
			music_eggar_sound.loadEmbedded(music_chubbers);
			music_stretch_sound = new FlxSound();
			music_stretch_sound.loadEmbedded(music_chubbers);
		}
	}
}