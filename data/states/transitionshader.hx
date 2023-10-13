import funkin.editors.ui.UISlider;
import funkin.editors.ui.UIState;

var shar = new CustomShader("trans");

function create() {
    var bg = new FlxSprite().makeSolid(FlxG.height, FlxG.height, 0xFFB494AC);
    bg.screenCenter();
    bg.shader = shar;
    add(bg);

    var playBackSlider = new UISlider(FlxG.width - 160 - 26 - 20, (23/2) - (12/2), 160, 1, [{start: 0, end: 1, size: 1}], false);
    playBackSlider.onChange = function(v) {
        shar.apply = v;
    };
    add(playBackSlider);
}

function update(elapsed) {
    if (FlxG.keys.justPressed.EIGHT)
        FlxG.switchState(new UIState(true, 'transitionshader'));

    if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new PlayState());
}