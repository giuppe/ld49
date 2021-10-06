package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.input.keyboard.FlxKey;
import flixel.input.keyboard.FlxKeyList;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MenuSubState extends FlxSubState
{
	override public function create()
	{
		var title = new FlxText(0, 0, 0, "A Crumbly Planet", 36);

		title.screenCenter();
		this.add(title);
		var explain = new FlxText(0, 0, 300, "Z to jump, Arrow keys to move\nPress Z to start");
		explain.addFormat(new FlxTextFormat(FlxColor.WHITE, false, false, FlxColor.BLACK));
		explain.borderColor = FlxColor.BLACK;
		explain.alignment = FlxTextAlign.CENTER;
		explain.borderSize = 1;
		explain.screenCenter();
		explain.y += 100;
		this.add(explain);
	}

	override public function update(elapsed:Float)
	{
		Input.update(elapsed);
		if (Input.isJustStart)
		{
			Registry.gameStarted = true;
			this.close();
		}
	}
}
