import funkin.backend.MusicBeatState;

function preStateSwitch()
    if (FlxG.game._requestedState is MusicBeatState)
        FlxG.game._requestedState.scriptName = 'DefaultStateMods';