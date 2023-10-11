var camBars:FlxCamera;

function postCreate() {
    FlxG.camera.fade(0xFF000000, 0.001, false, null, true);

    cameraProperties.dad.zoom = cameraProperties.boyfriend.zoom = FlxG.camera.zoom = 0.65;

    camBars = new FlxCamera();
	camBars.bgColor = 0;
    FlxG.cameras.remove(camHUD, false);
	FlxG.cameras.add(camBars, false);
	FlxG.cameras.add(camHUD, false);

    for (i in 0...2) {
        var bar = new FlxSprite().makeSolid(1, 1, 0xFF000000);
        bar.scale.set(FlxG.width, FlxG.height / 7);
        bar.cameras = [camBars];
        bar.updateHitbox();
        bar.y = i==0 ? 0 : FlxG.height-(bar.height);
        add(bar);
    }
}

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
    }