package;

import flixel.FlxSprite;

class Key extends FlxSprite
{
	public function new()
	{
		super();
		this.loadGraphic("assets/images/Sprite-0005.png");
		this.offset.set(6, 19);
		this.width = 32 - 6 - 6;
		this.height = 32 - 19;
	}

	override public function setPosition(x:Float = 0, y:Float = 0)
	{
		x -= this.width / 2;
		y -= this.height;
		super.setPosition(x, y);
	}
}
