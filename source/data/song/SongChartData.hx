package data.song;

typedef SongMetaData =
{
	var song:String;
	var bpm:Int;
	var needsVoices:Bool;

	var player1:String;
	var player2:String;
	var gf:String;

	var stage:String;

	var speed:Int;
	var notes:Array<SongNote>;
	// var events:Array<SongEvent>;
}

typedef SongNote =
{
	var id:Int;
	var position:SNPosition;
}

typedef SongEvent =
{
	var id:String;
	var position:SNPosition;
}

typedef SNPosition =
{
	var beat:Float;
	var step:Float;
}