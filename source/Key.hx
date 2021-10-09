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
}
