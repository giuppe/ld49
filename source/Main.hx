package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(480, 256, InitState, true));

		#if js
		var doc = js.Browser.window.document;
		doc.body.addEventListener("touchstart", Input.handleTouchStart, false);
		doc.body.addEventListener("touchmove", Input.handleTouchMove, false);
		doc.body.addEventListener("touchend", Input.handleTouchEnd, false);
		doc.body.addEventListener("touchcancel", Input.handleTouchCancel, false);
		#end
	}
}
