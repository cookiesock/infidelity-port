function postCreate()
    gf.alpha = 0.001;

function stepHit()
    switch(curStep) {
        case 1312:
            FlxTween.tween(camHUD, {alpha: 0.001}, 1);
            addCinematicBars(1, {ease: FlxEase.circOut, size: 7});
        case 1328:
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
            addCinematicBars(1, {ease: FlxEase.circIn, reverse: true});
        case 1876:
            gf.alpha = 0.001;
        case 2384:
            for (i in [scoreGroup, timeBar, timeBarBG, timeTxt])
                FlxTween.tween(i, {alpha: 0.001}, 1.5);
            addCinematicBars(1.5, {ease: FlxEase.circOut, size: 7});
            cameraProperties.boyfriend.y += 30;
            cameraProperties.dad.y += 30;
        case 2896:
            addCinematicBars(0.001, {ease: FlxEase.circIn, reverse: true});
            cameraProperties.boyfriend.y -= 30;
            cameraProperties.dad.y -= 30;
        case 2912:
            for (i in [scoreGroup, timeBar, timeBarBG, timeTxt])
                FlxTween.tween(i, {alpha: 1}, 1);
        case 3552:
            for (i in [scoreGroup, timeBar, timeBarBG, timeTxt])
                FlxTween.tween(i, {alpha: 0.001}, 1);
            addCinematicBars(1, {ease: FlxEase.circOut, size: 7});
            cameraProperties.boyfriend.y += 30;
            cameraProperties.dad.y += 30;
        case 3680: // IM GONNA CRY ITS SO SAD 😭
            FlxTween.tween(camHUD, {alpha: 0.001}, 1.4);
    }