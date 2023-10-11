// WHY IS THIS BEING A BITCH

import funkin.backend.system.Conductor;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;
import Math;

public var syringehits:Int = 0;
var shits:Array = [];
var played:Bool = false;
var canDodge:Bool = false;
var dodged:Bool = false;
var warned:Bool = false;

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

			shits.push([event, spr, timerbar, finalTime]);
		}
}

function update(elapsed) {
    if (canDodge && FlxG.keys.justPressed.SPACE) {
		dodged = true;
		canDodge = false;
	}

    for (event in shits) {
        // initial warning
        
		if (Conductor.songPosition >= (event[0].time - event[3]) && !warned) {
			event[1].alpha = 1;
			event[1].animation.play('anim', true);
			FlxG.sound.play(Paths.sound('mechanics/Warning'));
			FlxTween.tween(event[2], {value: 1}, event[3], {ease: FlxEase.quadIn});
			FlxTween.tween(event[2], {alpha: 1}, step*2, {ease: FlxEase.quadInOut});
			warned = true;
		}

        if (Conductor.songPosition >= (event[0].time - step*2) && (!canDodge && !dodged)) {
            canDodge = true;
			event[2].color = 0xFFFF0000;
            trace('dick');
            // new FlxTimer().start(step*4, function(timer) {
            //     event[2].color = 0xFF000000;

            //     if (!dodged) {
			// 		boyfriend.playAnim('at', true);
			// 		health /= 2;
			// 		syringehits++;

			// 		for (strum in playerStrums.members) {
			// 			// random sharp pain in my left hand lets go
			// 			FlxTween.shake(strum, 0.05, step, FlxAxes.XY, {onComplete: function() {
			// 				var numberOfTheDay:Float = 7;
			// 				strum.x += FlxG.random.float(-numberOfTheDay, numberOfTheDay);
			// 				strum.y -= FlxG.random.float(-numberOfTheDay, numberOfTheDay);
			// 				strum.angle = FlxG.random.float(-numberOfTheDay, numberOfTheDay);
			// 				strum.noteAngle = FlxG.random.float(-numberOfTheDay, numberOfTheDay);
			// 			}});
			// 		}
			// 	} else boyfriend.playAnim('dodge', true);

			// 	FlxTween.tween(event[2], {alpha: 0.001}, step*2, {ease: FlxEase.quadInOut, onComplete: function() {
			// 		shits.remove(event);
			// 		played = false;
			// 		canDodge = false;
			// 		dodged = false;
			// 		warned = false;
			// 		remove(event[1]);
			// 		remove(event[2]);
			// 	}});
            // });
		}
    }
}

var nonolist = ['dodge', 'at'];
function onNoteHit(event)
	if (nonolist.contains(event.note.strumLine.characters[0].getAnimName()) && event.note.strumLine.characters[0].animation.curAnim.finished == false)
		event.cancelAnim();
