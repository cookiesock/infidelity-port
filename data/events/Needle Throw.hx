// WHY IS THIS BEING A BITCH

import funkin.backend.system.Conductor;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import Math;

public var syringehits:Int = 0;
var shits:Array = [];
var canDodge:Bool = false;
var dodged:Bool = false;

var step:Float = 0;

function postCreate() {
    step = Conductor.stepCrochet/1000;

	for (event in events)
		if (event.name == 'Needle Throw') {
			var spr:FlxSprite = new FlxSprite();
			spr.frames = Paths.getSparrowAtlas('mechanics/needle/warning');
			spr.animation.addByPrefix('anim', 'Advertencia', 24, false);
			spr.animation.finishCallback = function(name) {remove(spr);};
			spr.cameras = [camHUD];
			spr.screenCenter();
			spr.alpha = 0.001;
			add(spr);

			var timerbar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, spr.width/4, 14, null, '', 0, 1);
			timerbar.scrollFactor.set();
			timerbar.createFilledBar(0xFF000000, 0xFFFFFFFF);
			timerbar.numDivisions = 80000;
			timerbar.unbounded = true;
			timerbar.screenCenter();
			timerbar.y -= 100;
			timerbar.alpha = 0.001;
			timerbar.cameras = [camHUD];
			add(timerbar);

            var values = event.params[0].split(':');
            var finalTime = (Conductor.stepCrochet*values[0])/1000 +
                (Conductor.crochet*(values[1]))/1000 +
                (Conductor.crochet*(values[2]*4))/1000;

			shits.push({
				event: event,
				warning: spr,
				bar: timerbar,
				finalTime: finalTime,
				warned: false,
				playedAnim: false
			});
		}

	FlxG.stage.addEventListener("keyDown", boobies);
}

function boobies(e) {
	if (canDodge && e.keyCode == 0x20) {
		dodged = true;
		canDodge = false;
		boyfriend.playAnim('dodge', true);
	}
}

function update(elapsed) {
    for (properties in shits) {
		if (Conductor.songPosition >= (properties.event.time - properties.finalTime*1000) && !properties.warned) {
			properties.warning.alpha = 1;
			properties.warning.animation.play('anim', true);
			FlxG.sound.play(Paths.sound('mechanics/Warning'));
			FlxTween.tween(properties.bar, {value: 1}, properties.finalTime, {ease: FlxEase.quadIn});
			FlxTween.tween(properties.bar, {alpha: 1}, step*2, {ease: FlxEase.quadInOut});
			properties.warned = true;
		}

		if (Conductor.songPosition >= (properties.event.time - Conductor.crochet) && !properties.playedAnim) {
			dad.playAnim('dodge', true);
			properties.playedAnim = true;
		}

        if (Conductor.songPosition >= (properties.event.time - step*2000) && (!canDodge && !dodged)) {
            canDodge = true;
			properties.bar.color = 0xFFFF0000;
            new FlxTimer().start(step*4, function(timer) {
                properties.bar.color = 0xFF000000;

                if (!dodged) {
					canDodge = false;
					boyfriend.playAnim('at', true);
					health /= 2;
					syringehits++;

					for (strum in playerStrums.members) {
						// random sharp pain in my left hand lets go
						FlxTween.shake(strum, 0.05, step, FlxAxes.XY, {onComplete: function() {
							var numberOfTheDay:Float = 7;
							strum.x += FlxG.random.float(-numberOfTheDay, numberOfTheDay);
							strum.y -= FlxG.random.float(-numberOfTheDay, numberOfTheDay);
							strum.angle = FlxG.random.float(-numberOfTheDay, numberOfTheDay);
							strum.noteAngle = FlxG.random.float(-numberOfTheDay, numberOfTheDay);
						}});
					}
				}

				FlxTween.tween(properties.bar, {alpha: 0.001}, step*2, {ease: FlxEase.quadInOut, onComplete: function() {
					shits.remove(properties);
					played = false;
					canDodge = false;
					dodged = false;
					warned = false;
					remove(properties.warning);
					remove(properties.bar);
				}});
            });
		}
    }
}

var nonolist = ['dodge', 'at'];
function onNoteHit(event)
	if (nonolist.contains(event.note.strumLine.characters[0].getAnimName()) && event.note.strumLine.characters[0].animation.curAnim.finished == false)
		event.cancelAnim();

function onDestroy()
	FlxG.stage.addEventListener("keyDown", boobies);