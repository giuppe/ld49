package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import haxe.Timer;

class StartCinematicState extends FlxState
{
	var pinkMessage:ScreenMessage = new ScreenMessage();
	var greenMessage:ScreenMessage = new ScreenMessage();
	var blueMessage:ScreenMessage = new ScreenMessage();
	var pinkPlayer:FlxSprite = new FlxSprite();
	var greenPlayer:FlxSprite = new FlxSprite();
	var bluePlayer:FlxSprite = new FlxSprite();

	var GREEN = 0x6abe30;
	var RED = 0xd95763;
	var BLUE = 0x5fcde4;

	override public function create()
	{
		pinkMessage.color = RED;
		greenMessage.color = GREEN;
		blueMessage.color = BLUE;

		pinkPlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		pinkPlayer.color = RED;
		greenPlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		greenPlayer.color = GREEN;
		bluePlayer.loadGraphic("assets/images/Sprite-0001-Sheet.png", true, 32, 32);
		bluePlayer.color = BLUE;
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
		}

		this.add(levels[0]);
		this.add(pinkPlayer);
		this.add(greenPlayer);
		this.add(bluePlayer);

		this.add(foregrounds[0]);
		this.add(pinkMessage);
		this.add(greenMessage);
		this.add(blueMessage);
		Timer.delay(() ->
		{
			greenMessage.showMessage("The planet is imploding");
			greenMessage.hideMessage();
			pinkMessage.showMessage("We have to go! Now!");
			pinkMessage.hideMessage();
			blueMessage.showMessage("Wait, I forgot my cards!");
			blueMessage.hideMessage();
			greenMessage.showMessage("Have you seen Mr. Bear?");
			greenMessage.hideMessage();
			FlxG.camera.shake(0.005, 1.5, () ->
			{
				pinkMessage.hideMessage();
				if (Registry.gotBear)
					greenMessage.showMessage("YOU FOUND MR. BEAR!!!");
				else
					greenMessage.showMessage("Where is my plushie?...");

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
						FlxG.switchState(new PlayState());
					});
				}, 5000);
			});
		}, 1000);
	}
}
