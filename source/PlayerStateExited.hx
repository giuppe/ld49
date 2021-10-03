package;

class PlayerStateExited implements PlayerState
{
	public function new() {}

	public function update(elapsed:Float, player:Player)
	{
		player.x = player.last.x;
		player.y = player.last.y;
		player.velocity.y = 0;
		player.velocity.x = 0;
		player.acceleration.x = 0;
		player.acceleration.y = 0;
	}

	public function onEnter(player:Player) {}

	public function onExit(player:Player) {}

	public function onCollidePlatform(player:Player, object:Dynamic) {}
}
