package play.objects;

import data.character.SongCharacterData.CharacterMeta;

class Character extends FlxSprite
{
	public var jsonData:CharacterMeta;

	public var animOffsets:Map<String, Array<Dynamic>>;

	public var isPlayer:Bool = false;

	override public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		animOffsets = new Map<String, Array<Dynamic>>();
		super(x, y);

		jsonData = Json.parse(BackendAssets.readFile(BackendAssets.json('characters/$character')));

		this.isPlayer = isPlayer;

		if (jsonData != null)
		{
			frames = BackendAssets.sparrowImage(jsonData.imagePath);

			if (this.isPlayer)
				flipX = !flipX;
			if (jsonData.flipX)
				flipX = !flipX;

			var index:Int = 0;
			for (animation in jsonData.animations)
			{
				animation.animationName ??= 'anim-$index';
				animation.loopingAnimation ??= false;
				// animation.animationOffsets[0] ??= 0;
				// animation.animationOffsets[1] ??= 0;

				this.animation.addByPrefix(animation.animationName, animation.symbolName, 24, animation.loopingAnimation);
				try
				{
					addOffset(animation.animationName, animation.animationOffsets[0], animation.animationOffsets[1]);
				}
				catch (e)
				{
					addOffset(animation.animationName);
				}
				index++;
			}

			if (this.animOffsets.exists('idle'))
				playAnim('idle');
			else
				// play the first animation it can find if no idle
				playAnim(this.animation.getAnimationList()[0].name);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(animation.curAnim.name);
		if (animOffsets.exists(animation.curAnim.name))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}
}