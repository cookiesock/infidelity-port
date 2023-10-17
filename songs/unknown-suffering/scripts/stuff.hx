function postCreate() {
    FlxG.camera.fade(0xFF000000, 0.001, false, null, true);

    cameraProperties.dad.zoom = cameraProperties.boyfriend.zoom = FlxG.camera.zoom = 0.65;

    addCinematicBars(0.001, {ease: null, size: 7});
}

function onSongStart()
    songLength = 121 * 1000;

function onEvent(_)
    if (_.event.name == 'Bump Camera' && curStep < 256)
        cameraProperties.dad.zoom = cameraProperties.boyfriend.zoom = FlxG.camera.zoom = FlxG.camera.zoom + _.event.params[0];

function stepHit()
    switch(curStep) {
        case 224:
            cameraProperties.dad.x -= 150;
            cameraProperties.dad.y -= 100;
        case 256:
            cameraProperties.dad.x += 150;
            cameraProperties.dad.y += 50;
        case 1616:
            FlxTween.num(songLength, inst.length, 10, {ease: FlxEase.circInOut}, function(num) {songLength = num;});
            for (i in [healthBar, healthBarBG, iconP1, iconP2, scoreGroup])
                FlxTween.tween(i, {alpha: 0.001}, 1);
        case 1744:
            for (i in [healthBar, healthBarBG, iconP1, iconP2, scoreGroup])
                FlxTween.tween(i, {alpha: 1}, 0.2);
        case 2260: FlxTween.tween(camHUD, {alpha: 0.001}, 1);
    }