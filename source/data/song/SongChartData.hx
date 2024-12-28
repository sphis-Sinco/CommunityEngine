package data.song;

typedef SongChartData =
{
	var song:String;
	var notes:Array<SongSection>;
	var bpm:Int;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
}

typedef SongSection =
{
	var sectionNotes:Array<Dynamic>;
	var lengthInSteps:Int;
	var typeOfSection:Int;

	var bpm:Float;
	var changeBPM:Bool;

	var altAnim:Bool;
}