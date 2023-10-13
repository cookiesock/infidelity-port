// TRANSITION CODE BY NE_EO

var shar = new CustomShader("trans");

function create() {
	transitionTween.cancel();

	remove(blackSpr);
	remove(transitionSprite);

	transitionCamera.scroll.y = 0;

	transitionCamera.addShader(shar);

	var from = newState != null ? 0 : 1;
	var to = newState != null ? 1 : 0;
	shar.apply = from;
	FlxTween.num(from, to, 2/3, {ease: FlxEase.quadInOut}, (val:Float) -> {shar.apply = val;});

	new FlxTimer().start(2/3, ()-> {finish();});
}