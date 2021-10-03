package;

import PlayerState.PlayerStates;
import flixel.FlxG;

class PlayerStateJump implements PlayerState
{
	public function new() {}

	public function update(elapsed:Float, player:Player)
	{
		player.acceleration.y = player.gravity;

		player.switchState(PlayerStates.ON_AIR);
	}

	public function onEnter(player:Player)
	{
		player.velocity.y = -player.jumpSpeed;
	}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic) {}
}
