package;

import PlayerState.PlayerStates;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Timer;

class PlayState extends FlxTransitionableState
{
	var player:Player;
	var exit:Exit;
	var key:Key;
	var bear:Bear;
	var levels:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var foregrounds:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var unstables:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var eventUnstables:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var stables:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var invisibles:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
	var showBear:FlxSprite;
	var levelNames:Array<String>;
	var playerPos:Array<FlxPoint>;
	var exitPos:Array<FlxPoint>;
	var keyPos:Array<FlxPoint>;
	var bearPos:Array<FlxPoint>;
	var showBearPos:Array<FlxPoint>;

	var message:ScreenMessage;

	var gameOver:Bool = false;

	public var crumbleTimer:FlxTween;

	var rumbleSound:FlxSound;

	var currentLevel:Int = 0;

	public var crumbleEvent:Bool = false;

	override public function create()
	{
		Registry.currentPlayState = this;
		levelNames = new Array<String>();
		playerPos = new Array<FlxPoint>();
		exitPos = new Array<FlxPoint>();
		keyPos = new Array<FlxPoint>();
		bearPos = new Array<FlxPoint>();
		showBearPos = new Array<FlxPoint>();
		rumbleSound = FlxG.sound.load(AssetPaths.ld49_rumble__wav);
		player = new Player();
		exit = new Exit();
		key = new Key();

		message = new ScreenMessage();

		var project = new LdtkProject();

		// Iterate all world levels
		for (i in 0...project.levels.length)
		{
			if (i > 8)
				continue;
			var level = project.levels[i];
			levelNames.push(level.identifier);
			trace('Analyzing level ${i}, name ${level.identifier}');
			var container = new flixel.group.FlxSpriteGroup();
			level.l_Background.render(container);
			level.l_Frame.render(container);
			levels.push(container);
			var forcontainer = new flixel.group.FlxSpriteGroup();
			level.l_Foreground.render(forcontainer);
			foregrounds.push(forcontainer);

			var container1 = new flixel.group.FlxSpriteGroup();
			for (u in level.l_Unstables.all_Platform)
			{
				var unstable = new Unstable();
				unstable.setPosition(u.pixelX, u.pixelY);

				container1.add(unstable);
			}
			unstables.push(container1);

			var container2 = new flixel.group.FlxSpriteGroup();
			for (u in level.l_Stables.all_Platform)
			{
				var stable = new Stable();
				stable.setPosition(u.pixelX, u.pixelY);

				container2.add(stable);
			}
			stables.push(container2);

			var container3 = new flixel.group.FlxSpriteGroup();
			for (u in level.l_Stables.all_Invisible)
			{
				var stable = new Stable();
				stable.setPosition(u.pixelX, u.pixelY);
				stable.visible = false;
				stable.discovered = false;
				container3.add(stable);
			}
			invisibles.push(container3);

			var container3 = new flixel.group.FlxSpriteGroup();
			for (u in level.l_EventUnstables.all_Platform)
			{
				var evunstable = new Unstable();
				evunstable.setPosition(u.pixelX, u.pixelY);

				container3.add(evunstable);
			}
			eventUnstables.push(container3);

			playerPos.push(FlxPoint.get(level.l_Entities.all_Player[0].pixelX, level.l_Entities.all_Player[0].pixelY));
			exitPos.push(FlxPoint.get(level.l_Entities.all_Exit[0].pixelX, level.l_Entities.all_Exit[0].pixelY));
			if (level.l_Entities.all_Key[0] != null)
				keyPos.push(FlxPoint.get(level.l_Entities.all_Key[0].pixelX, level.l_Entities.all_Key[0].pixelY));
			else
				keyPos.push(FlxPoint.get(-1, -1));

			if (level.l_Entities.all_Bear[0] != null)
				bearPos.push(FlxPoint.get(level.l_Entities.all_Bear[0].pixelX, level.l_Entities.all_Bear[0].pixelY));
			else
				bearPos.push(FlxPoint.get(-1, -1));

			if (level.l_Entities.all_ShowBear[0] != null)
				showBearPos.push(FlxPoint.get(level.l_Entities.all_ShowBear[0].pixelX, level.l_Entities.all_ShowBear[0].pixelY));
			else
				showBearPos.push(FlxPoint.get(-1, -1));
		}
		var l = Registry.currentLevel;
		player.setPosition(playerPos[l].x, playerPos[l].y);
		exit.setPosition(exitPos[l].x, exitPos[l].y);
		key.setPosition(keyPos[l].x, keyPos[l].y);

		if (key.x < 0)
			player.keyAcquired = true;
		else
			player.keyAcquired = false;

		if (bearPos[l].x != -1)
		{
			bear = new Bear();
			bear.setPosition(bearPos[l].x - 16, bearPos[l].y - 32);
			bear.visible = false;
		}

		if (showBearPos[l].x != -1)
		{
			showBear = new FlxSprite();
			showBear.makeGraphic(32, 32, FlxColor.WHITE);
			showBear.visible = false;
			showBear.setPosition(showBearPos[l].x - 16, showBearPos[l].y - 32);
		}

		this.add(levels[l]);
		this.add(stables[l]);
		this.add(unstables[l]);
		this.add(invisibles[l]);
		this.add(eventUnstables[l]);
		this.add(exit);
		this.add(key);
		if (bear != null)
			this.add(bear);
		if (showBear != null)
			this.add(showBear);
		this.add(player);
		this.add(foregrounds[l]);
		this.add(message);

		player.color = FlxColor.CYAN;
		this.crumbleEvent = false;
		if (levelNames[Registry.currentLevel] != "Twist" && levelNames[Registry.currentLevel] != "Ending")
		{
			crumbleTimer = FlxTween.num(0, 1, 6, {
				onComplete: function(_)
				{
					rumbleSound.play();
					Registry.showBrackets = true;
					FlxG.camera.shake(0.005, 2, function()
					{
						Registry.showBrackets = false;
						this.crumbleEvent = true;
					});
				}
			});
		}

		if (levelNames[Registry.currentLevel] == "Ending")
		{
			exit.visible = false;
		}

		currentLevel = Registry.currentLevel;
		super.create();
		Registry.showBrackets = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		Input.update(elapsed);
		if (Registry.gameStarted == false)
		{
			crumbleTimer.active = false;
			this.openSubState(new MenuSubState());
		}
		else
		{
			if (crumbleTimer != null)
				crumbleTimer.active = true;
		}
		if (gameOver == true)
		{
			if (Input.isJustRestart)
				FlxG.switchState(new PlayState());
		}
		#if debug
		if (FlxG.keys.justPressed.L)
			nextLevel();
		if (FlxG.keys.justPressed.K)
			FlxG.switchState(new EndCinematicState());
		#end
		if (!player.alive && levelNames[currentLevel] != "Twist")
		{
			message.showMessage("Press X to restart level.");
			gameOver = true;
		}
		if (player.keyAcquired && !exit.isOpen)
		{
			exit.isOpen = true;
		}
		if (player.alive && player.y > 260)
		{
			player.fallingSound.play();

			if (levelNames[currentLevel] == "Twist" && Registry.playerFall == false)
			{
				Registry.playerFall = true;
				Timer.delay(function()
				{
					message.showMessage("Uh-Oh!");
				}, 2000);
				Timer.delay(function()
				{
					nextLevel();
				}, 2000);
			}
			else
				player.kill();
		}
		unstables[Registry.currentLevel].alpha = Registry.showBrackets ? 0.7 : 1.0;
		if (FlxG.keys.justPressed.Q)
		{
			Registry.showBrackets = !Registry.showBrackets;
		}

		invisibles[Registry.currentLevel].forEachAlive((s:FlxSprite) ->
		{
			var st = cast(s, Stable);
			s.visible = Registry.showBrackets || st.discovered;
			s.alpha = Registry.showBrackets ? (st.discovered ? 1.0 : 0.3) : 1.0;
		});

		FlxG.collide(stables[Registry.currentLevel], player, function(a, b)
		{
			// var player = cast(b, Player);
			cast(a, Stable).visible = true;
			cast(a, Stable).discovered = true;
		});
		FlxG.collide(invisibles[Registry.currentLevel], player, function(a, b)
		{
			// var player = cast(b, Player);
			cast(a, Stable).visible = true;
			cast(a, Stable).discovered = true;
		});
		FlxG.overlap(unstables[Registry.currentLevel], player, function(a, b)
		{
			var player = cast(b, Player);
			var oldVelocity = player.velocity;
			var oldAcceleration = player.acceleration;
			if (FlxObject.separateY(a, b))
			{
				trace("crumbling!");
				cast(a, Unstable).crumble();
				player.velocity.copyFrom(oldVelocity);
				player.acceleration.copyFrom(oldAcceleration);
				player.crumbling = true;
				player.touching ^= FlxObject.DOWN;
				player.switchState(PlayerStates.ON_AIR);
			}
			// player.state.onCollidePlatform(player, a);
		});

		FlxG.overlap(eventUnstables[Registry.currentLevel], player, function(a, b)
		{
			var player = cast(b, Player);
			var oldVelocity = player.velocity;
			var oldAcceleration = player.acceleration;
			if (FlxObject.separateY(a, b) && this.crumbleEvent)
			{
				trace("crumbling!");
				cast(a, Unstable).crumble();
				player.velocity.copyFrom(oldVelocity);
				player.acceleration.copyFrom(oldAcceleration);
				player.crumbling = true;
				player.touching ^= FlxObject.DOWN;
				player.switchState(PlayerStates.ON_AIR);
			}
			// player.state.onCollidePlatform(player, a);
		});

		if (FlxG.pixelPerfectOverlap(player, key))
		{
			player.keyAcquired = true;
			key.kill();
		}

		if (bear != null && FlxG.pixelPerfectOverlap(player, bear))
		{
			Registry.gotBear = true;
			bear.kill();
		}

		if (showBear != null && FlxG.pixelPerfectOverlap(player, showBear))
		{
			if (bear != null)
				bear.visible = true;
			showBear.kill();
		}

		if (FlxG.pixelPerfectOverlap(player, exit))
		{
			trace("Overlapping with exit!");
			if (exit.isOpen && !exit.isExited)
			{
				exit.isExited = true;
				player.switchState(PlayerStates.EXITED);
				nextLevel();
			}
		}
	}

	public function nextLevel()
	{
		trace("Going to next level");
		exit.isExited = true;
		player.switchState(PlayerStates.EXITED);
		if (levelNames[Registry.currentLevel] == "Ending")
		{
			Registry.currentLevel = 0;
			FlxG.camera.fade(FlxColor.BLACK, () ->
			{
				FlxG.switchState(new EndCinematicState());
			});
		}
		else
		{
			Registry.currentLevel++;
			resetState();
		}
	}

	public function resetState()
	{
		this.crumbleEvent = false;
		if (crumbleTimer != null)
		{
			crumbleTimer.cancel();
		}

		FlxG.camera.fade(FlxColor.BLACK, () ->
		{
			FlxG.switchState(new PlayState());
		});
	}
}
