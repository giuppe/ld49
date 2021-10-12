package kmbr.html;

import flixel.math.FlxPoint;
import js.html.svg.PolylineElement;

class SVGUtils
{
	public static function createArrow(width:Int, height:Int, direction:ArrowDirection, padding:Int = 10):js.html.Element
	{
		var path = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "polyline");
		var startPoint = FlxPoint.get();
		var middlePoint = FlxPoint.get();
		var endPoint = FlxPoint.get();
		switch (direction)
		{
			case LEFT:
				startPoint.set(width * 2 / 3, padding);
				endPoint.set(width * 2 / 3, height - padding);
				middlePoint.set(padding, height / 2);
			case RIGHT:
				startPoint.set(width / 3, padding);
				endPoint.set(width / 3, height - padding);
				middlePoint.set(width - padding, height / 2);
			case UP:
				middlePoint.set(width / 2, padding);
				endPoint.set(width - padding, height * 2 / 3);
				startPoint.set(padding, height * 2 / 3);
			case DOWN:
				middlePoint.set(width / 2, height - padding);
				endPoint.set(width - padding, height / 3);
				startPoint.set(padding, height / 3);
		}
		var pointsString = '${startPoint.x},${startPoint.y} ${middlePoint.x},${middlePoint.y} ${endPoint.x},${endPoint.y}';
		path.setAttribute("points", pointsString);
		path.setAttribute("style", "fill:none;stroke:black;stroke-width:3");
		return path;
	}

	public static function createIconFullscreen(width:Int, height:Int):Array<js.html.Element>
	{
		var padding = Math.floor(width / 5);
		var gt = new Array<js.html.Element>();
		var defs = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "defs");

		var g = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "g");
		g.id = "arrow";

		var poly = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "polyline");
		poly.setAttribute("points", '0,${height / 6} 0,0 ${width / 6},0');
		var line = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "line");
		line.setAttribute("x1", Std.string(0));
		line.setAttribute("y1", Std.string(0));
		line.setAttribute("x2", Std.string(width / 4));
		line.setAttribute("y2", Std.string(height / 4));
		line.setAttribute("style", "fill:none;stroke:black;stroke-width:3");
		poly.setAttribute("style", "fill:none;stroke:black;stroke-width:3");
		g.appendChild(line);
		g.appendChild(poly);
		defs.appendChild(g);
		gt.push(defs);

		var use1 = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "use");
		use1.setAttribute("href", "#arrow");
		use1.setAttribute("x", Std.string(padding));
		use1.setAttribute("y", Std.string(padding));
		use1.setAttribute("transform", 'rotate(0 ${(width / 4) / 2} ${(height / 4) / 2})');
		gt.push(use1);
		var use2 = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "use");
		use2.setAttribute("href", "#arrow");
		var x2 = width - (width / 4 + padding);
		use2.setAttribute("x", Std.string(x2));
		use2.setAttribute("y", Std.string(padding));
		use2.setAttribute("transform", 'rotate(90 ${x2 + (width / 4) / 2} ${padding + (height / 4) / 2})');
		gt.push(use2);
		var use3 = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "use");
		use3.setAttribute("href", "#arrow");
		var y2 = height - (height / 4 + padding);
		use3.setAttribute("x", Std.string(x2));
		use3.setAttribute("y", Std.string(y2));
		use3.setAttribute("transform", 'rotate(180 ${x2 + (width / 4) / 2} ${y2 + (height / 4) / 2})');
		gt.push(use3);
		var use4 = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "use");
		use4.setAttribute("href", "#arrow");

		use4.setAttribute("x", Std.string(padding));
		use4.setAttribute("y", Std.string(y2));
		use4.setAttribute("transform", 'rotate(270 ${padding + (width / 4) / 2} ${y2 + (height / 4) / 2})');
		gt.push(use4);
		return gt;
	}

	public static function createSVGButton(width:Int, height:Int):js.html.Element
	{
		var svg1 = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "svg");
		svg1.setAttribute("width", Std.string(width));
		svg1.setAttribute("height", Std.string(height));

		var rect = js.Browser.window.document.createElementNS("http://www.w3.org/2000/svg", "rect");
		rect.setAttribute("x", "0");
		rect.setAttribute("y", "0");
		rect.setAttribute("width", Std.string(width));
		rect.setAttribute("height", Std.string(height));
		rect.setAttribute("rx", "15");
		rect.setAttribute("stroke", "#aaaaaa");
		rect.setAttribute("stroke-width", "3");
		rect.setAttribute("fill", "#555555");
		svg1.appendChild(rect);
		return svg1;
	}
}

@:enum
abstract ArrowDirection(String) to String
{
	var LEFT = "left";
	var DOWN = "down";
	var UP = "up";
	var RIGHT = "right";
}
