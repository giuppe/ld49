package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;

class EndState extends FlxState
{
	override public function create()
	{
		var emitter = new FlxEmitter(580, 66);

		for (i in 0...1000)
		{
			var p = new FlxParticle();
			p.makeGraphic(2, 2, 0xFFFFFFFF);
			p.exists = false;
			emitter.add(p);
		}
		emitter.launchMode = FlxEmitterMode.CIRCLE;
		emitter.launchAngle.set(90, 270);
		emitter.acceleration.start.min.x = -550;
		emitter.acceleration.start.max.x = -600;
		emitter.acceleration.end.min.x = -11100;
		emitter.acceleration.end.max.x = -11200;
		// Add emitter to stage
		add(emitter);

		emitter.start(false, 0.01, 0);
		var emitter2 = new FlxEmitter(580, 180);

		for (i in 0...1000)
		{
			var p = new FlxParticle();
			p.makeGraphic(2, 2, 0xFFFFFFFF);
			p.exists = false;
			emitter2.add(p);
		}
		emitter2.launchMode = FlxEmitterMode.CIRCLE;
		emitter2.launchAngle.set(90, 270);
		emitter2.acceleration.start.min.x = -550;
		emitter2.acceleration.start.max.x = -600;
		emitter2.acceleration.end.min.x = -11100;
		emitter2.acceleration.end.max.x = -11200;
		// Add emitter to stage
		add(emitter2);

		emitter2.start(false, 0.01, 0);
		var endMessage = new ScreenMessage();
		var endMessage2 = new ScreenMessage();
		var endMessage3 = new ScreenMessage();
		var endMessage4 = new ScreenMessage();

		endMessage.showMessage("Made by kumber for Ludum Dare 49 - Theme: Unstable");
		endMessage2.showMessage("Thank you for playing!");
		endMessage3.showMessage("(You did not find Green's plushie)");
		endMessage2.y += 25;
		endMessage3.y += 50;
		// endMessage3.showMessage("You did not find the bear.");
		this.add(endMessage);
		this.add(endMessage2);
		this.add(endMessage3);
		var rocket = new FlxSprite();
		if (Registry.gotBear)
			rocket.loadGraphic(AssetPaths.endrocket_bear__png);
		else
			rocket.loadGraphic(AssetPaths.endrocket__png);
		this.add(rocket);
	}
}
