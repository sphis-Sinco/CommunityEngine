package backend;

import data.song.SongChartData.SongChartData;
import data.song.SongChartData.SongSection;

class Song
{
	public var song:String;
	public var notes:Array<SongSection>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SongChartData
	{
		var rawJson = LimeAssets.getText(BackendAssets.json('songs/${folder.toLowerCase()}/${jsonInput.toLowerCase()}')).trim();

		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}

		return parseJSONshit(rawJson);
	}

	public static function parseJSONshit(rawJson:String):SongChartData
	{
		var swagShit:SongChartData = cast Json.parse(rawJson).song;
		return swagShit;
	}
}