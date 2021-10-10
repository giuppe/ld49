package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.addons.transition.TransitionTiles;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.system.scaleModes.RelativeScaleMode;
import flixel.util.FlxColor;
import kmbr.gfx.EvenRatioScaleMode;

class InitState extends FlxState
{
	override public function create()
	{
		var tileData:TransitionTileData = {asset: AssetPaths.diamond__png, width: 32, height: 32,};
		FlxTransitionableState.defaultTransIn = new TransitionData(TransitionType.TILES, FlxColor.BLACK, 0.5, FlxPoint.get(-1, 0), tileData);
		FlxTransitionableState.defaultTransOut = new TransitionData(TransitionType.TILES, FlxColor.BLACK, 0.5, FlxPoint.get(-1, 0), tileData);
		FlxG.camera.pixelPerfectRender = true;
		FlxG.scaleMode = new EvenRatioScaleMode();
		FlxG.switchState(new PlayState());
	}
}
