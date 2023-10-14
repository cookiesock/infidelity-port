function onEvent(_) {
	if (_.event.params[4] && FlxG.save.data.infidelityFLASH) return;
	
	if (_.event.name == 'Fade Camera')
		switch(_.event.params[3]) {
			default: FlxG.camera.fade(_.event.params[2], Std.parseFloat(_.event.params[0]), _.event.params[1], null, true);
			case 'camGame' || null: FlxG.camera.fade(_.event.params[2], Std.parseFloat(_.event.params[0]), _.event.params[1], null, true);
			case 'camHUD': camHUD.fade(_.event.params[2], Std.parseFloat(_.event.params[0]), _.event.params[1], null, true);
		}
}