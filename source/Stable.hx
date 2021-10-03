package;

import flixel.FlxSprite;

class Stable extends FlxSprite
{
	public function new()
	{
		super();
		loadGraphic("assets/images/Sprite-0002-Sheet.png", true, 32, 32);
		this.animation.add("idle", [0]);
		this.animation.add("crumble", [1, 1, 1], false);
		this.animation.play("idle");
		this.immovable = true;
	}
}
