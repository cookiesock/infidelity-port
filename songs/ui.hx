import flixel.ui.FlxBarFillDirection;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;

public var songLength:Float = 0;
public var scoreSideTxt:FlxText;
public var ratingsTxt:FlxText;
public var songTxt:FlxText;

public var scoreGroup:FlxGroup;

function postCreate() {
	scoreGroup = new FlxGroup();

	timeBarBG = new FlxSprite(0, FlxG.height-22).makeSolid(1, 1, 0xFF000000);
	timeBarBG.setGraphicSize(FlxG.width, 22);
	timeBarBG.scrollFactor.set();
	timeBarBG.updateHitbox();
	add(timeBarBG);

	timeTxt = new FlxText(0, timeBarBG.y - 32, 400, "", 20);
	timeTxt.setFormat('assets/fonts/MilkyNice.ttf', 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	timeTxt.borderSize = 3;
	timeTxt.screenCenter(FlxAxes.X);

	timeBar = new FlxBar(timeBarBG.x + 5, timeBarBG.y + 5, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 10), 13, null, '', 0, 1);
	timeBar.scrollFactor.set();
	timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
	timeBar.numDivisions = 80000;
	timeBar.unbounded = true;
	timeBar.screenCenter(FlxAxes.X);
	add(timeBar);
	add(timeTxt);

	songTxt = new FlxText(25, timeBarBG.y - 50, 0, PlayState.SONG.meta.displayName, 21);
	songTxt.setFormat('assets/fonts/MilkyNice.ttf', 21, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	songTxt.scrollFactor.set();
	songTxt.borderSize = 3;
	scoreGroup.add(songTxt);

	scoreSideTxt = new FlxText(25, timeBarBG.y - 45 - (29 * 3), 0, "Score: 0\nMisses: 0\nAccuracy: N/A", 21);
	scoreSideTxt.setFormat('assets/fonts/MilkyNice.ttf', 21, FlxColor.WHITE, 'left', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	scoreSideTxt.borderSize = 3;
	scoreGroup.add(scoreSideTxt);

	ratingsTxt = new FlxText(FlxG.width - 25, scoreSideTxt.y, 0, "Sick: 0\nGood: 0\nBad: 0\nShit: 0", 21);
	ratingsTxt.setFormat('assets/fonts/MilkyNice.ttf', 21, FlxColor.WHITE, 'right', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	ratingsTxt.borderSize = 3;
	ratingsTxt.x = FlxG.width - ratingsTxt.width - 25;
	scoreGroup.add(ratingsTxt);

	add(scoreGroup);

	scoreGroup.cameras = [camHUD];
	timeBarBG.cameras = [camHUD];
	timeBar.cameras = [camHUD];
	timeTxt.cameras = [camHUD];

	remove(scoreTxt);
	remove(missesTxt);
	remove(accuracyTxt);

	for (i in [healthBarBG, healthBar, iconP1, iconP2]) {
		i.y -= 30;
		i.cameras = [camHUD];
	}

	comboRatings = [];

	songLength = inst.length;
}

var sicks:Int = 0;
var goods:Int = 0;
var bads:Int = 0;
var shits:Int = 0;

function update(elapsed:Float) {
	scoreSideTxt.text = 'Score: ' + songScore + '\n' +
						'Misses: ' + misses + '\n' +
						'Accuracy: ' + (FlxMath.roundDecimal(accuracy * 100, 2) == -100 ? "N/A" : FlxMath.roundDecimal(accuracy * 100, 2) + '%');
	if (curStep >= 1)
		timeTxt.text = CoolUtil.timeToStr(Conductor.songPosition).split('.')[0] + ' - ' + CoolUtil.timeToStr(songLength).split('.')[0];
	timeBar.percent = (Conductor.songPosition/songLength)*100;

	ratingsTxt.text = 'Sick: '+sicks+'\n'+
					  'Good: '+goods+'\n'+
					  'Bad: '+bads+'\n'+
					  'Shit: '+shits+'\n';
	// ratingsTxt.x = FlxG.width - ratingsTxt.width - 25;
}

function onPlayerHit(event:NoteHitEvent) {
	// im not putting the ratings and shit on the hud. if i ever do that i need someone to kill me
	event.ratingScale = 0;
	event.numScale = 0;
	if (!event.note.isSustainNote) {
		switch (event.rating) {
			case 'sick': sicks++;
			case 'good': goods++;
			case 'bad': bads++;
			case 'shit': shits++;
		}
	}
}