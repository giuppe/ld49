package modifications;

import flixel.FlxSprite;

class FlxSpriteMod
{
	public static function right(s:FlxSprite):Float
	{
		return s.x + s.width;
	}

	public static function left(s:FlxSprite):Float
	{
		return s.x;
	}

	public static function top(s:FlxSprite):Float
	{
		return s.y;
	}

	public static function bottom(s:FlxSprite):Float
	{
		return s.y + s.height;
	}

	public static function xCenter(s:FlxSprite):Float
	{
		return s.x + s.width / 2;
	}

	public static function yCenter(s:FlxSprite):Float
	{
		return s.y + s.height / 2;
	}

	public static function setRight(s:FlxSprite, right:Float):Float
	{
		return s.x = right - s.width;
	}

	public static function setBottom(s:FlxSprite, bottom:Float):Float
	{
		return s.y = bottom - s.height;
	}

	public static function setXCenter(s:FlxSprite, xCenter:Float):Float
	{
		return s.x = xCenter - s.width / 2;
	}

	public static function setYCenter(s:FlxSprite, yCenter:Float):Float
	{
		return s.y = yCenter - s.height / 2;
	}

	public static function setXCenterBottom(s:FlxSprite, xCenter:Float, bottom:Float):Void
	{
		setXCenter(s, xCenter);
		setBottom(s, bottom);
	}

    public static function setPositionAnchor(s:FlxSprite, x:Float, y:Float, anchor:Anchor)
    {
        switch(anchor.x)
        {
            case LEFT:
                s.x = x;
            case RIGHT:
                setRight(s, x);
            case CENTER:
                setXCenter(s, x);
        }
        switch(anchor.y)
        {
            case TOP:
                s.y = y;
            case BOTTOM:
                setBottom(s, y);
            case CENTER:
                setYCenter(s, y);
        }
    }
}

@:structInit
class Anchor
{
	public var x:AnchorX;
	public var y:AnchorY;

	public function new(x:AnchorX, y:AnchorY)
	{
		this.x = x;
		this.y = y;
	}
}

@:enum
abstract AnchorY(Int) to(Int)
{
	var TOP = 0;
	var BOTTOM = 1;
	var CENTER = 2;
}

@:enum
abstract AnchorX(Int) to(Int)
{
	var LEFT = 0;
	var RIGHT = 1;
	var CENTER = 2;
}
