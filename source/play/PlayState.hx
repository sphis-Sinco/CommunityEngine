package play;


class PlayState extends MusicBeatState
{
	var beat:FlxText = new FlxText(0, 10, 0);
	var step:FlxText = new FlxText(0, 20, 0);

	override public function create()
	{
		FlxG.sound.play(BackendAssets.track('songs/tutorial/Inst'));
		Conductor.changeBPM(100);

		add(beat);
		add(step);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		beat.text = "Beat: " + curBeat;
		step.text = "Step: " + curStep;

		Conductor.songPosition += FlxG.elapsed * 1000;

		super.update(elapsed);
	}
}
