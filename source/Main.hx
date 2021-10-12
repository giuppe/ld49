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
		Input.initTouch();
		#if debug
		Input.initTouchButtons();
		#end
		#end
	}
}
