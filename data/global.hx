import funkin.backend.assets.ModsFolder;

import lime.graphics.Image;
import sys.io.File;

var redirectStates:Map<FlxState, String> = [
    MainMenuState => 'menus/MainMenu'
];

function preStateSwitch() {
    window.title = "Wednesday's Infidelity";
    window.setIcon(Image.fromBytes(File.getBytes('mods/' + ModsFolder.currentModFolder + '/images/icon.png')));

    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}