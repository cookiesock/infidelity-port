function onEvent(_) {
    if (_.event.name == 'Tween Camera Zoom') {
        var time = _.event.params[1].split(':');
        var finalTime = (Conductor.stepCrochet*time[0])/1000 +
            (Conductor.stepCrochet*(time[1]*4))/1000 +
            (Conductor.stepCrochet*(time[2]*16))/1000;
        
        var eventEase = switch(_.event.params[2]) {
            case 'In': FlxEase.circIn;
            case 'Out': FlxEase.circOut;
            case 'Both': FlxEase.circInOut;
        };
        
        FlxTween.cancelTweensOf(FlxG.camera, ['zoom']);
        switch(_.event.params[3]) {
            case 'Boyfriend': FlxTween.tween(FlxG.camera, {zoom: _.event.params[0]}, finalTime, {ease: eventEase, onUpdate: function(value) {cameraProperties.boyfriend.zoom = FlxG.camera.zoom;}});
            case 'Girlfriend': FlxTween.tween(FlxG.camera, {zoom: _.event.params[0]}, finalTime, {ease: eventEase, onUpdate: function(value) {cameraProperties.gf.zoom = FlxG.camera.zoom;}});
            case 'Dad': FlxTween.tween(FlxG.camera, {zoom: _.event.params[0]}, finalTime, {ease: eventEase, onUpdate: function(value) {cameraProperties.dad.zoom = FlxG.camera.zoom;}});
            case 'All': FlxTween.tween(FlxG.camera, {zoom: _.event.params[0]}, finalTime, {ease: eventEase, onUpdate: function(value) {cameraProperties.boyfriend.zoom = cameraProperties.gf.zoom = cameraProperties.dad.zoom = FlxG.camera.zoom;}});
        }
    }
}