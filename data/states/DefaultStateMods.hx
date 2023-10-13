import funkin.backend.MusicBeatState;
import funkin.menus.PauseSubState;
import Type;

var transitionCamera:FlxCamera;
var transright:FlxSprite;
var nextState:FlxState;
var switching:Bool = false;

function create() {
    transitionCamera = new FlxCamera();
    transitionCamera.bgColor = 0;
    FlxG.cameras.add(transitionCamera, false);

    transright = new FlxSprite(0,0);
    transright.frames = Paths.getSparrowAtlas('menus/wiTransition');
    transright.animation.addByPrefix('in', 'kevin_normal', 24, false);
    transright.animation.addByPrefix('out', 'kevin_normal', 24, false);
    transright.scale.set(2,2);
    transright.updateHitbox();
    transright.cameras = [transitionCamera];
    transright.screenCenter(FlxAxes.XY);
    transright.x -= 80;
    transright.y -= 50;
    transright.animation.play('out', true, true);

    add(transright);

    PauseSubState.script = 'data/scripts/pause';
}

function onStateSwitch(event) {
    if (!switching) {
        if (!event.substate is PlayState)
            MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
        
        transright.animation.play('in', true);
        transright.animation.finishCallback = switchStuff;
        nextState = event.substate;
        event.cancel();
    }
}

function switchStuff(name) {
    switching = true;
    FlxG.switchState(nextState);
}