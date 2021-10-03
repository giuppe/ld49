package;

import PlayerState.PlayerStates;
import flixel.FlxG;

class PlayerStateIdle implements PlayerState
{
	public function new() {}

	public function update(elapsed:Float, player:Player)
	{
		player.acceleration.y = player.gravity;
		player.doInputMovement(elapsed);

		if (FlxG.keys.pressed.Z && player.canJump())
		{
			player.switchState(PlayerStates.JUMP);
		}
	}

	public function onEnter(player:Player)
	{
		player.crumbling = false;
	}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic)
	{
		player.acceleration.set(0, 0);
	}
}
