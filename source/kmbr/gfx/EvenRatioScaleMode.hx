package kmbr.gfx;

import flixel.system.scaleModes.RatioScaleMode;

class EvenRatioScaleMode extends RatioScaleMode
{
	/**
	 * @param fillScreen Whether to cut the excess side to fill the
	 * screen or always display everything.
	 */
	public function new(fillScreen:Bool = false)
	{
		super(fillScreen);
	}

	override function updateGameSize(Width:Int, Height:Int):Void
	{
		if (Width % 4 != 0)
			Width -= Width % 4;
		if (Height % 4 != 0)
			Height -= Height % 4;
		super.updateGameSize(Width, Height);
	}
}
