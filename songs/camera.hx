import flixel.graphics.frames.FlxAtlasFrames;

// public var dadCam:Array<Float> = [420.95, 513, 0.8];
// public var gfCam:Array<Float> = [0, 0, 0.65];
// public var bfCam:Array<Float> = [952.9, 550, 1];

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
	intenseZoom: false,
	zoomMultiplier: 1
};

public var noteMovementStrength:Float = 1;
public var camOther:FlxCamera;
public var grain:FlxSprite;
var locked:Bool = false;
var campositions:Array<Float> = [0,0];

function postCreate() {
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
		var stupid = (32*noteMovementStrength);
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

	// for (sl in strumLines.members)
	// 	for (character in sl.characters)	
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

function beatHit()
	if (Options.camZoomOnBeat && camZooming && FlxG.camera.zoom < maxCamZoom && curBeat % camZoomingInterval == 0 && cameraProperties.intenseZoom)
		FlxG.camera.zoom += (0.03 * cameraProperties.zoomMultiplier) * camZoomingStrength;