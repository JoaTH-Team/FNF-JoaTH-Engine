package;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import haxe.Json;

class TitleState extends MusicBeatState
{
	var titleJSON:Dynamic;
	var gfDance:FlxSprite;
	var logoBl:FlxSprite;

	override function create()
	{
		super.create();
		titleJSON = Json.parse(Paths.data("stuff/titleJSON.json"));
		new FlxTimer().start(1, function(timer:FlxTimer)
		{
			startIntro();
		});
	}

	function startIntro()
	{
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
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}