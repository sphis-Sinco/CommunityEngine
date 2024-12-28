package play;

import flixel.sound.FlxSound;


class PlayState extends MusicBeatState
{
	var debugField:FlxText = new FlxText(3, 6, 0, "", 16);

	public var boyfriendCharacter:Character;

	public var Instrumental:FlxSound;
	public var OpponentVocals:FlxSound;
	public var PlayerVocals:FlxSound;

	public var song:String = 'Tutorial';

	override public function create()
	{
		Instrumental = FlxG.sound.load(BackendAssets.track('songs/${song.toLowerCase()}/Inst'));
		OpponentVocals = FlxG.sound.load(BackendAssets.track('songs/${song.toLowerCase()}/Voices-gf'));
		PlayerVocals = FlxG.sound.load(BackendAssets.track('songs/${song.toLowerCase()}/Voices-bf'));

		Instrumental.play();
		OpponentVocals.play();
		PlayerVocals.play();

		Conductor.changeBPM(100);

		boyfriendCharacter = new Character(0, 0, 'bf', true);
		boyfriendCharacter.screenCenter();
		add(boyfriendCharacter);

		#if debug add(debugField); #end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		Conductor.songPosition += FlxG.elapsed * 1000;

		debugField.text = "Beat: " + curBeat;
		debugField.text += "\nStep: " + curStep;

		if (FlxG.keys.anyJustPressed([LEFT, RIGHT, UP, DOWN]))
		{
			var thekey = FlxG.keys.justPressed;

			if (thekey.LEFT)
				boyfriendCharacter.playAnim('singLEFT', true);
			if (thekey.DOWN)
				boyfriendCharacter.playAnim('singDOWN', true);
			if (thekey.UP)
				boyfriendCharacter.playAnim('singUP', true);
			if (thekey.RIGHT)
				boyfriendCharacter.playAnim('singRIGHT', true);

			boyfriendCharacter.singing = true;
		}
		else if (!FlxG.keys.anyPressed([LEFT, RIGHT, UP, DOWN]))
		{
			boyfriendCharacter.singing = false;
		}

		super.update(elapsed);
	}

	override function beatHit()
	{
		if (boyfriendCharacter.animation.name != boyfriendCharacter.default_Animation && !boyfriendCharacter.singing)
		{
			boyfriendCharacter.playAnim(boyfriendCharacter.default_Animation);
		}

		super.beatHit();
	}
	public function resyncSounds()
	{
		Instrumental.pause();
		OpponentVocals.pause();
		PlayerVocals.pause();

		Instrumental.time = Conductor.songPosition;
		OpponentVocals.time = Conductor.songPosition;
		PlayerVocals.time = Conductor.songPosition;

		Instrumental.play();
		OpponentVocals.play();
		PlayerVocals.play();
	}
}
