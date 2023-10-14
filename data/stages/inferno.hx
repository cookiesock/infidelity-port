import flixel.math.FlxRect;

var infernogroundp2:FlxSprite;

function postCreate() {
    cameraProperties.dad.x = 220.95;
    cameraProperties.dad.y = 513;

    cameraProperties.boyfriend.x = 952.9;
    cameraProperties.boyfriend.y = 650;

    cameraProperties.gf.x = 600;
    cameraProperties.gf.y = 100;
    cameraProperties.gf.zoom = 0.5;

    exactSetGraphicSize(infernosky, infernosky.width * 1.3, infernosky.height * 1.3);
    exactSetGraphicSize(background, background.width * 1.3, background.height * 1.3);

    infernogroundp2 = infernogroundp1.clone();
    insert(members.indexOf(gf)+1, infernogroundp2);

    exactSetGraphicSize(infernogroundp1, infernogroundp1.width * 1.3, infernogroundp1.height * 1.3);
    exactSetGraphicSize(infernogroundp2, infernogroundp2.width * 1.3, infernogroundp2.height * 1.3);

    infernogroundp2.setPosition(infernogroundp1.x, infernogroundp1.y);
    infernogroundp2.clipRect = new FlxRect(infernogroundp2.width/2.5-250, 0, infernogroundp2.width/2+500, infernogroundp2.height);
}