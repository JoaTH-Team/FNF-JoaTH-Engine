package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class MainMenuState extends MusicBeatState
{
	public var curSelected:Int = 0;
	public var optionsSelect:Array<String> = ["story mode", "freeplay", "options"];
	public var magenta:FlxSprite;
	public var camFollow:FlxObject;
	public var menuItems:FlxTypedGroup<FlxSprite>;

	public static var instance:MainMenuState = null;

	override function create()
	{
		instance = this;
		super.create();
		for (i in 0...scriptArray.length)
		{
			scriptArray[i].setVar("mainMenuState", instance);
		}

		persistentUpdate = persistentDraw = true;
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image("menuBG"));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image("menuDesat"));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xFFfd719b;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var startY:Float = (FlxG.height - (optionsSelect.length * 160)) / 2;
		var itemHeight:Float = Math.min(160, FlxG.height / optionsSelect.length);

		for (i in 0...optionsSelect.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, startY + (i * itemHeight));
			menuItem.frames = Paths.getSparrowAtlas("FNF_main_menu_assets");
			menuItem.animation.addByPrefix('idle', optionsSelect[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionsSelect[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(10, FlxG.height - 24, 0, "JoaTH Engine v" + FlxG.stage.application.meta.get("version"), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		changeItem();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.justPress(UP) || controls.justPress(DOWN))
			changeItem(controls.justPress(UP) ? -1 : 1);

		if (controls.justPress(ENTER))
		{
			switch (optionsSelect[curSelected])
			{
				case "freeplay":
					switchState(new FreeplayState());
				case "options":
					switchState(new OptionsState());
			}
		}

		if (controls.justPress(SEVEN))
			switchState(new EditorState());

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}