package;

interface PlayerState
{
	public function update(elapsed:Float, player:Player):Void;
	public function onEnter(player:Player):Void;
	public function onExit(player:Player):Void;
	public function onCollidePlatform(player:Player, object:Dynamic):Void;
}

class PlayerStates
{
	public static var IDLE = new PlayerStateIdle();
	public static var JUMP = new PlayerStateJump();
	public static var ON_AIR = new PlayerStateOnAir();
	public static var EXITED = new PlayerStateExited();
}
