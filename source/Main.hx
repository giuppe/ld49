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
		js.Syntax.code("document.body.addEventListener(\"touchstart\", {0} );", js.Syntax.field(Input, "handleTouchStart"));
		js.Syntax.code("document.body.addEventListener(\"touchmove\", {0} );", js.Syntax.field(Input, "handleTouchMove"));
		js.Syntax.code("document.body.addEventListener(\"touchend\", {0} );", js.Syntax.field(Input, "handleTouchEnd"));
		js.Syntax.code("document.body.addEventListener(\"touchcancel\", {0} );", js.Syntax.field(Input, "handleTouchCancel"));
		#end
	}
}
