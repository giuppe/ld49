package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.util.FlxColor;

class InitState extends FlxState
{
	override public function create()
	{
		FlxTransitionableState.defaultTransIn = new TransitionData(TransitionType.TILES, FlxColor.BLACK, 0.5, FlxPoint.get(-1, 0));
		FlxTransitionableState.defaultTransOut = new TransitionData(TransitionType.TILES, FlxColor.BLACK, 0.5, FlxPoint.get(-1, 0));

		FlxG.scaleMode = new FillScaleMode();
		FlxG.switchState(new PlayState());
	}
}
