package;

import flixel.FlxSprite;

class Exit extends FlxSprite
{
	public var isOpen(default, set):Bool = false;

	public var isExited = false;

	public function new()
	{
		super();
		this.loadGraphic("assets/images/Sprite-0004-Sheet.png", true, 32, 32);
		this.animation.add("closed", [0]);
		this.animation.add("opening", [1, 2, 3, 4], false);
		this.animation.add("open", [5]);
		this.offset.set(6, 12);
		this.width = 32 - 6 - 7;
		this.height = 32 - 12;
		this.animation.play("closed");
	}


	public function set_isOpen(o:Bool):Bool
	{
		this.isOpen = o;

		trace('Starting animation exit opening');
		this.animation.finishCallback = function(name:String)
		{
			trace('finishing animation ${name}');
			if (name == "opening")
				this.animation.play("open");
		};
		this.animation.play("opening");
		return o;
	}
}
