import funkin.editors.ui.UIState;

function update(elapsed)
    if (FlxG.keys.justPressed.EIGHT)
        FlxG.switchState(new UIState(true, 'transitionshader'));