import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;

var lyrics:FlxText;
var lyricsBG:FlxSprite;

function postCreate() {
    lyricsBG = new FlxSprite().makeSolid(1, 1, 0xFF000000);
	lyricsBG.cameras = [camHUD];
	lyricsBG.alpha = 0.5;
	add(lyricsBG);

	lyrics = new FlxText(0, 0, -1, '', 24, true);
	lyrics.cameras = [camHUD];
	lyrics.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xFF000000, 2.5);
	lyrics.color = 0xFFFFFFFF;
	lyrics.font = 'assets/fonts/vcr.ttf';
	add(lyrics);
}

function onEvent(_) {
	switch(_.event.name) {
		case "Lyrics":
			if (_.event.params[0] != '') {
				lyrics.clearFormats();
				lyrics.text = _.event.params[1] != null ? StringTools.replace(_.event.params[0], "$", "") : _.event.params[0];
				lyrics.updateHitbox();
				lyrics.screenCenter();
				lyrics.y += 150;

				lyricsBG.setGraphicSize(lyrics.width + 10, lyrics.height + 10);
				lyricsBG.setPosition(lyrics.x - 5, lyrics.y - 5);
				lyricsBG.updateHitbox();

				lyricsBG.alpha = 0.5;
				lyrics.alpha = 1;

				if (_.event.params[1] != null) lyrics.applyMarkup(_.event.params[0], [new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.fromString(_.event.params[1])), "$")]);
			} else {
				lyricsBG.alpha = 0.001;
				lyrics.alpha = 0.001;
			}
	}
}