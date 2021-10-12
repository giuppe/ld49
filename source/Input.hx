package;

import flixel.FlxG;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxPoint;
import haxe.Json;
import kmbr.html.SVGUtils;
#if js
import js.Syntax;
#end

@:structInit
class TouchInfo
{
	public var identifier:Dynamic;
	public var pageX:Float;
	public var pageY:Float;
}

class Input
{
	public static var touchButtonsInited:Bool = false;
	public static var isJustLeft:Bool = false;
	public static var isJustRight:Bool = false;
	public static var isJustJump:Bool = false;
	public static var isJustRestart:Bool = false;
	public static var isJustStart:Bool = false;

	public static var isLeft:Bool = false;
	public static var isRight:Bool = false;
	public static var isJump:Bool = false;

	public static var ongoingTouches:Array<TouchInfo> = new Array<TouchInfo>();

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

		#if js
		var touched = false;
		var leftTouched = false;
		var rightTouched = false;
		var jumpTouched = false;
		for (t in ongoingTouches)
		{
			touched = true;
			if (t.pageY > js.Browser.window.innerHeight / 2)
			{
				if (t.pageX < 130)
					leftTouched = true;
				else if (t.pageX < 260)
					rightTouched = true;
				else if (t.pageX > js.Browser.window.innerWidth - 130)
					jumpTouched = true;
			}
		}

		if (touched)
		{
			isJustStart = true;
			if (touchButtonsInited == false)
			{
				Input.initTouchButtons();
				touchButtonsInited = true;
			}
		}
		if (jumpTouched)
			isJump = isJustJump = true;
		if (leftTouched)
			isJustLeft = isLeft = true;
		if (rightTouched)
			isJustRight = isRight = true;
		#end

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

	#if js
	public static function handleTouchStart(evt:Dynamic)
	{
		evt.preventDefault();
		trace("touchstart.");
		var touches = evt.changedTouches;

		for (i in 0...touches.length)
		{
			trace("touchstart:" + i + "...");
			ongoingTouches.push(copyTouch(touches[i]));
		}
	}

	public static function handleTouchMove(evt:Dynamic)
	{
		evt.preventDefault();

		var touches = evt.changedTouches;

		for (i in 0...touches.length)
		{
			var idx = ongoingTouchIndexById(touches[i].identifier);

			if (idx >= 0)
			{
				trace("continuing touch " + idx);

				ongoingTouches.splice(idx, 1);
				ongoingTouches[idx] = copyTouch(touches[i]);
				trace(".");
			}
			else
			{
				trace("can't figure out which touch to continue");
			}
		}
	}

	public static function handleTouchEnd(evt:Dynamic)
	{
		evt.preventDefault();
		trace("touchend");

		var touches = evt.changedTouches;

		for (i in 0...touches.length)
		{
			var idx = ongoingTouchIndexById(touches[i].identifier);

			if (idx >= 0)
			{
				ongoingTouches.splice(idx, 1); // remove it; we're done
			}
			else
			{
				trace("can't figure out which touch to end");
			}
		}
	}

	public static function handleTouchCancel(evt)
	{
		evt.preventDefault();
		trace("touchcancel.");
		var touches = evt.changedTouches;

		for (i in 0...touches.length)
		{
			var idx = ongoingTouchIndexById(touches[i].identifier);
			ongoingTouches.splice(idx, 1); // remove it; we're done
		}
	}

	public static function copyTouch(touch:Dynamic):TouchInfo
	{
		return {
			identifier: touch.identifier,
			pageX: touch.pageX,
			pageY: touch.pageY
		};
	}

	public static function ongoingTouchIndexById(idToFind):Int
	{
		for (i in 0...ongoingTouches.length)
		{
			var id = ongoingTouches[i].identifier;

			if (id == idToFind)
			{
				return i;
			}
		}
		return -1; // not found
	}
	#end

	public static function initTouch()
	{
		#if js
		var doc = js.Browser.window.document;
		doc.body.addEventListener("touchstart", Input.handleTouchStart, false);
		doc.body.addEventListener("touchmove", Input.handleTouchMove, false);
		doc.body.addEventListener("touchend", Input.handleTouchEnd, false);
		doc.body.addEventListener("touchcancel", Input.handleTouchCancel, false);
		#end
	}

	public static function initTouchButtons()
	{
		#if js
		var doc = js.Browser.window.document;

		var svg1 = SVGUtils.createSVGButton(100, 100);
		svg1.setAttribute("style", "position: absolute;bottom: 20px;left: 20px;opacity:0.3;");

		svg1.appendChild(SVGUtils.createArrow(100, 100, LEFT));

		var svg2 = SVGUtils.createSVGButton(100, 100);
		svg2.setAttribute("style", "position: absolute;bottom: 20px;left: 140px;opacity:0.3;");

		svg2.appendChild(SVGUtils.createArrow(100, 100, RIGHT));

		var svg3 = SVGUtils.createSVGButton(100, 100);
		svg3.setAttribute("style", "position: absolute;bottom: 20px;right: 20px;opacity:0.3;");

		svg3.appendChild(SVGUtils.createArrow(100, 100, UP));

		var svg4 = SVGUtils.createSVGButton(100, 100);
		svg4.setAttribute("style", "position: absolute;top: 20px;right: 20px;opacity:0.3;");
		var fullscreenIcon = SVGUtils.createIconFullscreen(100, 100);
		for (f in fullscreenIcon)
			svg4.appendChild(f);

		doc.body.appendChild(svg1);
		doc.body.appendChild(svg2);
		doc.body.appendChild(svg3);
		doc.body.appendChild(svg4);
		#end
	}

	public static function isTouchDevice():Bool
	{
		#if js
		js.Syntax.code("return (('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0));");
		#end
		return false;
	}
}
