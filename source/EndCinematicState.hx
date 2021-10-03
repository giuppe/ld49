package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import haxe.Timer;

class EndCinematicState extends FlxState
{
	var pinkMessage:ScreenMessage = new ScreenMessage();
	var greenMessage:ScreenMessage = new ScreenMessage();
	var pinkPlayer:FlxSprite = new FlxSprite();
	var greenPlayer:FlxSprite = new FlxSprite();
	var bluePlayer:FlxSprite = new FlxSprite();
	var emitter1 = new FlxEmitter();
	var emitter2 = new FlxEmitter();
	var rocketSound:FlxSound;

	override public function create()
	{
		rocketSound = FlxG.sound.load(AssetPaths.ld49_rocket__wav, true);
		pinkMessage.color = FlxColor.MAGENTA;

		greenMessage.color = FlxColor.GREEN;

		pinkPlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		pinkPlayer.color = FlxColor.MAGENTA;

		greenPlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		greenPlayer.color = FlxColor.GREEN;

		bluePlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		bluePlayer.color = FlxColor.CYAN;

		emitter1.acceleration.start.min.y = 550;
		emitter1.acceleration.start.max.y = 600;
		emitter1.acceleration.end.min.y = 1100;
		emitter1.acceleration.end.max.y = 1200;

		emitter1.launchAngle.set(110, 70);
		emitter1.launchMode = CIRCLE;

		emitter2.acceleration.start.min.y = 550;
		emitter2.acceleration.start.max.y = 600;
		emitter2.acceleration.end.min.y = 1100;
		emitter2.acceleration.end.max.y = 1200;

		emitter2.launchAngle.set(110, 70);
		emitter2.launchMode = CIRCLE;

		var project = new LdtkProject();
		var levels:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
		var foregrounds:Array<FlxSpriteGroup> = new Array<FlxSpriteGroup>();
		for (i in 0...project.levels.length)
		{
			var level = project.levels[i];
			if (level.identifier != "Ending")
			{
				continue;
			}
			trace('Analyzing level ${i}, name ${level.identifier}');
			var container = new flixel.group.FlxSpriteGroup();
			level.l_Background.render(container);
			level.l_Frame.render(container);
			levels.push(container);
			var forcontainer = new flixel.group.FlxSpriteGroup();
			level.l_Foreground.render(forcontainer);
			foregrounds.push(forcontainer);
			pinkPlayer.setPosition(level.l_Entities.all_ShowBear[0].pixelX - 16, level.l_Entities.all_ShowBear[0].pixelY - 32);
			greenPlayer.setPosition(level.l_Entities.all_ShowBear[1].pixelX - 16, level.l_Entities.all_ShowBear[1].pixelY - 32);
			bluePlayer.setPosition(level.l_Entities.all_ShowBear[2].pixelX - 16, level.l_Entities.all_ShowBear[2].pixelY - 32);

			emitter1.setPosition(level.l_Entities.all_ShowBear[3].pixelX, level.l_Entities.all_ShowBear[3].pixelY - 32);
			emitter2.setPosition(level.l_Entities.all_ShowBear[4].pixelX, level.l_Entities.all_ShowBear[4].pixelY - 32);

			for (i in 0...300)
			{
				var p = new FlxParticle();
				p.loadGraphic(AssetPaths.particles__png);
				// p.exists = false;
				emitter1.add(p);
			}
			for (i in 0...300)
			{
				var p = new FlxParticle();
				p.loadGraphic(AssetPaths.particles__png);
				// p.exists = false;
				emitter2.add(p);
			}
		}

		this.add(levels[0]);
		this.add(pinkPlayer);
		this.add(greenPlayer);
		this.add(bluePlayer);
		this.add(emitter1);
		this.add(emitter2);
		this.add(foregrounds[0]);
		this.add(pinkMessage);
		this.add(greenMessage);
		Timer.delay(() ->
		{
			pinkMessage.showMessage("Let's goooo!!!");
			rocketSound.play();
			FlxG.camera.shake(0.005, 1.5, () ->
			{
				pinkMessage.hideMessage();
				if (Registry.gotBear)
					greenMessage.showMessage("YOU FOUND MR. BEAR!!!");
				else
					greenMessage.showMessage("Where is my plushie?...");
				emitter1.start(false, 0.015, 0);
				emitter2.start(false, 0.015, 0);
				trace('emitter1 ${emitter1.x}, ${emitter1.y}');
				FlxG.camera.shake(0.01, 5);
				Timer.delay(() ->
				{
					greenMessage.hideMessage();
					if (Registry.gotBear)
						greenMessage.showMessage("YOU'RE THE BEST!!!");
					else
						greenMessage.showMessage("MR. BEAR NOOOOOO!!!");
					FlxG.camera.fade(FlxColor.BLACK, () ->
					{
						FlxG.switchState(new EndState());
					});
					rocketSound.fadeOut(1);
				}, 5000);
			});
		}, 1000);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
