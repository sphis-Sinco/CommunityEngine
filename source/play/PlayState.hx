package play;


class PlayState extends MusicBeatState
{
	var debugField:FlxText = new FlxText(0, 10, 0);

	override public function create()
	{
		FlxG.sound.play(BackendAssets.track('songs/tutorial/Inst'));
		Conductor.changeBPM(100);

		#if debug add(debugField); #end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		Conductor.songPosition += FlxG.elapsed * 1000;
		debugField.text = "Beat: " + curBeat;
		debugField.text += "\nStep: " + curStep;

		super.update(elapsed);
	}
}
