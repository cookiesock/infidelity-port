if (FlxG.save.data.infidelityFLASH) disableScript();

function onEvent(_)
    if (_.event.name == 'Flash Camera') {
		switch(_.event.params[3]) {
            default:
                FlxG.camera.fade(0xFF000000, 0.000001, true);
				FlxG.camera.flash(FlxColor.fromString(_.event.params[0]), Std.parseFloat(_.event.params[1]), _.event.params[2]);
			case 'camGame' || null:
				FlxG.camera.fade(0xFF000000, 0.000001, true);
				FlxG.camera.flash(FlxColor.fromString(_.event.params[0]), Std.parseFloat(_.event.params[1]), _.event.params[2]);
			case 'camHUD':
				camHUD.fade(0xFF000000, 0.000001, true);
				camHUD.flash(FlxColor.fromString(_.event.params[0]), Std.parseFloat(_.event.params[1]), _.event.params[2]);
		}
    }