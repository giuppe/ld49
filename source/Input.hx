package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

class Input
{
	public static var isJustLeft:Bool = false;
	public static var isJustRight:Bool = false;
	public static var isJustJump:Bool = false;
	public static var isJustRestart:Bool = false;
	public static var isJustStart:Bool = false;

	public static var isLeft:Bool = false;
	public static var isRight:Bool = false;
	public static var isJump:Bool = false;

	public static function update(elapsed:Float)
	{
		isJustLeft = false;
		isJustRight = false;
		isJustJump = false;
		isJustRestart = false;
		isJustStart = false;

		isLeft = false;
		isRight = false;
		isJump = false;

		if (FlxG.keys.justPressed.LEFT)
		{
			isJustLeft = true;
		}
		if (FlxG.keys.justPressed.RIGHT)
		{
			isJustRight = true;
		}
		if (FlxG.keys.anyJustPressed([FlxKey.Z, FlxKey.SPACE]))
		{
			isJustJump = true;
		}

		if (FlxG.keys.anyJustPressed([FlxKey.X, FlxKey.Z, FlxKey.SPACE]))
		{
			isJustRestart = true;
		}

		if (FlxG.keys.pressed.LEFT)
		{
			isLeft = true;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			isRight = true;
		}
		if (FlxG.keys.anyJustPressed([FlxKey.Z, FlxKey.SPACE]))
		{
			isJump = true;
		}
		if (FlxG.keys.justPressed.ANY)
		{
			isJustStart = true;
		}
		#if (!desktop || html5)
		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
				isJustStart = true;
			}
		}
		#end
	}
}
