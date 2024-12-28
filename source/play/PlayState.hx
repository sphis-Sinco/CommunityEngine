package play;

import data.song.SongChartData.SongMetaData;
import data.stage.StageData;
import flixel.sound.FlxSound;

class PlayState extends MusicBeatState
{
	var debugField:FlxText = new FlxText(3, 6, 0, "", 16);

	public var boyfriendCharacter:Character;
	public var daddyCharacter:Character;
	public var girlFriendCharacter:Character;

	public var Instrumental:FlxSound;
	public var OpponentVocals:FlxSound;
	public var PlayerVocals:FlxSound;

	public var songName:String = 'Tutorial';
	public var songJson:SongMetaData;
	public var songStageJson:StageData;

	public var stageJsonGameplayField:StageGameplayData;

	override public function create()
	{
		songJson = Json.parse(BackendAssets.readFile(BackendAssets.songJson(songName.toLowerCase())));
		songStageJson = Json.parse(BackendAssets.readFile(BackendAssets.json('stages/${songJson.stage}')));

		stageJsonGameplayField = songStageJson.gameplay;

		var positions = stageJsonGameplayField.positions;

		daddyCharacter = new Character(positions.opponent[0], positions.opponent[1], songJson.player2, true);
		add(daddyCharacter);

		girlFriendCharacter = new Character(positions.emotional_support[0], positions.emotional_support[1], songJson.gf, true);
		if (daddyCharacter.character != girlFriendCharacter.character || stageJsonGameplayField.hideGF)
			add(girlFriendCharacter);
		else if (daddyCharacter.character == girlFriendCharacter.character)
		{
			daddyCharacter.setPosition(positions.emotional_support[0], positions.emotional_support[1]);
		}

		boyfriendCharacter = new Character(positions.player[0], positions.player[1], songJson.player1, true);
		add(boyfriendCharacter);

		Instrumental = FlxG.sound.load(BackendAssets.track('songs/${songName.toLowerCase()}/Inst'));
		OpponentVocals = FlxG.sound.load(BackendAssets.track('songs/${songName.toLowerCase()}/Voices-${daddyCharacter.character}'));
		PlayerVocals = FlxG.sound.load(BackendAssets.track('songs/${songName.toLowerCase()}/Voices-${boyfriendCharacter.character}'));

		Instrumental.play();
		OpponentVocals.play();
		PlayerVocals.play();

		Conductor.changeBPM(songJson.bpm);

		debugField.scrollFactor.set();
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

		if (daddyCharacter.animation.name != daddyCharacter.default_Animation && !daddyCharacter.singing)
		{
			daddyCharacter.playAnim(daddyCharacter.default_Animation);
		}

		if (girlFriendCharacter.animation.name != girlFriendCharacter.default_Animation && !girlFriendCharacter.singing)
		{
			girlFriendCharacter.playAnim(girlFriendCharacter.default_Animation);
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
