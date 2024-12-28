package data.character;

typedef CharacterMeta =
{
	var name:String;
	var imagePath:String;
	var flipX:Bool;
	var singTime:Float;
	var animations:Array<CharacterAnimationData>;
}

typedef CharacterAnimationData =
{
	var ?animationName:String;
	var symbolName:String;
	var ?animationOffsets:Array<Float>;
	var ?loopingAnimation:Bool;
}