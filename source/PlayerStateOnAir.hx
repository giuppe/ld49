package;

import PlayerState.PlayerStates;
import flixel.FlxG;

class PlayerStateOnAir implements PlayerState
{
	public function new() {}

	public function update(elapsed:Float, player:Player)
	{
		player.acceleration.y = player.gravity;
		if (player.velocity.y == 0)
			player.switchState(PlayerStates.IDLE);
		player.doInputMovement(elapsed);
	}

	public function onEnter(player:Player)
	{
		player.crumbling = false;
		player.whirringSound.stop();
	}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic) {}
}
