package;

import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

using modifications.FlxSpriteMod;

class PlayerStateExited implements PlayerState
{
	public function new() {}

	public function update(elapsed:Float, player:Player)
	{
		// player.x = player.last.x;
		// player.y = player.last.y;
		// player.velocity.y = 0;
		// player.velocity.x = 0;
		// player.acceleration.x = 0;
		player.acceleration.y = 0;
	}

	public function onEnter(player:Player)
	{
		var exit = Registry.currentPlayState.exit;
		var point1 = FlxPoint.get(exit.right() - player.width * 2, exit.bottom() - player.height);
		if (exit.xCenter() < player.xCenter())
		{
			point1.x = exit.right();
			player.animation.play("left");
			FlxTween.linearMotion(player, player.x, player.y, point1.x, point1.y, 0.1)
				.then(FlxTween.linearPath(player, [point1, FlxPoint.get(point1.x - 16, point1.y)]));
		}
		else
		{
			player.animation.play("right");
			FlxTween.linearMotion(player, player.x, player.y, point1.x, point1.y, 0.1)
				.then(FlxTween.linearPath(player, [point1, FlxPoint.get(point1.x + 16, point1.y)]));
		}
		FlxTween.num(0, 1, 0.1).then(FlxTween.tween(player, {alpha: 0}, 1.0));
	}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic) {}
}
