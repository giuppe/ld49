package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuSubState extends FlxSubState
{
	override public function create()
	{
		var title = new FlxText(0, 0, 0, "A Crumbly Planet", 36);

		title.screenCenter();
		this.add(title);
		var explain = new FlxText(0, 0, 0, "Z to jump, Arrow keys to move");
		explain.addFormat(new FlxTextFormat(FlxColor.WHITE, false, false, FlxColor.BLACK));
		explain.borderColor = FlxColor.BLACK;
		explain.borderSize = 1;
		explain.screenCenter();
		explain.y += 100;
		this.add(explain);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.Z)
		{
			Registry.gameStarted = true;
			this.close();
		}
	}
}
