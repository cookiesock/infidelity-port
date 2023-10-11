import openfl.filters.ShaderFilter;

public var distortion:CustomShader;

function postCreate() {
    distortion = new CustomShader('distortion');
	distortion.iTime = 0;
	distortion.glitchModifier = 1;
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

var dumbstupid:Float = 0;
function update(elapsed) {
    dumbstupid += elapsed;
    distortion.iTime = dumbstupid;
	distortion.iResolution = [FlxG.width, FlxG.height];
}

function stepHit() {
    switch(curStep) {
        case 542: distortion.working = true;
        case 670: distortion.working = false;
    }
}