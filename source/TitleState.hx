package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import haxe.Json;
import sys.io.File;

typedef TitleData =
{
	gfX:Float,
	gfY:Float,
	logoX:Float,
	logoY:Float,
	pressEnterX:Float,
	pressEnterY:Float
}

class TitleState extends MusicBeatState
{
	var titleJSON:TitleData;
	public var gfDance:FlxSprite;
	public var danceLeft:Bool = false;
	public var logoBl:FlxSprite;
	public var titleText:FlxSprite;
	public var titleTextEnter:Bool = false;

	public static var instance:TitleState = null;

	override function create()
	{
		instance = this;
		super.create();
		PolyHandler.reload();

		titleJSON = Json.parse(File.getContent(Paths.json("stuff/titleJSON")));
		for (i in 0...scriptArray.length)
		{
			scriptArray[i].setVar("titleState", instance);
		}
		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			startIntro();
		});
	}

	function startIntro()
	{
		FlxG.sound.playMusic(Paths.music("menu/freakyMenu"));
		Conductor.bpm = 102;
		logoBl = new FlxSprite(titleJSON.logoX, titleJSON.logoY);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		add(logoBl);

		gfDance = new FlxSprite(titleJSON.gfX, titleJSON.gfY);
		gfDance.frames = Paths.getSparrowAtlas("gfDanceTitle");
		gfDance.animation.addByIndices('danceLeft', 'gfDance', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
		gfDance.animation.addByIndices('danceRight', 'gfDance', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
		add(gfDance);
		titleText = new FlxSprite(titleJSON.pressEnterX, titleJSON.pressEnterY);
		titleText.frames = Paths.getSparrowAtlas("titleEnter");
		titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
		titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
		titleText.animation.play('idle');
		titleText.updateHitbox();
		add(titleText);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		super.update(elapsed);
		if (controls.press(ENTER))
		{
			titleTextEnter = true;
			titleText.animation.play('press');
			new FlxTimer().start(1, function(timer:FlxTimer)
			{
				switchState(new MainMenuState());
			});
		}
	}
	override function beatHit()
	{
		super.beatHit();

		danceLeft = !danceLeft;
		if (danceLeft)
			gfDance.animation.play('danceRight');
		else
			gfDance.animation.play('danceLeft');

		logoBl.animation.play("bump");
		if (!titleTextEnter)
			titleText.animation.play('idle');
		else
			titleText.animation.play('press');
	}
}