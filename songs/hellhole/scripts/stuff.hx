function postCreate()
    gf.alpha = 0.001;

function stepHit()
    switch(curStep) {
        case 1312:
            FlxTween.tween(camHUD, {alpha: 0.001}, 1);
        case 1328:
            addCinematicBars(1, 7, FlxEase.circInOut);
            strumLines.members[0].visible = false;
            strumLines.members[2].visible = true;
        case 1340:
            gf.alpha = 1;
        case 1344:
            FlxTween.tween(camHUD, {alpha: 1}, 0.5);
            cameraProperties.zoomMultiplier = 1.5;
        case 1856:
            strumLines.members[0].visible = true;
            strumLines.members[2].visible = false;
        case 1872:
            gf.alpha = 0.001;
    }