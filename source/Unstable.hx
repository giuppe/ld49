package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.system.FlxSoundGroup;

class Unstable extends FlxSprite
{
	public var crumbleSound:FlxSound;

	public function new()
	{
		super();
		loadGraphic("assets/images/Sprite-0002-Sheet.png", true, 32, 32);
		this.animation.add("idle", [0]);
		this.animation.add("crumble", [1, 1, 1], false);
		this.animation.finishCallback = function(name:String)
		{
			if (name == "crumble")
				this.kill();
		}
		this.animation.play("idle");
		this.immovable = true;
		crumbleSound = FlxG.sound.load(AssetPaths.ld49_crumble__wav);
	}

	public function crumble()
	{
		this.animation.play("crumble");
		crumbleSound.play();
		this.allowCollisions = FlxObject.NONE;
	}
}
