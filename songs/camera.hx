import flixel.graphics.frames.FlxAtlasFrames;

public var cameraProperties = {
	dad: {
		x: 420.95,
		y: 513,
		zoom: 0.8
	},
	gf: {
		x: 0,
		y: 0,
		zoom: 0.65
	},
	boyfriend: {
		x: 952.9,
		y: 550,
		zoom: 1
	},
	zoomMultiplier: 1
};

public var noteMovementStrength:Float = 1;
public var camOther:FlxCamera;
public var grain:FlxSprite;
var locked:Bool = false;
var campositions:Array<Float> = [0,0];
var shitZoom:Float = 0;

function postCreate() {
	shitZoom = FlxG.camera.zoom;

	camOther = new FlxCamera();
	camOther.bgColor = 0;
	FlxG.cameras.add(camOther, false);

	grain = new FlxSprite();
	grain.frames = Paths.getSparrowAtlas('effects/grain');
	grain.animation.addByPrefix('idle', 'grain', 24, true);
	grain.animation.play('idle', true);
	exactSetGraphicSize(grain, FlxG.width + 6, FlxG.height + 6);
	grain.screenCenter();
	grain.x += 3;
	grain.y += 3;
	grain.antialiasing = false;
	grain.cameras = [camOther];
	grain.alpha = 1;
	add(grain);

	var daStatic:FlxSprite = new FlxSprite(0, 0);
	daStatic.frames = Paths.getSparrowAtlas('effects/daSTAT');
	daStatic.setGraphicSize(FlxG.width, FlxG.height);
	daStatic.alpha = 0.05;
	daStatic.screenCenter();
	daStatic.cameras = [camOther];
	daStatic.animation.addByPrefix('static', 'staticFLASH', 24, true);
	add(daStatic);
	daStatic.animation.play('static');
}

function onSongStart() camZooming = true;

function postUpdate(elapsed) {
	if (startingSong) camGame.snapToTarget();

	if (!locked) {
		var stupid = (50*noteMovementStrength);
		switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
			case "singLEFT": camFollow.x -= stupid;
			case "singDOWN": camFollow.y += stupid;
			case "singUP": camFollow.y -= stupid;
			case "singRIGHT": camFollow.x += stupid;
		}
	}

	if (locked) {
		camFollow.x = campositions[0];
		camFollow.y = campositions[1];
	}
}

function onNoteHit(event) {
	if (event.character.xml.get('shake') == 'true') {
		FlxG.camera.shake(0.008, 0.2);
		camHUD.shake(0.006, 0.2);
	}
}


function onCameraMove(event) {
	switch(event.strumLine.data.position) {
		case 'boyfriend': event.position.set(cameraProperties.boyfriend.x, cameraProperties.boyfriend.y); defaultCamZoom = cameraProperties.boyfriend.zoom;
		case 'girlfriend': event.position.set(cameraProperties.gf.x, cameraProperties.gf.y); defaultCamZoom = cameraProperties.gf.zoom;
		case 'dad': event.position.set(cameraProperties.dad.x, cameraProperties.dad.y); defaultCamZoom = cameraProperties.dad.zoom;
	};
}

function onEvent(_)
	switch(_.event.name) {
		case "Camera Focus":
			locked = _.event.params[2];
			campositions = [Std.parseFloat(_.event.params[0]), Std.parseFloat(_.event.params[1])];
	}

function onCountdown(event) {
	FlxTween.completeTweensOf(FlxG.camera, ['zoom']);
	if (event.swagCounter > 3 || event.swagCounter == 0) return;
	FlxG.camera.zoom += 0.4;
	FlxTween.tween(FlxG.camera, {zoom: shitZoom}, 0.2, {ease: FlxEase.circOut});
}

function beatHit()
	if (Options.camZoomOnBeat && camZooming && FlxG.camera.zoom < maxCamZoom && curBeat % camZoomingInterval == 0)
		FlxG.camera.zoom += (0.03 * cameraProperties.zoomMultiplier) * camZoomingStrength;