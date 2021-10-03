package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;

class InitState extends FlxState
{
	override public function create()
	{
		FlxG.scaleMode = new FillScaleMode();
		FlxG.switchState(new PlayState());
	}
}
