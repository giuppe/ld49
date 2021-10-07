package;

import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;

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
		var point1 = FlxPoint.get(exit.x + exit.width - player.width, exit.y + exit.height - player.height);
		FlxTween.linearPath(player, [point1, FlxPoint.get(exit.x + 32, exit.y + 32)]);
	}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic) {}
}
