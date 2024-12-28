package data.stage;

typedef StageData =
{
	var meta:StageMetaData;
	var objects:StageObjectContainer;
	var gameplay:StageGameplayData;
}

typedef StageMetaData = {}
typedef StageObjectContainer = {}
typedef StageObjectData = {}

typedef StageGameplayData =
{
	var hideGF:Bool;
	var positions:
		{
			var player:Array<Float>;
			var emotional_support:Array<Float>;
			var opponent:Array<Float>;
		};
};