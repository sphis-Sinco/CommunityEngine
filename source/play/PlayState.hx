package play;


class PlayState extends MusicBeatState
{
	var debugField:FlxText = new FlxText(3, 6, 0, "", 16);

	public var boyfriendCharacter:Character;

	override public function create()
	{
		FlxG.sound.play(BackendAssets.track('songs/tutorial/Inst'));
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
				boyfriendCharacter.playAnim('singLEFT');
			if (thekey.DOWN)
				boyfriendCharacter.playAnim('singDOWN');
			if (thekey.UP)
				boyfriendCharacter.playAnim('singUP');
			if (thekey.RIGHT)
				boyfriendCharacter.playAnim('singRIGHT');
		}

		super.update(elapsed);
	}

	override function beatHit()
	{
		super.beatHit();
	}
}
