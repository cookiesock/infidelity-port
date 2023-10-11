function onEvent(_)
    if (_.event.name == 'defaultCamZoom')
        switch(_.event.params[1]) {
            case 'Boyfriend': cameraProperties.boyfriend.zoom = _.event.params[0];
            case 'Girlfriend': cameraProperties.gf.zoom = _.event.params[0];
            case 'Dad': cameraProperties.dad.zoom = _.event.params[0];
            case 'All': cameraProperties.boyfriend.zoom = cameraProperties.gf.zoom = cameraProperties.dad.zoom = _.event.params[0];
        }