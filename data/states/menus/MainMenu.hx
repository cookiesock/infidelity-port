import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import flixel.group.FlxSpriteGroup;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;

var optionShit:Array<String> = [
    'story_mode',
    'freeplay',
    'credits',
    'discord',
    'options'
];

var menuItems:FlxSpriteGroup;

var curSelected:Int = 0;
var selectedSomethin:Bool = false;

// var bloom:CustomShader = new CustomShader('bloom');
// var chrom:CustomShader = new CustomShader('chromatic-aberration');

function postCreate() {
	CoolUtil.playMenuSong();
    
    window.title = "Wednesday's Infidelity - Main Menu";

    // bloom.Size = 5.0;
    // FlxG.camera.addShader(bloom);

    menuItems = new FlxSpriteGroup();

    var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/main-menu/menuBG'));
	bg.scrollFactor.set(0, Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1));
	add(bg);

	for (i in 0...optionShit.length) {
        var menuItem:FlxSprite = new FlxSprite(150 + (30 * i), 50 + (70 * i));
        menuItem.frames = Paths.getSparrowAtlas('menus/main-menu/menu_' + optionShit[i]);
        menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
        menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
        menuItem.animation.play('idle');
        menuItem.ID = i;
        menuItems.add(menuItem);
        var scr:Float = (optionShit.length - 2) * 0.135;
        if (optionShit.length < 4)
            scr = 0;
        menuItem.scrollFactor.set(0, scr);
        menuItem.antialiasing = true;

        if (optionShit[i] == 'credits')
            menuItem.y -= 10;
    }

    add(menuItems);

    changeItem(0);

    FlxG.camera.shake(0.001, 99999999999);
}

function update(elapsed) {
    if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new TitleState());
    if (FlxG.keys.justPressed.EIGHT) FlxG.switchState(new MainMenuState());
    if (FlxG.keys.justPressed.SEVEN) {
        persistentUpdate = false;
        persistentDraw = true;
        openSubState(new EditorPicker());
    }

    if (controls.SWITCHMOD) {
        openSubState(new ModSwitchMenu());
        persistentUpdate = false;
        persistentDraw = true;
    }

    if (!selectedSomethin) {
        if (controls.UP_P) {
            CoolUtil.playMenuSFX(0, 0.7);
            changeItem(-1);
        }

        if (controls.DOWN_P) {
            CoolUtil.playMenuSFX(0, 0.7);
            changeItem(1);
        }

        if (controls.ACCEPT) {
            if (optionShit[curSelected] == 'discord')
                FlxG.openURL('https://discord.gg/engUJd9RTA');
            else {
                selectedSomethin = true;
                CoolUtil.playMenuSFX(1, 0.7);

                menuItems.forEach(function(spr:FlxSprite) {
                    if (curSelected != spr.ID) {
                        FlxTween.tween(spr, {alpha: 0}, 0.4, {
                            ease: FlxEase.quadOut,
                            onComplete: function(twn:FlxTween) {
                                spr.kill();
                            }
                        });
                    }
                    else {
                        FlxTween.tween(FlxG.camera, {zoom: 2.1}, 2, {ease: FlxEase.expoInOut});
                        FlxG.camera.shake(0.008, 0.08);

                        FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker) {
                            switchState();
                        });
                    }
                });
            }
        }
    }
}

function changeItem(huh:Int = 0) {
    curSelected += huh;

    if (curSelected >= menuItems.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = menuItems.length - 1;

    menuItems.forEach(function(spr:FlxSprite) {
        spr.animation.play('idle');
        spr.offset.y = 0;
        spr.updateHitbox();

        if (spr.ID == curSelected) {
            spr.animation.play('selected');
            FlxG.camera.flash(FlxColor.BLACK, 0.2, null, true);
            spr.offset.x = 0.15 * (spr.frameWidth / 2 + 180);
            spr.offset.y = 0.15 * spr.frameHeight;
        }
    });
}

function switchState() {
    window.title = "Wednesday's Infidelity";
    var daChoice:String = optionShit[curSelected];

    switch (daChoice) {
        case 'story_mode':
            FlxG.switchState(new StoryMenuState());
        case 'freeplay':
            FlxG.switchState(new FreeplayState());
        case 'options':
            FlxG.switchState(new OptionsMenu());
    }
}