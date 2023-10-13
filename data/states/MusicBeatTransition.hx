function create() {
    transitionTween.cancel();

    remove(blackSpr);
    remove(transitionSprite);
    transitionSprite.frames = Paths.getSparrowAtlas('menus/wiTransition');
    transitionSprite.animation.addByPrefix('in', 'kevin_normal', 24, false);
    transitionSprite.animation.addByPrefix('out', 'kevin_normal', 24, false);
    transitionSprite.scale.set(2,2);
    transitionSprite.updateHitbox();
    transitionSprite.cameras = [transitionCamera];
    transitionSprite.screenCenter();
    transitionSprite.x -= 80;
    transitionSprite.y -= newState != null ? 50 : -50;
    transitionSprite.animation.play(newState != null ? 'out' : 'in', true, newState != null ? false : true);
    add(transitionSprite);

    transitionCamera.scroll.y = 0;

    new FlxTimer().start(2/3, ()-> {finish();});
}