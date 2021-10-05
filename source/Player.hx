package;

import PlayerState.PlayerStates;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxSound;

class Player extends FlxSprite
{
	public var state(default, null):PlayerState;

	private var nextState:PlayerState;

	public var keyAcquired:Bool = false;
	public var crumbling:Bool = false;

	public var gravity(default, null):Float = 600;
	public var jumpSpeed(default, null):Float = 200;
	public var moveSpeed(default, null):Float = 3180;

	public var fallingSound:FlxSound;
	public var whirringSound:FlxSound;

	public function new()
	{
		super();
		allowCollisions = FlxObject.DOWN;
		this.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		this.offset.set(7, 10);
		this.width = 18;
		this.height = 22;

		this.animation.add("idle", [0]);
		this.animation.add("idleright", [0]);
		this.animation.add("idleleft", [3]);
		this.animation.add("right", [0, 1, 2]);
		this.animation.add("left", [3, 4, 5]);
		state = PlayerStates.IDLE;

		fallingSound = FlxG.sound.load(AssetPaths.ld49_yau__wav);
		whirringSound = FlxG.sound.load(AssetPaths.ld49_vrr__wav, true);
	}

	override public function update(elapsed:Float):Void
	{
		doDebugInputMovement();

		if (nextState != null)
		{
			_switchState(nextState);
			nextState = null;
		}
		state.update(elapsed, this);
		super.update(elapsed);
		if (x < 0 || x + width > 480)
		{
			this.x = this.last.x;
		}
	}

	override public function setPosition(x:Float = 0, y:Float = 0)
	{
		x -= this.width / 2;
		y -= this.height;
		super.setPosition(x, y);
	}

	public function doDebugInputMovement()
	{
		#if debug
		var changed = false;
		if (FlxG.keys.pressed.W)
		{
			this.moveSpeed -= 10;
			changed = true;
		}

		if (FlxG.keys.pressed.E)
		{
			this.moveSpeed += 10;
			changed = true;
		}

		if (FlxG.keys.pressed.R)
		{
			this.jumpSpeed -= 10;
			changed = true;
		}

		if (FlxG.keys.pressed.T)
		{
			this.jumpSpeed += 10;
			changed = true;
		}

		if (FlxG.keys.pressed.Y)
		{
			this.gravity -= 10;
			changed = true;
		}

		if (FlxG.keys.pressed.U)
		{
			this.gravity += 10;
			changed = true;
		}

		if (changed)
		{
			trace('moveSpeed: ${moveSpeed}');
			trace('jumpSpeed: ${jumpSpeed}');
			trace('gravity: ${gravity}');
		}
		#end
	}

	public function doInputMovement(elapsed:Float)
	{
		var player = this;
		var oldX = player.x;
		if (Input.isRight)
		{
			player.velocity.x = player.moveSpeed * elapsed;
		}
		else if (Input.isLeft)
		{
			player.velocity.x = -player.moveSpeed * elapsed;
		}
		else
		{
			player.velocity.x = 0;
		}

		if (player.velocity.x > 0)
		{
			player.animation.play("right");
		}
		else if (player.velocity.x < 0)
		{
			player.animation.play("left");
		}
		else
		{
			if (player.animation.name == "right")
				player.animation.play("idleright");
			if (player.animation.name == "left")
				player.animation.play("idleleft");
		}
		if (player.velocity.x != 0)
			whirringSound.play();
		else
			whirringSound.stop();
	}

	public function canJump():Bool
	{
		return this.isTouching(FlxObject.DOWN) && !crumbling;
	}

	public function switchState(newState:PlayerState):Void
	{
		trace("Switching Player State");
		if (newState == null)
		{
			trace("New state is null, doing nothing");
			return;
		}
		if (newState == state)
		{
			trace('New state is the same: ${Utils.getClassName(state)}');
			return;
		}

		nextState = newState;
	}

	private function _switchState(newState:PlayerState):Void
	{
		trace("Actually switching Player State");

		if (state != null)
		{
			trace('Calling onExit() of ${Utils.getClassName(state)}');
			state.onExit(this);
		}
		state = newState;

		trace('Calling onEnter() of ${Utils.getClassName(state)}');
		newState.onEnter(this);
	}
}
