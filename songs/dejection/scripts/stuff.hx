import openfl.filters.ShaderFilter;

public var shader:CustomShader;
public var distortion:CustomShader;

function postCreate() {
	shader = new CustomShader('brightness-contrast');
	shader.brightness = -0.25;
	shader.contrast = 1.5625;
	FlxG.camera.addShader(shader);

	distortion = new CustomShader('distortion');
	distortion.iTime = 0;
	distortion.glitchModifier = 0.25;
	distortion.moveScreenFullX = false;
	distortion.moveScreenX = true;
	distortion.moveScreenFullY = false;
	distortion.fullglitch = 0;
	distortion.working = false;
	distortion.timeMulti = 1.;
	distortion.effectMulti = 0.25;
	distortion.iResolution = [FlxG.width, FlxG.height];
	FlxG.camera.addShader(distortion);
}

function shadertween(f) shader.contrast = f;

var dumbstupid:Float = 0;
function update(elapsed) {
    dumbstupid += elapsed;
    distortion.iTime = dumbstupid;
	distortion.iResolution = [FlxG.width, FlxG.height];
}

function stepHit() {
	switch(curStep) {
		case 640: FlxTween.num(1.5625, 1.125, 3.38, {ease: FlxEase.cubicInOut}, shadertween);
		case 656: distortion.working = true;
	}
}